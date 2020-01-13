import Alamofire

class DefaultSessionManager: SessionManager {

    static func `default`() -> DefaultSessionManager {
        let session = DefaultSessionManager(configuration: URLSessionConfiguration.default)
        session.adapter = SessionAdapter()
        return session
    }
}

struct SessionAdapter: RequestAdapter {

    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        return DefaultHTTPHeaders.adapt(urlRequest)
    }
}
