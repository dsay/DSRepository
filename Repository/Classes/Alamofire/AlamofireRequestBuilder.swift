import Alamofire

public class AlamofireRequestBuilder: RequestProvider, URLRequestConvertible {
    
    public let url: String
    public let path: String?
    public var keyPath: String?
    public let headers: [String: String]?
    public let method: HTTPMethod
    public let parameters: [String: Any]?
    
    func encoder() -> ParameterEncoding { fatalError() }
    
    init(url: String = "",
         path: String? = nil,
         keyPath: String? = nil,
         headers: [String: String]? = nil,
         method: HTTPMethod = .get,
         parameters: [String: Any]? = nil) {
        
        self.url = url
        self.path = path
        self.keyPath = keyPath
        self.headers = headers
        self.method = method
        self.parameters = parameters
    }
    
    func asURL() throws -> URL {
        if let path = path {
            return try (url + path).asURL()
        } else {
            return try url.asURL()
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try self.asURL()
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return try encoder().encode(request, with: parameters)
    }
}

public class URLEncodingRequestBuilder: AlamofireRequestBuilder {
    override func encoder() -> ParameterEncoding { return URLEncoding.default }
}

public class JSONEncodingRequestBuilder: AlamofireRequestBuilder {
    override func encoder() -> ParameterEncoding { return JSONEncoding.default }
}
