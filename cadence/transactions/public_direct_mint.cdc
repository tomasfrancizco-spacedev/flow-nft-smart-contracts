// public_direct_mint.cdc
import UFC_NFT from 0xd049c2e1e3ec47da
import NonFungibleToken from 0x631e88ae7f1d7c20

transaction(recipient: Address, tokenId: UInt64, seriesId: UInt32, setId: UInt32) {
    let recipientCollection: &{NonFungibleToken.CollectionPublic}
    
    prepare(signer: auth(Storage) &Account) {
        // Get recipient's collection reference
        self.recipientCollection = getAccount(recipient)
            .capabilities
            .borrow<&{NonFungibleToken.CollectionPublic}>(UFC_NFT.CollectionPublicPath)
            ?? panic("Could not get recipient's collection reference")
    }

    execute {
        // Call the public mint function directly on the contract
        UFC_NFT.publicMintNFT(
            recipient: self.recipientCollection,
            tokenId: tokenId,
            seriesId: seriesId,
            setId: setId
        )
        
        log("NFT minted directly to recipient using public function")
    }
} 