import Foundation

final class WishlistAndCartManager {
    
    static func isProductExist(where storage: Storage, _ productID: UInt64) -> Bool {
        return (UserDefaults.standard.array(forKey: storage.rawValue) as? [UInt64])?.contains(productID) ?? false
    }

    static func changeProductStatus(where storage: Storage, _ productID: UInt64) -> StorageResult {
        guard var allIDs = UserDefaults.standard.array(forKey: storage.rawValue) as? [UInt64] else {
            UserDefaults.standard.set([productID], forKey: storage.rawValue)
            return .added
        }
        
        var result: StorageResult
        
        if allIDs.contains(productID) {
            allIDs.removeAll(where: { $0 == productID })
            result = .removed
        } else {
            allIDs.append(productID)
            result = .added
        }
        UserDefaults.standard.set(allIDs, forKey: storage.rawValue)
        return result
    }
    
}
