import Repository

extension User {
    
    static func getAll() -> RequestProvider {
        return MainRequestBuilder(path: "/json/get/NkS5tExFU")
    }
}
