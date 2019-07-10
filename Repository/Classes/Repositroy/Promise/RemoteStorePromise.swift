import PromiseKit

public extension RemoteStore {
    
    public func requestString(request: RequestProvider) -> Promise<String> {
        return Promise { resolver in
            send(request: request, responseString: { (response: Response<String>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }
    
    public func requestImage(request: RequestProvider) -> Promise<UIImage> {
        return Promise { resolver in
            send(request: request, responseImage: { (response: Response<UIImage>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }
    
    public func requestData(request: RequestProvider) -> Promise<Data> {
        return Promise { resolver in
            send(request: request, responseData: { (response: Response<Data>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }
    
    public func requestJSON(request: RequestProvider) -> Promise<Any> {
        return Promise { resolver in
            send(request: request, responseJSON: { (response: Response<Any>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }
}

public extension RemoteObjectsStore {

    public func requestArray(request: RequestProvider, keyPath: String? = nil) -> Promise<[Item]> {
        return Promise { resolver in
            send(request: request, keyPath: keyPath, responseArray: { (response: Response<[Item]>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }
    
    public func requestObject(request: RequestProvider, keyPath: String? = nil) -> Promise<Item> {
        return Promise { resolver in
            send(request: request, keyPath: keyPath, responseObject: { (response: Response<Item>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }
}
