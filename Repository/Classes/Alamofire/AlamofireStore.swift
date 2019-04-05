import AlamofireObjectMapper
import ObjectMapper
import Alamofire
import AlamofireImage

open class AlamofireStore<Item: BaseMappable>: RemoteStore {
    
    var session: SessionManager
    
    public init(_ session: SessionManager) {
        self.session = session
    }
    
    private func send(request: RequestProvider) -> DataRequest {
        switch request {
        case let url as URLRequestConvertible: return session.request(url).validate()
            
        default: fatalError()
        }
    }
    
    public func send(request: RequestProvider, completionHandler: @escaping (Response<[Item]>) -> Void) {
        send(request: request).responseArray(keyPath: request.keyPath) { (response: DataResponse<[Item]>) -> Void in
            completionHandler(BaseHandler.handle(response))
        }
    }
    
    public func send(request: RequestProvider, completionHandler: @escaping (Response<Item>) -> Void) {
        send(request: request).responseObject(keyPath: request.keyPath) { (response: DataResponse<Item>) -> Void in
            completionHandler(BaseHandler.handle(response))
        }
    }
    
    public func send(request: RequestProvider, completionHandler: @escaping (Response<String>) -> Void) {
        send(request: request).responseString { (response: DataResponse<String>) -> Void in
            completionHandler(BaseHandler.handle(response))
        }
    }
    
    public func send(request: RequestProvider, completionHandler: @escaping (Response<UIImage>) -> Void) {
        send(request: request).responseImage { (response: DataResponse<UIImage>) -> Void in
            completionHandler(BaseHandler.handle(response))
        }
    }
    
    public func send(request: RequestProvider, completionHandler: @escaping (Response<Data>) -> Void) {
        send(request: request).responseData { (response: DataResponse<Data>) -> Void in
            completionHandler(BaseHandler.handle(response))
        }
    }
}
