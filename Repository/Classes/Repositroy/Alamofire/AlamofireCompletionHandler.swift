import Alamofire

open class BaseHandler {
    
    private let loger: Log
    
    public init(_ loger: Log) {
        self.loger = loger
    }
    
    public func handle<T, E>(_ response: DataResponse<T, E>) -> Response<T, E> {
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
    
    open func responseSuccess<T, E>(_ response: DataResponse<T, E>, item: T) -> Response<T, E> {
        .success(item)
    }
    
    open func responseError<T, E>(_ response: DataResponse<T, E>, error: E) -> Response<T, E> {
        .error(error)
    }
}
