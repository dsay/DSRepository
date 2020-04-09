import SwiftRepository

extension User {
    
    static func getAll() -> RequestProvider {
        MainRequestBuilder(path: ["api", "json", "get", "EJJKGpww_"])
    }
}
