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

   /// Creates a `RequestProvider` to retrieve the contents of the specified `url`, `method`, `path`, `query`
   /// , `body` and `headers`.
   ///
   /// - parameter url:        The URL.
   /// - parameter method:     The HTTPMethod enum.
   /// - parameter path:       The RequestPathConvertible adds in the end of URL. Use next format `/user/1` or `[/user, 1]`
   /// - parameter query: The queryItems adds in the URL after `?` all items separate by `&` `?search&name=Artur&age=27`.
   /// - parameter headers:    The HTTP headers.
   /// - parameter body:       The RequestBodyConvertible. By encode parameters to `httpBody`.

public protocol RequestProvider {
    
    var method: HTTPMethod { get }
    var url: String { get }
    var path: RequestPathConvertible? { get }
    var query: [String: String?]? { get }
    var headers: [String: String]? { get }
    var body: RequestBodyConvertible? { get }
    
    func asURL() throws -> URL
    
    func asURLRequest() throws -> URLRequest
}

public extension RequestProvider {
    
    public func allowed() -> CharacterSet {
        return CharacterSet.urlQueryAllowed
    }
    
    public func asURL() throws -> URL {
        guard var components = URLComponents(string: self.url) else { throw RepositoryError.invalidURL(url: self.url) }
        
        self.path.flatMap { components.path = $0.toPath() }
        
        self.query.flatMap { components.queryItems = $0.compactMap { key, value in
                URLQueryItem(name: key, value: value?.addingPercentEncoding(withAllowedCharacters: allowed()))
            }
        }
        
        guard let url = components.url else { throw RepositoryError.invalidURL(url: self.url) }
        
        return url
    }
    
    public func asURLRequest() throws -> URLRequest {
        var url = try self.asURL()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        var httpBody = try body?.toHTTPBody()
        urlRequest.httpBody = httpBody
        
        return urlRequest
    }
}
