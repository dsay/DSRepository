import Alamofire

open class BaseHandler {
    
    let loger = DEBUGLog()
    
    public init() {
    }
    
    public func handle<T>(_ response: DataResponse<T>) -> Response<T> {
        loger.log(response)
        
        switch response.result {
        case .success(let value):
            loger.success(value)
            return responseSuccess(response, item: value)
            
        case .failure(let error):
            loger.failure(error)
            return responseError(response, error: error)
        }
    }
    
    open func responseSuccess<T>(_ response: DataResponse<T>, item: T) -> Response<T> {
        return .success(item)
    }
    
    open func responseError<T>(_ response: DataResponse<T>, error: Error) -> Response<T> {
        
        let userInfo: [String : Any] = [
            NSLocalizedDescriptionKey: error.localizedDescription,
            NSLocalizedFailureReasonErrorKey: error.localizedDescription
        ]
        let domain = response.request?.url?.host ?? NSURLErrorDomain
        
        switch response.response?.statusCode {
        case .none:
            return .error(NSError(domain: domain, code: 500, userInfo: userInfo ))
        case .some(let statusCode):
            return .error(NSError(domain: domain, code: statusCode, userInfo: userInfo))
        }
    }
}

protocol Log {
    
    func log<T>(_ response: DataResponse<T>)
    func success<T>(_ value: T)
    func failure(_ error: Error)
}

struct DEBUGLog: Log {
    
    let separator = " "
    let empty = "____"
    
    func log<T>(_ response: DataResponse<T>) {
        divader()
        methodName(response.request?.httpMethod)
        urlPath(response.request?.url?.absoluteString)
        header(response.request?.allHTTPHeaderFields)
        parameters(response.request?.httpBody)
        statusCode(response.response?.statusCode)
        startTime( response.timeline.requestStartTime)
        duration(response.timeline.requestDuration)
        jsonResponse(response.data)
    }
    
    func success<T>(_ value: T) {
        print("Success:", value, separator: separator, terminator: "\n\n")
        divader()
    }
    
    func failure(_ error: Error) {
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
    
    fileprivate func startTime(_ time: CFAbsoluteTime) {
        print("StartTime:", Date(timeIntervalSinceReferenceDate: time), separator: separator)
    }
    
    fileprivate func duration(_ duration: TimeInterval) {
        print("RequestDuration:", duration, separator: separator)
    }
    
    fileprivate func jsonResponse(_ data: Data?) {
        print("JSON:", String(data: data ?? Data(), encoding: .utf8) ?? empty)
    }
}

struct RELEASELog: Log {
    
    func log<T>(_ response: DataResponse<T>) {
    }
    
    func success<T>(_ value: T) {
    }
    
    func failure(_ error: Error) {
    }
}
