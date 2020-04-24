import Alamofire

struct Keys {
    static let authorization = "Authorization"
    static let language = "Accept-Language"
    static let basic = "Basic"
    static let token = "Token"
    static let bearer = "Bearer"
    static let sessionKey = "x-mysolomeo-session-key"
    static let accept = "Accept"
    static let contentType = "Content-Type"
    static let requestID = "x-requestId"
    static let sourceID = "x-sourceId"
    static let date = "x-dateTime"
    static let userToken = "x-token"
}

struct DefaultHTTPHeaders {

    static var main: HTTPHeaders { var header = self.default
        header[Keys.accept] = "application/json"
        header[Keys.contentType] = "application/json"
        return header
    }

    static let `default` = HTTPHeaders.default

    static func adapt(_ urlRequest: URLRequest) -> URLRequest {
        var urlRequest = urlRequest

        main.forEach {
            if let headers = urlRequest.allHTTPHeaderFields, headers[$0.name] == nil {
                urlRequest.setValue($0.value, forHTTPHeaderField: $0.name)
            }
        }
        return urlRequest
    }
}

class CardSessionManager: Alamofire.Session {
    static func `default`(clientID: String, clientSecret: String) -> CardSessionManager {
        CardSessionManager(interceptor: Interceptor(adapter: CardSessionAdapter(clientID: clientID, clientSecret: clientSecret), retrier: CardSessionRequestRetrier()))
    }}

public struct CardSessionAdapter: RequestAdapter {

    let clientID: String
    let clientSecret: String
    
    public func adapt(_ urlRequest: URLRequest,
                      for session: Session,
                      completion: @escaping (Swift.Result<URLRequest, Error>) -> Void) {

        var urlRequest = DefaultHTTPHeaders.adapt(urlRequest)
        
        let json: [String: Any] = ["clientId": clientID,
                                   "clientSecret": clientSecret]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        urlRequest.httpBody = jsonData
        
        completion(.success(urlRequest))
    }
}

public class CardSessionRequestRetrier: RequestRetrier {

    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}
