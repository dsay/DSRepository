import UIKit

public protocol Syncable {
    associatedtype Remote: RemoteStore
    
    var remote: Remote { get }
}

public protocol RemoteStore {
    associatedtype Item
    
    func send(request: RequestProvider, keyPath: String?, completionHandler: @escaping (Response<Item>) -> Void)
    func send(request: RequestProvider, keyPath: String?, completionHandler: @escaping (Response<[Item]>) -> Void)
    func send(request: RequestProvider, completionHandler: @escaping (Response<String>) -> Void)
    func send(request: RequestProvider, completionHandler: @escaping (Response<UIImage>) -> Void)
    func send(request: RequestProvider, completionHandler: @escaping (Response<Data>) -> Void)
    func send(request: RequestProvider, completionHandler: @escaping (Response<Any>) -> Void)
}
