import SwiftRepository

extension User {
    
    static func getAll() -> RequestProvider {
        MainRequestBuilder(path: [ "json", "get", "EJJKGpww_"], query: ["dff": "df"])
    }
    
    
    static func get() -> RequestProvider {
         MainRequestBuilder(path: [ "json", "get", "EJMmfvppO"])
     }
}
