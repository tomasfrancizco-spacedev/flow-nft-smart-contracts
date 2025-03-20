// direct_mint_nft.cdc
import UFC_NFT from 0xd049c2e1e3ec47da
import NonFungibleToken from 0x631e88ae7f1d7c20

transaction(recipient: Address, tokenId: UInt64, seriesId: UInt32, setId: UInt32) {
    let admin: &UFC_NFT.Admin
    let series: &UFC_NFT.Series
    let recipientCollection: &{NonFungibleToken.CollectionPublic}
    
    prepare(signer: auth(Storage) &Account) {
        // Get admin reference directly
        self.admin = signer.storage
            .borrow<&UFC_NFT.Admin>(from: UFC_NFT.AdminStoragePath)
            ?? panic("Could not borrow admin reference")
            
        // Borrow series reference directly
        self.series = self.admin.borrowSeries(seriesId: seriesId)
        
        // Get recipient's collection reference
        self.recipientCollection = getAccount(recipient)
            .capabilities
            .borrow<&{NonFungibleToken.CollectionPublic}>(UFC_NFT.CollectionPublicPath)
            ?? panic("Could not get recipient's collection reference")
    }

    execute {
        // Mint the NFT directly using series reference
        self.series.mintUFC_NFT(
            recipient: self.recipientCollection,
            tokenId: tokenId,
            setId: setId
        )
        
        log("NFT minted directly to recipient")
    }
} 