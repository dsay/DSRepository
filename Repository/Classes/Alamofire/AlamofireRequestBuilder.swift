import Alamofire

private extension Encoder {
    
    func get() -> ParameterEncoding {
        switch self {
            case .url: return URLEncoding.default
            case .json: return JSONEncoding.default
        }
    }
}

public class AlamofireRequestBuilder: RequestProvider, URLRequestConvertible {
    
    public let url: String
    public let path: String?
    public var keyPath: String?
    public let headers: [String: String]?
    public let method: HTTPMethod
    public let parameters: [String: Any]?
    public let encoder: Encoder
    
    init(url: String = "",
         path: String? = nil,
         keyPath: String? = nil,
         headers: [String: String]? = nil,
         method: HTTPMethod = .get,
         parameters: [String: Any]? = nil,
         encoder: Encoder = .url)
    {
        self.url = url
        self.path = path
        self.keyPath = keyPath
        self.headers = headers
        self.method = method
        self.parameters = parameters
        self.encoder = encoder
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
        return try encoder.get().encode(request, with: parameters)
    }
}
