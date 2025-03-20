// add_set.cdc
import UFC_NFT from 0xd049c2e1e3ec47da

transaction(
    seriesId: UInt32, 
    setId: UInt32, 
    maxEditions: UInt32, 
    ipfsMetadataHashes: {UInt32: String}, 
    metadata: {String: String}
) {
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
        // Add the NFT Set to the Series
        self.series.addNftSet(
            setId: setId,
            maxEditions: maxEditions,
            ipfsMetadataHashes: ipfsMetadataHashes,
            metadata: metadata
        )
        
        log("NFT Set added to series")
    }
} 