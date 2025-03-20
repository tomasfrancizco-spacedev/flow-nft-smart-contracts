// check_series_and_sets.cdc
import UFC_NFT from 0xd049c2e1e3ec47da

access(all) fun main(): {String: AnyStruct} {
    let result: {String: AnyStruct} = {}
    
    // Get all series
    let allSeries = UFC_NFT.getAllSeries()
    
    if allSeries.length == 0 {
        log("No series found")
        result["seriesCount"] = 0
        return result
    }
    
    log("Found ".concat(allSeries.length.toString()).concat(" series"))
    result["seriesCount"] = allSeries.length
    
    // Check details of each series
    let seriesInfo: [{String: AnyStruct}] = []
    
    for series in allSeries {
        let seriesId = series.seriesId
        let metadata = UFC_NFT.getSeriesMetadata(seriesId: seriesId) ?? {}
        
        // Get all sets for this series
        let allSets = UFC_NFT.getAllSets()
        var seriesSetCount = 0
        
        for set in allSets {
            if set.seriesId == seriesId {
                seriesSetCount = seriesSetCount + 1
            }
        }
        
        seriesInfo.append({
            "seriesId": seriesId,
            "metadata": metadata,
            "setCount": seriesSetCount
        })
    }
    
    result["series"] = seriesInfo
    
    // Also check all sets
    let allSets = UFC_NFT.getAllSets()
    log("Found ".concat(allSets.length.toString()).concat(" sets in total"))
    result["setsCount"] = allSets.length
    
    return result
} 