import Alamofire
import AlamofireObjectMapper
import ObjectMapper

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
        send(request: request).responseString { (response: DataResponse<String, AFError>) -> Void in
            responseString(self.handler.handle(response))
        }
    }
    
    public func send(request: RequestProvider, responseData: @escaping (Result<Data, Error>) -> Void) {
        send(request: request).responseData { (response: DataResponse<Data, AFError>) -> Void in
            responseData(self.handler.handle(response))
        }
    }
    
    public func send(request: RequestProvider, responseImage: @escaping (Result<UIImage, Error>) -> Void) {
//         send(request: request).responseImage { (response: DataResponse<UIImage, AFError>) -> Void in
//             responseImage(self.handler.handle(response))
//         }
     }
    
    public func send(request: RequestProvider, responseJSON: @escaping (Result<Any, Error>) -> Void) {
        send(request: request).responseJSON { (response: DataResponse<Any, AFError>) -> Void in
            responseJSON(self.handler.handle(response))
        }
    }
}

open class DecodableObjectsStore<Item: Decodable>: AlamofireStore, RemoteObjectsStore {

    public func send(request: RequestProvider,
                     keyPath: String? = nil,
                     responseObject: @escaping (Result<Item, Error>) -> Void)
    {
        send(request: request).responseDecodable(decoder: KeyPathDecoder(keyPath)) { (response: DataResponse<Item, AFError>) -> Void in
            responseObject(self.handler.handle(response))
        }
    }
    
    public func send(request: RequestProvider,
                     keyPath: String? = nil,
                     responseArray: @escaping (Result<[Item], Error>) -> Void)
    {
        send(request: request).responseDecodable(decoder: KeyPathDecoder(keyPath)) { (response: DataResponse<[Item], AFError>) -> Void in
            responseArray(self.handler.handle(response))
        }
    }
}

open class ObjectsStore<Item: BaseMappable>: AlamofireStore, RemoteObjectsStore {

    public func send(request: RequestProvider,
                        keyPath: String? = nil,
                        responseObject: @escaping (Result<Item, Error>) -> Void)
    {
        send(request: request).responseObject(keyPath: keyPath) { (response: AFDataResponse<Item>) -> Void in
            responseObject(self.handler.handle(response))
        }
    }
    
    public func send(request: RequestProvider,
                     keyPath: String? = nil,
                     responseArray: @escaping (Result<[Item], Error>) -> Void)
    {
        send(request: request).responseArray(keyPath: keyPath) { (response: AFDataResponse<[Item]>) -> Void in
            responseArray(self.handler.handle(response))
        }
    }
}
