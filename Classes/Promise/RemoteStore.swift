import PromiseKit

public extension RemoteStore {
    
    func send(request: RequestProvider) -> Promise<[Item]> {
        return Promise { resolver in
            send(request: request, completionHandler: { (response: Response<[Item]>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }
    
    func send(request: RequestProvider) -> Promise<Item> {
        return Promise { resolver in
            send(request: request, completionHandler: { (response: Response<Item>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }
    
    func send(request: RequestProvider) -> Promise<String> {
        return Promise { resolver in
            send(request: request, completionHandler: { (response: Response<String>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }
    
    func send(request: RequestProvider) -> Promise<UIImage> {
        return Promise { resolver in
            send(request: request, completionHandler: { (response: Response<UIImage>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }
    
    func send(request: RequestProvider) -> Promise<Data> {
        return Promise { resolver in
            send(request: request, completionHandler: { (response: Response<Data>) -> Void  in
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
