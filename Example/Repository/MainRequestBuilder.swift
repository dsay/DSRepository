import SwiftRepository

class MainRequestBuilder: RequestProvider {
    
    var method: HTTPMethod
    
    var url: String
    
    var path: RequestPathConvertible?
    
    var query: [String: String?]?
    
    var headers: [String: String]?
    
    var body: RequestBodyConvertible?

    init(method: HTTPMethod = .get,
         path: RequestPathConvertible? = nil,
         query: [String: String?]? = nil,
         headers: [String: String]? = nil,
         body: [String: Any]? = nil)
    {
        self.url = "https://next.json-generator.com/sdfsdf/sdfsd/sdf?dfs=df"
        self.method = method
        self.path = path
        self.query = query
        self.headers = headers
        self.body = JSONRequestBody(json: body)
    }
}

class ImageRequestBuilder: RequestProvider {
    
    var method: HTTPMethod
    
    var url: String
    
    var path: RequestPathConvertible?
    
    var query: [String: String?]?
    
    var headers: [String: String]?
    
    var body: RequestBodyConvertible?

    init(method: HTTPMethod = .get,
         url: String,
         path: RequestPathConvertible? = nil,
         query: [String: String?]? = nil,
         headers: [String: String]? = nil,
         body: [String: Any]? = nil)
    {
        self.url = url
        self.method = method
        self.path = path
        self.query = query
        self.headers = headers
        self.body = JSONRequestBody(json: body)
    }
}
