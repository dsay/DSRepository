import Alamofire

open class BaseHandler {
    
    private let loger: Log
    
    public init(_ loger: Log) {
        self.loger = loger
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
