// update_set_metadata.cdc
import UFC_NFT from 0xd049c2e1e3ec47da

transaction(seriesId: UInt32, setId: UInt32) {
    let admin: &UFC_NFT.Admin
    let series: &UFC_NFT.Series
    
    prepare(signer: AuthAccount) {
        self.admin = signer.storage
            .borrow<&UFC_NFT.Admin>(from: UFC_NFT.AdminStoragePath)
            ?? panic("Could not borrow admin reference")
            
        self.series = self.admin.borrowSeries(seriesId: seriesId)
    }

    execute {
        let updatedMetadata: {String: String} = {
            "name": "UFC Fight Moments",
            "description": "Iconic UFC fight moments",
            "image": "https://updated-api.com/images/",
            "image_file_type": "mp4",
            "preview": "https://updated-api.com/previews/",
            "external_token_base_url": "https://updated-marketplace.com/tokens"
        }
        
        // Update the set metadata
        self.series.updateSetMetadata(
            setId: setId,
            maxEditions: 1000, // Keep the same max editions
            ipfsMetadataHashes: {}, // Update IPFS hashes if needed
            metadata: updatedMetadata
        )
    }
}