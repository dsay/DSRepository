import SwiftRepository

class MainRequestBuilder: RequestProvider {
    
    var method: HTTPMethod
    
    var url: String
    
    var path: String?
    
    var queryItems: [String : String?]?
    
    var headers: [String : String]?
    
    var body: [String : Any]?
    
    init(method: HTTPMethod = .get,
         path: String? = nil,
         queryItems: [String: String?]? = nil,
         headers: [String: String]? = nil,
         body: [String: Any]? = nil)
    {
        self.url = "https://next.json-generator.com"
        self.method = method
        self.path = path
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
    }
}
