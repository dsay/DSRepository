import SwiftRepository

class MainRequestBuilder: RequestProvider {
    
    var method: HTTPMethod
    
    var url: String
    
    var path: URLComposer
    
    var query: URLComposer
    
    var headers: RequestComposer
    
    var body: RequestComposer

    init(method: HTTPMethod = .get,
         path: URLComposer = "",
         query: URLComposer = [:],
         headers: RequestComposer = [:],
         body: [String: Any]? = nil)
    {
        self.url = "https://next.json-generator.com/api"
        self.method = method
        self.path = path
        self.query = query
        self.headers = headers
        self.body = JSONBodyConverter(json: body)
    }
}

class ImageRequestBuilder: RequestProvider {
    
    var method: HTTPMethod
    
    var url: String
    
    var path: URLComposer
    
    var query: URLComposer
    
    var headers: RequestComposer
    
    var body: RequestComposer

    init(method: HTTPMethod = .get,
         url: String,
         path: URLComposer = "",
         query: URLComposer = [:],
         headers: RequestComposer = [:],
         body: [String: Any]? = nil)
    {
        self.url = url
        self.method = method
        self.path = path
        self.query = query
        self.headers = headers
        self.body = URLBodyConverter(parameters: body)
    }
}
