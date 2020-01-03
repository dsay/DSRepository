import Foundation

open class RequestBuilder: RequestProvider {
    
    var urlQueryAllowed = CharacterSet.urlQueryAllowed
    
    public let method: HTTPMethod
    public let url: String
    public let path: String?
    public var queryItems: [String : String?]?
    public let headers: [String: String]?
    public let body: [String: Any]?

    public init(method: HTTPMethod = .get,
                url: String,
                path: String? = nil,
                queryItems: [String: String?]? = nil,
                headers: [String: String]? = nil,
                body: [String: Any]? = nil)
    {
        self.method = method

        self.url = url
        self.path = path
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
    }
    
    public func asURL() throws -> URL {
        guard var components = URLComponents(string: self.url) else {
            throw RepositoryError.invalidURL(url: self.url)
        }
        
        self.path.flatMap { components.path = $0 }
        
        components.queryItems = self.queryItems?.compactMap { key, value in
            URLQueryItem(name: key, value: value?.addingPercentEncoding(withAllowedCharacters: urlQueryAllowed))
        }
    
        guard let url = components.url else {
            throw RepositoryError.invalidURL(url: self.url)
        }
        
        return url
    }
    
    public func asURLRequest() throws -> URLRequest {
        var url = try self.asURL()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        guard let bodyParameters = body else { return urlRequest }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = data
        } catch {
            throw RepositoryError.jsonEncodingFailed(error: error)
        }
        
        return urlRequest
    }
}
