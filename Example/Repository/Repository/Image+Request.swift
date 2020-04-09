import SwiftRepository

extension UIImage {

    static func get(_ url: String) -> RequestProvider {
        return ImageRequestBuilder(url: url)
    }
}
