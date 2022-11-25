import UIKit
import CoreData

final class WishlistAndCartManager {
    
    // MARK: - Private Properties
    
    private static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private static let context = appDelegate.persistentContainer.viewContext
    
    // MARK: - Public Functions
    
    public static func isProductExist(where storage: Storage, _ productID: UInt64) -> Bool {
        guard let idenities = try? context.fetch(storage == .cart
                                            ? CartProduct.fetchRequest()
                                                  : WhitelistProduct.fetchRequest()) else {
            return false
        }
        
        if storage == .cart {
            return (idenities as! [CartProduct]).contains(where: { $0.identity == productID })
        } else {
            return (idenities as! [WhitelistProduct]).contains(where: { $0.identity == productID })
        }
    }
    
    

    public static func changeCartStatus(_ productID: UInt64) -> StorageResult {
        guard let products = try? context.fetch(CartProduct.fetchRequest()) else {
            let product = CartProduct(context: context)
            product.identity = productID
            return .added
        }
 
        var result: StorageResult
        
        if let product = products.first(where: { $0.identity == productID }) {
            context.delete(product)
            result = .removed
        } else {
            let product = CartProduct(context: context)
            product.identity = productID
            context.insert(product)
            result = .added
        }
        appDelegate.saveContext()
        return result
    }
    
    public static func changeWhitelistStatus(_ productID: UInt64) -> StorageResult {
        guard let products = try? context.fetch(WhitelistProduct.fetchRequest()) else {
            let product = WhitelistProduct(context: context)
            product.identity = productID
            return .added
        }
 
        var result: StorageResult
        
        if let product = products.first(where: { $0.identity == productID }) {
            context.delete(product)
            result = .removed
        } else {
            let product = WhitelistProduct(context: context)
            product.identity = productID
            context.insert(product)
            result = .added
        }
        appDelegate.saveContext()
        return result
    }
    
}
