// check_set.cdc
import UFC_NFT from 0xd049c2e1e3ec47da

access(all) fun main(setId: UInt32): {String: String}? {
    return UFC_NFT.getSetMetadata(setId: setId)
}