// mint_nft.cdc
import UFC_NFT from 0xd049c2e1e3ec47da
import NonFungibleToken from 0x631e88ae7f1d7c20

transaction(recipient: Address, tokenId: UInt64, setId: UInt32, seriesId: UInt32) {
    let admin: &UFC_NFT.Admin
    let series: &UFC_NFT.Series
    let recipientCollection: &{NonFungibleToken.CollectionPublic}
    
    prepare(signer: auth(Storage) &Account) {
        // Get admin reference
        self.admin = signer.storage
            .borrow<&UFC_NFT.Admin>(from: UFC_NFT.AdminStoragePath)
            ?? panic("Could not borrow admin reference")
            
        // Borrow series reference
        self.series = self.admin.borrowSeries(seriesId: seriesId)
        
        // Get recipient's collection reference
        self.recipientCollection = getAccount(recipient)
            .capabilities
            .borrow<&{NonFungibleToken.CollectionPublic}>(UFC_NFT.CollectionPublicPath)
            ?? panic("Could not get recipient's collection reference")
    }

    execute {
        // Mint the NFT
        self.series.mintUFC_NFT(
            recipient: self.recipientCollection,
            tokenId: tokenId,
            setId: setId
        )
    }
}