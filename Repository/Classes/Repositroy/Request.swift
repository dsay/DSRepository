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

public enum Encoder {
    case url
    case json
    case property
}

public protocol RequestProvider {

    var method: HTTPMethod { get }
    var url: String { get }
    var path: String? { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var encoder: Encoder { get }
}
