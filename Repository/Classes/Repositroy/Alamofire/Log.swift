import Alamofire

public protocol Log {
    
    func log<T, E>(_ response: DataResponse<T, E>)
    func success<T>(_ value: T)
    func failure(_ error: Error)
}

public struct DEBUGLog: Log {
    
    let separator = " "
    let empty = "____"
    
    public init(){
    }
    
    public func log<T, E>(_ response: DataResponse<T, E>) {
        divader()
        methodName(response.request?.httpMethod)
        urlPath(response.request?.url?.absoluteString)
        header(response.request?.allHTTPHeaderFields)
        parameters(response.request?.httpBody)
        statusCode(response.response?.statusCode)
        metrics(response.metrics)
        jsonResponse(response.data)
    }
    
    public func success<T>(_ value: T) {
        print("Success:", value, separator: separator, terminator: "\n\n")
        divader()
    }
    
    public func failure(_ error: Error) {
        print("Failure:", error, separator: separator, terminator: "\n\n")
        divader()
    }
    
    private func divader(_ symols: Int = 60) {
        print((0 ... symols).compactMap { _ in return "-" }.reduce("", { divider, add -> String in
            return divider + add
        }))
    }
    
    fileprivate func methodName(_ name: String?) {
        print("Method:", name ?? empty, separator: separator)
    }
    
    fileprivate func urlPath(_ path: String?) {
        print("URL:", path ?? empty, separator: separator)
    }
    
    fileprivate func header(_ header: [String: String]?) {
        print("Header:", header ?? empty)
    }
    
    fileprivate func parameters(_ data: Data?) {
        print("Parameters:", String(data: data ?? Data(), encoding: .utf8) ?? empty)
    }
    
    fileprivate func statusCode(_ code: NSInteger?) {
        print("StatusCode:", code ?? empty, separator: separator)
    }
    
    fileprivate func metrics(_ duration: URLSessionTaskMetrics?) {
        print("Duration:", duration?.taskInterval ?? 0.0, separator: separator)
    }
    
    fileprivate func jsonResponse(_ data: Data?) {
        print("JSON:", String(data: data ?? Data(), encoding: .utf8) ?? empty)
    }
}

public struct RELEASELog: Log {
    
    public init(){
    }
    
    public func log<T, E>(_ response: DataResponse<T, E>) {
    }
    
    public func success<T>(_ value: T) {
    }
    
    public func failure(_ error: Error) {
    }
}
