import UIKit

public protocol Syncable {
    
    associatedtype Remote: RemoteStore
    
    var remote: Remote { get }
}

public protocol RemoteStore {
    associatedtype Error
    
    func send(request: RequestProvider, responseString: @escaping (Response<String, Error>) -> Void)
    func send(request: RequestProvider, responseImage: @escaping (Response<UIImage, Error>) -> Void)
    func send(request: RequestProvider, responseData: @escaping (Response<Data, Error>) -> Void)
    func send(request: RequestProvider, responseJSON: @escaping (Response<Any, Error>) -> Void)
}

public protocol RemoteObjectsStore: RemoteStore {
    associatedtype Item
    associatedtype Error

    func send(request: RequestProvider, keyPath: String?, responseObject: @escaping (Response<Item, Error>) -> Void)
    func send(request: RequestProvider, keyPath: String?, responseArray: @escaping (Response<[Item], Error>) -> Void)
}
