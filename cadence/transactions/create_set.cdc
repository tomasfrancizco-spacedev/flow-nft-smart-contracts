// create_set.cdc
import UFC_NFT from 0xd049c2e1e3ec47da

transaction(seriesId: UInt32, setId: UInt32) {
    let admin: &UFC_NFT.Admin
    let series: &UFC_NFT.Series
    
    prepare(signer: auth(Storage) &Account) {
        // Get admin reference
        self.admin = signer.storage
            .borrow<&UFC_NFT.Admin>(from: UFC_NFT.AdminStoragePath)
            ?? panic("Could not borrow admin reference")
            
        // Borrow series reference
        self.series = self.admin.borrowSeries(seriesId: seriesId)
    }

    execute {
        // Define set metadata
        let metadata: {String: String} = {
            "name": "UFC Fight Moments",
            "description": "Iconic UFC fight moments",
            "image": "https://your-api.com/images/",  // Base URL for images
            "image_file_type": "mp4",  // For video NFTs
            "preview": "https://your-api.com/previews/",  // Preview image URL
            "external_token_base_url": "https://your-marketplace.com/tokens"
        }
        
        // Define IPFS hashes for each edition if using IPFS
        let ipfsHashes: {UInt32: String} = {
            1: "QmHash1...",
            2: "QmHash2..."
        }
        
        // Add the set to the series
        // maxEditions is the maximum number of NFTs that can be minted in this set
        self.series.addNftSet(
            setId: setId,
            maxEditions: 1000,
            ipfsMetadataHashes: ipfsHashes,
            metadata: metadata
        )
    }
}