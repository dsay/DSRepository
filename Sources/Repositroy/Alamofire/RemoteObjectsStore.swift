import Alamofire
import ObjectMapper

open class ObjectsStoreDecodable<Item: Decodable>: AlamofireStore, RemoteObjectsStore {

    public func send(request: RequestProvider,
                     keyPath: String? = nil,
                     responseObject: @escaping (Result<Item, Error>) -> Void)
    {
        send(request: request).responseDecodable(decoder: KeyPathDecoder(keyPath)) { (response: AFDataResponse<Item>) -> Void in
            responseObject(self.handler.handle(response))
        }
    }
    
    public func send(request: RequestProvider,
                     keyPath: String? = nil,
                     responseArray: @escaping (Result<[Item], Error>) -> Void)
    {
        send(request: request).responseDecodable(decoder: KeyPathDecoder(keyPath)) { (response: AFDataResponse<[Item]>) -> Void in
            responseArray(self.handler.handle(response))
        }
    }
}

open class ObjectsStoreMappable<Item: BaseMappable>: AlamofireStore, RemoteObjectsStore {

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

