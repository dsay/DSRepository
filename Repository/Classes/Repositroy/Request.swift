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
