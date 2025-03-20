// publish_minter_capability.cdc
import UFC_NFT from 0xd049c2e1e3ec47da

transaction {
    prepare(signer: auth(Storage, Capabilities) &Account) {
        // Get admin reference
        let admin = signer.storage
            .borrow<&UFC_NFT.Admin>(from: UFC_NFT.AdminStoragePath)
            ?? panic("Could not borrow admin reference")
            
        // We need a series ID - getting first series (assuming it exists)
        // List all series to find a valid ID
        let allSeries = UFC_NFT.getAllSeries()
        if allSeries.length == 0 {
            panic("No series found. Please create a series first.")
        }
        
        let seriesId = allSeries[0].seriesId
        
        // Borrow the series
        let series = admin.borrowSeries(seriesId: seriesId)
        
        // Check if the capability already exists at the path
        if signer.capabilities.get<&{UFC_NFT.MinterPublic}>(UFC_NFT.MinterPublicPath) != nil {
            log("Minter capability already exists. Removing and republishing...")
            // If it exists, remove it first
            signer.capabilities.unpublish(UFC_NFT.MinterPublicPath)
        }
        
        // Publish the minter capability directly 
        log("Publishing minter capability for series: ".concat(seriesId.toString()))
        let cap = signer.capabilities.storage.issue<&{UFC_NFT.MinterPublic}>(UFC_NFT.AdminStoragePath)
        signer.capabilities.publish(cap, at: UFC_NFT.MinterPublicPath)
        
        log("Minter capability published. Verifying...")
        let published = signer.capabilities.get<&{UFC_NFT.MinterPublic}>(UFC_NFT.MinterPublicPath) != nil
        if published {
            log("Published: true")
        } else {
            log("Published: false")
        }
    }
} 