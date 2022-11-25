import Foundation

// MARK: - ProductModels

struct ProductModels: Decodable {
    let vpProductByIds: [ProductModel]
}

// MARK: - ProductModels

struct ProductModel: Decodable {
    let productId: UInt64
    let brand: Brand
    let annotation: String
    let price: Price
    let imageUrl: String
    let name: String
    let reviewSummary: Review
    
    init(productId: UInt64, brand: Brand, annotation: String, price: Price,
         imageUrl: String, name: String, reviewSummary: Review) {
        self.productId = productId
        self.brand = brand
        self.annotation = annotation
        self.price = price
        self.imageUrl = imageUrl
        self.name = name
        self.reviewSummary = reviewSummary
    }
    
    var about: String { """
   
   ProductModel:
        "productId" = \(productId),
        "brand" = \(brand.name),
        "annotation" = \(annotation),
        "price" = \(price.value),
        "imageUrl" = \(imageUrl),
        "name" = \(name),
        "reviewSummary" = \(reviewSummary.averageRating).
   
   """ }
    
    func getProduct() -> Product {
        let finalPrice = "\(price.value) Kč"
        let photo = PhotoManager.getPhotoByURL(imageUrl)
        return Product(id: productId, productImage: photo, brand: brand.name, productName: name,
                annatation: annotation, rating: reviewSummary.averageRating, price: finalPrice)
    }
}

// MARK: - Brand

struct Brand: Decodable {
    let name: String
}

// MARK: - Price

struct Price: Decodable {
    let value: UInt
}

// MARK: - Price

struct Review: Decodable {
    let averageRating: Float
}
