import Foundation
import CoreData

@objc(WhitelistProduct)

public final class WhitelistProduct: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<WhitelistProduct> {
        return NSFetchRequest<WhitelistProduct>(entityName: "WhitelistProduct")
    }

    @NSManaged public var identity: UInt64
}
