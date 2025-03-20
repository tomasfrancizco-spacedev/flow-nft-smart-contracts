// check_minter_capability.cdc
import UFC_NFT from 0xd049c2e1e3ec47da

access(all) fun main(): Bool {
    let account = getAccount(0xd049c2e1e3ec47da)
    
    let capability = account.capabilities.get<&{UFC_NFT.MinterPublic}>(UFC_NFT.MinterPublicPath)
    
    if capability == nil {
        log("Minter capability not found at path: ".concat(UFC_NFT.MinterPublicPath.toString()))
        return false
    }
    
    let minter = capability!.borrow()
    if minter == nil {
        log("Could not borrow minter reference from capability")
        return false
    }
    
    log("Minter capability exists and can be borrowed")
    return true
} 