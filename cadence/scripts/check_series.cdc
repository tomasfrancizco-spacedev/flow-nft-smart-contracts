// check_series.cdc
import UFC_NFT from 0xd049c2e1e3ec47da

access(all) fun main(seriesId: UInt32): {String: String}? {
    return UFC_NFT.getSeriesMetadata(seriesId: seriesId)
}