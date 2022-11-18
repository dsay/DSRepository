import Alamofire
import PromiseKit
import ServiceLocator

public enum AppError: LocalizedError {
    
    case attendedMaxCountOfRetries
    case tokenNotRefreshed
}

class MainSessionManager: Alamofire.Session {
    
    static func `default`() -> MainSessionManager {
        MainSessionManager(interceptor: Interceptor(adapter: TokenSessionAdapter(),
                                                    retrier: SessionRequestRetrier()))
    }
}

public struct BasicSessionAdapter: RequestAdapter {
    
    var user: String { return "" }
    var password: String { return "" }
    
    public func adapt(_ urlRequest: URLRequest,
                      for session: Session,
                      completion: @escaping (Swift.Result<URLRequest, Error>) -> Void)
    {
        var urlRequest = urlRequest
        
        if let data = "\(user):\(password)".data(using: .utf8)  {
            let credential = data.base64EncodedString(options: [])
            urlRequest.setValue("Basic \(credential)", forHTTPHeaderField: "Authorization")
        }
        
        completion(.success(urlRequest))
    }
}


public class TokenSessionAdapter: RequestAdapter {
    
    var token: Token? { refresher.get() }
    
    @Injection
    private var refresher: TokenRepository
    
    public func adapt(_ urlRequest: URLRequest,
                      for session: Session,
                      completion: @escaping (Swift.Result<URLRequest, Error>) -> Void)
    {
        var urlRequest = urlRequest
        
        if let token = token {
            urlRequest.setValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        completion(.success(urlRequest))
    }
}

public class SessionRequestRetrier: RequestRetrier {

    static let tokenRefreshFailed = NSNotification.Name("TokenRefreshFailedNotification")
    static let attendedMaxCountOfRetries = NSNotification.Name("AttendedMaxCountOfRetries")

    @Injection
    private var refresher: TokenRepository

    private let maxRetryCount = 1
    private var isRefreshing = false
    private var requestsToRetry: [(RetryResult) -> Void] = []

    public func retry(_ request: Alamofire.Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if isUnauthorized(request: request) && isAttendMaxCountOfRetries(request: request) {
            attendedMaxCountOfRetries()
            completion(.doNotRetry)
        } else if isUnauthorized(request: request) {
            refreshTokenAndRetry(completion)
        } else {
            completion(.doNotRetry)
        }
    }
    
    fileprivate func refreshTokenAndRetry(_ completion: @escaping (RetryResult) -> Void) {
        requestsToRetry.append(completion)

        if !isRefreshing {
            isRefreshing = true
            firstly {
                self.refresher.refresh()
            }.done { [unowned self] _ in
                self.retryAllRequests()
            }.ensure { [unowned self] in
                self.isRefreshing = false
            }.catch { [unowned self] _ in
                self.refreshFailed()
            }
        }
    }

    fileprivate func completeAllRequests(_ error: Error) {
        requestsToRetry.forEach { $0(.doNotRetry) }
        requestsToRetry.removeAll()
    }

    fileprivate func retryAllRequests() {
        requestsToRetry.forEach { $0(.retry) }
        requestsToRetry.removeAll()
    }

    fileprivate func refreshFailed() {
        completeAllRequests(AppError.tokenNotRefreshed)
        postRefreshFailedNotificaiton()
    }

    fileprivate func attendedMaxCountOfRetries() {
        completeAllRequests(AppError.attendedMaxCountOfRetries)
        postAttendedMaxCountOfRetriesNotificaiton()
    }

    private func isUnauthorized(request: Alamofire.Request) -> Bool {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            return true
        } else {
            return false
        }
    }

    private func isAttendMaxCountOfRetries(request: Alamofire.Request) -> Bool {
        request.retryCount >= maxRetryCount
    }

    private func postRefreshFailedNotificaiton() {
        NotificationCenter.default.post(name: SessionRequestRetrier.tokenRefreshFailed, object: nil)
    }

    private func postAttendedMaxCountOfRetriesNotificaiton() {
        NotificationCenter.default.post(name: SessionRequestRetrier.attendedMaxCountOfRetries, object: nil)
    }
}
