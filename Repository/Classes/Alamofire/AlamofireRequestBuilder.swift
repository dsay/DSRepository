import Alamofire

private extension Encoder {
    
    func get() -> ParameterEncoding {
        switch self {
            case .url: return URLEncoding.default
            case .json: return JSONEncoding.default
            case .property: return PropertyListEncoding.default
        }
    }
}

open class AlamofireRequestBuilder: RequestProvider, URLRequestConvertible {
    
    public let method: HTTPMethod
    public let url: String
    public let path: String?
    public let headers: [String: String]?
    public let parameters: [String: Any]?
    public let encoder: Encoder
    public var keyPath: String?

    public init(method: HTTPMethod = .get,
                url: String = "",
                path: String? = nil,
                headers: [String: String]? = nil,
                parameters: [String: Any]? = nil,
                encoder: Encoder = .url,
                keyPath: String? = nil)
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
