import PromiseKit

public extension RemoteStore {
    
    public func requestString(request: RequestProvider) -> Promise<String> {
        Promise { resolver in
            send(request: request, responseString: { (response: Swift.Result<String, Error>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .failure(let error):
                    resolver.reject(error)
                }
            })
        }
    }
    
    public func requestData(request: RequestProvider) -> Promise<Data> {
        Promise { resolver in
            send(request: request, responseData: { (response: Swift.Result<Data, Error>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .failure(let error):
                    resolver.reject(error)
                }
            })
        }
    }
    
    public func requestJSON(request: RequestProvider) -> Promise<Any> {
        Promise { resolver in
            send(request: request, responseJSON: { (response: Swift.Result<Any, Error>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .failure(let error):
                    resolver.reject(error)
                }
            })
        }
    }
    
    public func requestItem<Item>(request: RequestProvider, keyPath: String? = nil) -> Promise<Item> {
        Promise { resolver in
            send(request: request, keyPath: keyPath) { (response: Swift.Result<Item, Error>) -> Void in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
}

public extension RemoteObjectsStore {
    
    public func requestArray(request: RequestProvider, keyPath: String? = nil) -> Promise<[Item]> {
        Promise { resolver in
            send(request: request, keyPath: keyPath, responseArray: { (response: Swift.Result<[Item], Error>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .failure(let error):
                    resolver.reject(error)
                }
            })
        }
    }
    
    public func requestObject(request: RequestProvider, keyPath: String? = nil) -> Promise<Item> {
        Promise { resolver in
            send(request: request, keyPath: keyPath, responseObject: { (response: Swift.Result<Item, Error>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .failure(let error):
                    resolver.reject(error)
                }
            })
        }
    }
}
