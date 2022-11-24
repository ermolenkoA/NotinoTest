import Foundation

final class WishlistAndCartManager {
    
    static func isProductExist(where storage: Storage, _ productID: String) -> Bool {
        (UserDefaults.standard.object(forKey: storage.rawValue) as? [String])?.contains(productID) ?? false
    }

    static func changeProductStatus(where storage: Storage, _ productID: String) -> StorageResult {
        guard var allIDs = UserDefaults.standard.object(forKey: storage.rawValue) as? [String] else {
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
