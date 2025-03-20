// simple_create_series.cdc
import UFC_NFT from 0xd049c2e1e3ec47da

transaction(seriesId: UInt32) {
    let admin: &UFC_NFT.Admin
    
    prepare(signer: auth(Storage, Capabilities) &Account) {
        // Get admin reference
        self.admin = signer.storage
            .borrow<&UFC_NFT.Admin>(from: UFC_NFT.AdminStoragePath)
            ?? panic("Could not borrow admin reference")
            
        // Create metadata with hardcoded values
        let metadata: {String: String} = {
            "name": "UFC Series ".concat(seriesId.toString()),
            "description": "UFC NFT Series"
        }
        
        // Create the series
        self.admin.addSeries(seriesId: seriesId, metadata: metadata)
        
        // Borrow the series to get a reference
        let seriesRef = self.admin.borrowSeries(seriesId: seriesId)
        
        // Publish the public minting capability
        signer.capabilities.publish(
            signer.capabilities.storage.issue<&{UFC_NFT.MinterPublic}>(UFC_NFT.AdminStoragePath),
            at: UFC_NFT.MinterPublicPath
        )
    }

    execute {
        log("Series created and minting capability published")
    }
} 