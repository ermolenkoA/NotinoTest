import UIKit

final class PhotoManager {
    private static let baseURL =  "https://i.notino.com/detail_zoom/"
    
    public static func getPhotoByURL(_ url: String) -> UIImage? {
        guard let url = URL(string: baseURL + url), let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }
}
