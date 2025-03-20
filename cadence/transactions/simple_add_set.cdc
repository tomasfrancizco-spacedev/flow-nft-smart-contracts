// simple_add_set.cdc
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
        // Create metadata with hardcoded values
        let metadata: {String: String} = {
            "name": "UFC Set ".concat(setId.toString()),
            "description": "First UFC NFT set"
        }
        
        // Create empty IPFS hashes
        let ipfsHashes: {UInt32: String} = {}
        
        // Add the NFT Set to the Series with hardcoded values
        self.series.addNftSet(
            setId: setId,
            maxEditions: 100,
            ipfsMetadataHashes: ipfsHashes,
            metadata: metadata
        )
        
        log("NFT Set added to series")
    }
} 