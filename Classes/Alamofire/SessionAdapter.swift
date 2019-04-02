import Alamofire

private struct Keys {
    static let authorization = "Authorization"
    static let basic = "Basic"
    static let token = "Token"
    static let sessionKey = "x-mysolomeo-session-key"
    static let accept = "Accept"
    static let contentType = "Content-Type"
}

private struct DefaultHTTPHeaders {

    static var main: HTTPHeaders { var header = self.default
        header[Keys.accept] = "application/json"
        header[Keys.contentType] = "application/json"
        return header
    }

    static private let `default` = SessionManager.defaultHTTPHeaders
}

public class MainSessionManager: SessionManager {

    static func `default`(user: String, password: String) -> MainSessionManager {
        return MainSessionManager.default(BasicSessionAdapter(user: user, password: password))
    }

    static func `default`(token: String?) -> MainSessionManager {
        return MainSessionManager.default(RFTSessionAdapter(token: token ?? ""))
    }

    static func `default`(sessionToken: String) -> MainSessionManager {
        return MainSessionManager.default(SessionKeySessionAdapter(session: sessionToken))
    }

    static func `default`(_ adapter: RequestAdapter? = nil) -> MainSessionManager {
        let session = MainSessionManager(configuration: URLSessionConfiguration.default)
        session.adapter = adapter
        return session
    }
}

public struct BasicSessionAdapter: RequestAdapter {

    let user: String
    let password: String

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest

        guard let data = "\(user):\(password)".data(using: .utf8) else { return urlRequest }

        let credential = data.base64EncodedString(options: [])

        DefaultHTTPHeaders.main.forEach {
            if let headers = urlRequest.allHTTPHeaderFields, headers[$0.key] == nil {
                urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
            }
        }
        urlRequest.setValue("\(Keys.basic) \(credential)", forHTTPHeaderField: Keys.authorization)

        return urlRequest
    }
}

public struct RFTSessionAdapter: RequestAdapter {

    let token: String

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest

        DefaultHTTPHeaders.main.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        urlRequest.setValue("\(Keys.token) \(token)", forHTTPHeaderField: Keys.authorization)

        return urlRequest
    }
}

public struct SessionKeySessionAdapter: RequestAdapter {

    let session: String

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest

        DefaultHTTPHeaders.main.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)}
        urlRequest.setValue(session, forHTTPHeaderField: Keys.sessionKey)

        return urlRequest
    }
}
