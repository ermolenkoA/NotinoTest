import Foundation
import CoreData

@objc(CartProduct)

public final class CartProduct: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartProduct> {
        return NSFetchRequest<CartProduct>(entityName: "CartProduct")
    }

    @NSManaged public var identity: UInt64
}
