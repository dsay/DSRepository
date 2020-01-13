import Alamofire
import PromiseKit

struct Keys {
    static let authorization = "Authorization"
    static let accept = "Accept"
    static let contentType = "Content-Type"
}

struct DefaultHTTPHeaders {

    static var main: HTTPHeaders { var header = self.default
        header[Keys.accept] = "application/json"
        header[Keys.contentType] = "application/json"
        return header
    }

    static let `default` = SessionManager.defaultHTTPHeaders

    static func adapt(_ urlRequest: URLRequest) -> URLRequest {
        var urlRequest = urlRequest

        main.forEach {
            if let headers = urlRequest.allHTTPHeaderFields, headers[$0.key] == nil {
                urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
            }
        }
        return urlRequest
    }
}

class MainSessionManager: SessionManager {

    static func `default`() -> MainSessionManager {
        return MainSessionManager.default(TokenSessionAdapter())

//        return MainSessionManager.default(TokenSessionAdapter(), SessionRequestRetrier())
    }

    static private func `default`(_ adapter: RequestAdapter? = nil, _ retrier: RequestRetrier? = nil) -> MainSessionManager {
        let session = MainSessionManager(configuration: URLSessionConfiguration.default)
        session.adapter = adapter
        session.retrier = retrier
        return session
    }
}

public struct BasicSessionAdapter: RequestAdapter {
    
    var user: String { return "" }
    var password: String { return "" }
    
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = DefaultHTTPHeaders.adapt(urlRequest)

        guard let data = "\(user):\(password)".data(using: .utf8) else { return urlRequest }
        
        let credential = data.base64EncodedString(options: [])
        
        urlRequest.setValue("Basic \(credential)", forHTTPHeaderField: Keys.authorization)
        
        return urlRequest
    }
}


public class TokenSessionAdapter: RequestAdapter {
        
    var token: String { return "" }

//    private lazy var refresher: TokenRepository = DependencyProvider.shared.inject()
    
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = DefaultHTTPHeaders.adapt(urlRequest)
        
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: Keys.authorization)
        
        return urlRequest
    }
}

//public class SessionRequestRetrier: RequestRetrier {
//
//    static let tokenRefreshFailed = NSNotification.Name("TokenRefreshFailedNotification")
//    static let attendedMaxCountOfRetries = NSNotification.Name("AttendedMaxCountOfRetries")
//
//    private lazy var refresher: TokenRepository = DependencyProvider.shared.inject()
//
//    private let maxRetryCount = 1
//    private var isRefreshing = false
//    private var requestsToRetry: [RequestRetryCompletion] = []
//
//    public func should(_ manager: SessionManager,
//                       retry request: Request,
//                       with error: Error,
//                       completion: @escaping RequestRetryCompletion)
//    {
//        if isUnauthorized(request: request) && isAttendMaxCountOfRetries(request: request) {
//            attendedMaxCountOfRetries()
//        } else if isUnauthorized(request: request) {
//            refreshTokenAndRetry(completion)
//        } else {
//            completion(false, 0.0)
//        }
//    }
//
//    fileprivate func refreshTokenAndRetry(_ completion: @escaping RequestRetryCompletion) {
//        requestsToRetry.append(completion)
//
//        if !isRefreshing {
//            isRefreshing = true
//            firstly {
//                self.refresher.refresh()
//            }.done { [unowned self] _ in
//                self.retryAllRequests()
//            }.ensure { [unowned self] in
//                self.isRefreshing = false
//            }.catch { [unowned self] _ in
//                self.refreshFailed()
//            }
//        }
//    }
//
//    fileprivate func completeAllRequests() {
//        requestsToRetry.forEach { $0(false, 0.0) }
//        requestsToRetry.removeAll()
//    }
//
//    fileprivate func retryAllRequests() {
//        requestsToRetry.forEach { $0(true, 0.0) }
//        requestsToRetry.removeAll()
//    }
//
//    fileprivate func refreshFailed() {
//        completeAllRequests()
//        postRefreshFailedNotificaiton()
//    }
//
//    fileprivate func attendedMaxCountOfRetries() {
//        completeAllRequests()
//        postAttendedMaxCountOfRetriesNotificaiton()
//    }
//
//    private func isUnauthorized(request: Request) -> Bool {
//        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
//            return true
//        } else {
//            return false
//        }
//    }
//
//    private func isAttendMaxCountOfRetries(request: Request) -> Bool {
//        return request.retryCount >= maxRetryCount
//    }
//
//    private func postRefreshFailedNotificaiton() {
//        NotificationCenter.default.post(name: SessionRequestRetrier.tokenRefreshFailed, object: nil)
//    }
//
//    private func postAttendedMaxCountOfRetriesNotificaiton() {
//        NotificationCenter.default.post(name: SessionRequestRetrier.attendedMaxCountOfRetries, object: nil)
//    }
//}
