// check_nft.cdc
import UFC_NFT from 0xd049c2e1e3ec47da
import NonFungibleToken from 0x631e88ae7f1d7c20

access(all) fun main(address: Address): [UInt64] {
    let account = getAccount(address)
    
    let collection = account
        .capabilities
        .borrow<&{NonFungibleToken.CollectionPublic}>(UFC_NFT.CollectionPublicPath)
        ?? panic("Could not get public collection reference")
    
    return collection.getIDs()
}