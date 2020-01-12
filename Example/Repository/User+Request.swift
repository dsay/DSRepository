import SwiftRepository

extension User {
    
    static func getAll() -> RequestProvider {
        return MainRequestBuilder(path: "/api/json/get/NkS5tExFU")
    }
}
