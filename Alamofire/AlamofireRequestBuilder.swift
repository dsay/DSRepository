import Alamofire

class AlamofireRequestBuilder: RequestProvider, URLRequestConvertible {

    let url: String
    let path: String?
    var keyPath: String?
    let headers: [String: String]?
    let method: HTTPMethod
    let parameters: [String: Any]?

    func encoder() -> ParameterEncoding { fatalError() }

    init(url: String = API.Configuration.current.baseURLString,
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

    func asURLRequest() throws -> URLRequest {
        let url = try self.asURL()
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return try encoder().encode(request, with: parameters)
    }
}

class URLEncodingRequestBuilder: AlamofireRequestBuilder {
    override func encoder() -> ParameterEncoding { return URLEncoding.default }
}

class JSONEncodingRequestBuilder: AlamofireRequestBuilder {
    override func encoder() -> ParameterEncoding { return JSONEncoding.default }
}
