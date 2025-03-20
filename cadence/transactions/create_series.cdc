// create_series.cdc
import UFC_NFT from 0xd049c2e1e3ec47da
import NonFungibleToken from 0x631e88ae7f1d7c20

transaction(seriesId: UInt32) {
    let admin: &UFC_NFT.Admin
    
    prepare(signer: auth(Storage) &Account) {
        // Get admin reference
        self.admin = signer.storage
            .borrow<&UFC_NFT.Admin>(from: UFC_NFT.AdminStoragePath)
            ?? panic("Could not borrow admin reference")
    }

    execute {
        // Create a new series with metadata
        let metadata: {String: String} = {
            "name": "UFC Series #1",
            "description": "First UFC NFT Series",
            "external_url": "https://ufc.com"
        }
        
        self.admin.addSeries(seriesId: seriesId, metadata: metadata)
    }
}