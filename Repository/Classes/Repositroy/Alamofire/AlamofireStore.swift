import AlamofireObjectMapper
import ObjectMapper
import Alamofire
import AlamofireImage

private extension HTTPMethod {

    func get() -> Alamofire.HTTPMethod {
        return Alamofire.HTTPMethod(rawValue: self.rawValue) ?? .get
    }
}

private extension Encoder {
    
    func get() -> ParameterEncoding {
        switch self {
        case .url: return URLEncoding.default
        case .json: return JSONEncoding.default
        case .property: return PropertyListEncoding.default
        }
    }
}

open class AlamofireStore: RemoteStore {
 
    public var handler: BaseHandler
    public var session: SessionManager
    
    public init(session: SessionManager, handler: BaseHandler) {
        self.session = session
        self.handler = handler
    }
    
    public func send(request: RequestProvider) -> DataRequest {
        if let url = request as? URLRequestConvertible {
            return session.request(url).validate()
        } else {
            return session.request(request.urlPath(),
                                   method: request.method.get(),
                                   parameters: request.parameters,
                                   encoding: request.encoder.get(),
                                   headers: request.headers).validate()
        }
    }
    
    public func upload(request: RequestProvider, completion:  @escaping (DataRequest) -> Void) {
        if let parameters = request.parameters as? [String: Data] {
            session.upload(multipartFormData: {
                for (key, value) in parameters {
                    $0.append(value, withName: key)
                }
            }, to: request.urlPath(),
               method: request.method.get(),
               headers: request.headers
            ) { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                  completion(upload)
                case .failure(let encodingError):
                    fatalError(encodingError.localizedDescription)
                }
            }
        } else {
           fatalError(" Support only format [String: Data] !!!")
        }
    }
    
    
    public func send(request: RequestProvider, responseString: @escaping (Response<String>) -> Void) {
        send(request: request).responseString { (response: DataResponse<String>) -> Void in
            responseString(self.handler.handle(response))
        }
    }
    
    public func send(request: RequestProvider, responseImage: @escaping (Response<UIImage>) -> Void) {
        send(request: request).responseImage { (response: DataResponse<UIImage>) -> Void in
            responseImage(self.handler.handle(response))
        }
    }
    
    public func send(request: RequestProvider, responseData: @escaping (Response<Data>) -> Void) {
        send(request: request).responseData { (response: DataResponse<Data>) -> Void in
            responseData(self.handler.handle(response))
        }
    }
    
    public func send(request: RequestProvider, responseJSON: @escaping (Response<Any>) -> Void) {
        send(request: request).responseJSON { (response: DataResponse<Any>) -> Void in
            responseJSON(self.handler.handle(response))
        }
    }
}

open class ObjectsStore<Item: BaseMappable>: AlamofireStore, RemoteObjectsStore {

    public func send(request: RequestProvider, keyPath: String? = nil, responseObject: @escaping (Response<Item>) -> Void) {
        send(request: request).responseObject(keyPath: keyPath) { (response: DataResponse<Item>) -> Void in
            responseObject(self.handler.handle(response))
        }
    }
    
    public func send(request: RequestProvider, keyPath: String? = nil, responseArray: @escaping (Response<[Item]>) -> Void) {
        send(request: request).responseArray(keyPath: keyPath) { (response: DataResponse<[Item]>) -> Void in
            responseArray(self.handler.handle(response))
        }
    }
}

open class UploadObjectsStore<Item: BaseMappable>: AlamofireStore {
    
    public func upload(request: RequestProvider, keyPath: String? = nil, responseObject: @escaping (Response<Item>) -> Void) {
        upload(request: request,completion: { uploadRequest in
            uploadRequest.responseObject(keyPath: keyPath) { (response: DataResponse<Item>) -> Void in
                responseObject(self.handler.handle(response))
            }
        })
    }
    
    public func upload(request: RequestProvider, keyPath: String? = nil, responseArray: @escaping (Response<[Item]>) -> Void) {
         upload(request: request,completion: { uploadRequest in
             uploadRequest.responseArray(keyPath: keyPath) { (response: DataResponse<[Item]>) -> Void in
                 responseArray(self.handler.handle(response))
             }
         })
     }
}
