import Alamofire

open class AlamofireStore: RemoteStore {
 
    public var handler: BaseHandler
    public var session: Alamofire.Session
    
    public init(session: Alamofire.Session, handler: BaseHandler) {
        self.session = session
        self.handler = handler
    }
    
    public func send(request: RequestProvider) -> DataRequest {
        guard let urlRequest = try? request.asURLRequest() else {
            fatalError("Not correct URLRequest format !!!")
        }
        return session.request(urlRequest).validate()
    }
   
    public func send(request: RequestProvider, responseString: @escaping (Result<String, Error>) -> Void) {
        send(request: request).responseString { (response: AFDataResponse<String>) -> Void in
            responseString(self.handler.handle(response))
        }
    }
    
    public func send(request: RequestProvider, responseData: @escaping (Result<Data, Error>) -> Void) {
        send(request: request).responseData { (response: AFDataResponse<Data>) -> Void in
            responseData(self.handler.handle(response))
        }
    }
    
    public func send(request: RequestProvider, responseImage: @escaping (Result<UIImage, Error>) -> Void) {
//         send(request: request).responseImage { (response: AFDataResponse<UIImage>) -> Void in
//             responseImage(self.handler.handle(response))
//         }
     }
    
    public func send(request: RequestProvider, responseJSON: @escaping (Result<Any, Error>) -> Void) {
        send(request: request).responseJSON { (response: AFDataResponse<Any>) -> Void in
            responseJSON(self.handler.handle(response))
        }
    }
}
