import UIKit

// MARK: - Enums

enum Storage: String {
    case cart = "Cart"
    case wishlist = "Wishlist"
}

enum StorageResult {
    case added
    case removed
}

// MARK: - Structs

struct Font {
    static let SFRegular = "SFProDisplay-Regular"
    static let SFMedium = "SFProDisplay-Medium"
}

struct Images {
    static let star = "star"
    static let starFilled = "star-filled"
    static let heart = "heart"
    static let heartFilled = "heart-filled"
}

struct Color {
    static let borderColor = CGColor(gray: 229/255, alpha: 1)
    static let inkTertiary = UIColor(white: 120/255, alpha: 1)
    static let inkSecondary = UIColor(white: 51/255, alpha: 1)
}
