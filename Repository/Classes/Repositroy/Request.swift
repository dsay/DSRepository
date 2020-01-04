import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

// MARK: - RequestProvider

   /// Creates a `RequestProvider` to retrieve the contents of the specified `url`, `method`, `path`, `queryItems`
   /// , `body` and `headers`.
   ///
   /// - parameter url:        The URL.
   /// - parameter method:     The HTTPMethod enum.
   /// - parameter path:       The path adds in the end of URL. Use next format "/user"
   /// - parameter queryItems: The queryItems adds in the URL after `?` all items separate by `&` `?name=Artur&age=27`.
   /// - parameter headers:    The HTTP headers.
   /// - parameter body:       The HTTP body. By default encode to `json`.

public protocol RequestProvider {
    
    var method: HTTPMethod { get }
    var url: String { get }
    var path: String? { get }
    var queryItems: [String: String?]? { get }
    var headers: [String: String]? { get }
    var body: [String: Any]? { get }
    
    func asURL() throws -> URL
    
    func asURLRequest() throws -> URLRequest
}

public extension RequestProvider {
    
    public func urlQueryAllowed() -> CharacterSet {
        return CharacterSet.urlQueryAllowed
    }
    
    public func asURL() throws -> URL {
        guard var components = URLComponents(string: self.url) else { throw RepositoryError.invalidURL(url: self.url) }
        
        self.path.flatMap { components.path = $0 }
        
        components.queryItems = self.queryItems?.compactMap { key, value in
            URLQueryItem(name: key, value: value?.addingPercentEncoding(withAllowedCharacters: urlQueryAllowed()))
        }
        
        guard let url = components.url else { throw RepositoryError.invalidURL(url: self.url) }
        
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
