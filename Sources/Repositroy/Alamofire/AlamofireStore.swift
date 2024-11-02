import Alamofire
import Foundation
import ObjectMapper

open class RemoteStoreAlamofire: RemoteStore {
 
    public var handler: BaseHandler
    public var session: Alamofire.Session
    
    public init(session: Alamofire.Session, handler: BaseHandler) {
        self.session = session
        self.handler = handler
    }
    
    open func send(request: RequestProvider) -> DataRequest {
        guard let urlRequest = try? request.asURLRequest() else {
            fatalError("Not correct URLRequest format !!!")
        }
        return session.request(urlRequest).validate()
    }
   
    open func send(request: RequestProvider, response: @escaping (Result<Data?, Error>) -> Void) {
        send(request: request).response { (responseData: AFDataResponse<Data?>) -> Void in
            response(self.handler.handle(responseData))
        }
    }
    
    open func send(request: RequestProvider, responseString: @escaping (Result<String, Error>) -> Void) {
        send(request: request).responseString { (response: AFDataResponse<String>) -> Void in
            responseString(self.handler.handle(response))
        }
    }
    
    open func send(request: RequestProvider, responseData: @escaping (Result<Data, Error>) -> Void) {
        send(request: request).responseData { (response: AFDataResponse<Data>) -> Void in
            responseData(self.handler.handle(response))
        }
    }
    
    open func send(request: RequestProvider, responseJSON: @escaping (Result<Any, Error>) -> Void) {
        send(request: request).responseJSON { (response: AFDataResponse<Any>) -> Void in
            responseJSON(self.handler.handle(response))
        }
    }
    
    public func send<Item>(request: any RequestProvider, keyPath: String?, responseItem: @escaping (Result<Item, any Error>) -> Void) {
        send(request: request).responseItem(completionHandler: { (response: AFDataResponse<Item>) -> Void in
            responseItem(self.handler.handle(response))
        })
    }
    
    open func send<Item>(request: RequestProvider, keyPath: String?, responseArray: @escaping (Result<[Item], Error>) -> Void) {
        send(request: request).responseItem(completionHandler: { (response: AFDataResponse<[Item]>) -> Void in
            responseArray(self.handler.handle(response))
        })
    }
}

public extension RemoteStoreAlamofire {
        
    func send<Item>(request: RequestProvider, keyPath: String?, responseItem: @escaping (Result<Item, Error>) -> Void) where Item: Decodable {
        send(request: request).responseDecodable(decoder: KeyPathDecoder(keyPath)) { (response: AFDataResponse<Item>) -> Void in
            responseItem(self.handler.handle(response))
        }
    }
    
    func send<Item>(request: RequestProvider, keyPath: String?, responseArray: @escaping (Result<[Item], Error>) -> Void)  where Item: Decodable {
        send(request: request).responseDecodable(decoder: KeyPathDecoder(keyPath)) { (response: AFDataResponse<[Item]>) -> Void in
            responseArray(self.handler.handle(response))
        }
    }
}

public extension RemoteStoreAlamofire {
        
    func send<Item>(request: RequestProvider, keyPath: String?, responseItem: @escaping (Result<Item, Error>) -> Void) where Item: BaseMappable {
        send(request: request).responseObject(keyPath: keyPath) { (response: AFDataResponse<Item>) -> Void in
            responseItem(self.handler.handle(response))
        }
    }
    
    func send<Item>(request: RequestProvider, keyPath: String?, responseArray: @escaping (Result<[Item], Error>) -> Void)  where Item: BaseMappable {
        send(request: request).responseArray(keyPath: keyPath) { (response: AFDataResponse<[Item]>) -> Void in
            responseArray(self.handler.handle(response))
        }
    }
}
