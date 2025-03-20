// setup_collection.cdc
import UFC_NFT from 0xd049c2e1e3ec47da
import NonFungibleToken from 0x631e88ae7f1d7c20

transaction {
    prepare(signer: auth(Storage, Capabilities) &Account) {
        // Check if the collection already exists
        if signer.storage.borrow<&UFC_NFT.Collection>(from: UFC_NFT.CollectionStoragePath) == nil {
            // Create a new empty collection
            let collection <- UFC_NFT.createEmptyCollection(nftType: Type<@UFC_NFT.NFT>())
            
            // Save it to the account
            signer.storage.save(<-collection, to: UFC_NFT.CollectionStoragePath)

            // Create a public capability for the collection
            signer.capabilities.publish(
                signer.capabilities.storage.issue<&UFC_NFT.Collection>(UFC_NFT.CollectionStoragePath),
                at: UFC_NFT.CollectionPublicPath
            )
        }
    }
}