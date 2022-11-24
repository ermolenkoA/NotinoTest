import Foundation

final class JSONManager {
    
     // MARK: - Private Properties
    
    private static let defaultSession = URLSession.shared
    private static var dataTask: URLSessionDataTask?
    private static let baseURL = "https://my-json-server.typicode.com/cernfr1993/notino-assignment/db"
    
    // MARK: - Public Functions

    public static func getData(_ completion: @escaping ([Product]?) -> Void) {
        guard let url = URL(string: baseURL) else {
            print("\n<JSONManager\\getData> ERROR: wrong URL - baseURL\n")
            completion(nil)
            return
        }
        
        defaultSession.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("\n<JSONManager\\getData> ERROR: \(error!.localizedDescription)\n")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            if let response = response {
                print("\n<JSONManager\\getData> RESPONSE: \(response.debugDescription)\n")

            }
            
            if let data = data {
                guard let result = try? JSONDecoder().decode(ProductModels.self, from: data) else {
                    print("\n<JSONManager\\getData> DATA DECODE ERROR: check ProductModel.swift\n")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(
                        result.vpProductByIds.map {
                            print($0.about)
                            return $0.getProduct()
                        }
                    )
                }
            }
        }.resume()
    }
    
}
