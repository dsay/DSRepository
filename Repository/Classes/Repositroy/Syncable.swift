import UIKit

public protocol Syncable {
    
    associatedtype Remote: RemoteStore
    
    var remote: Remote { get }
}

public protocol RemoteStore {
    
    func send(request: RequestProvider, responseString: @escaping (Response<String>) -> Void)
    func send(request: RequestProvider, responseImage: @escaping (Response<UIImage>) -> Void)
    func send(request: RequestProvider, responseData: @escaping (Response<Data>) -> Void)
    func send(request: RequestProvider, responseJSON: @escaping (Response<Any>) -> Void)
}

public protocol RemoteObjectsStore: RemoteStore {
    associatedtype Item

    func send(request: RequestProvider, keyPath: String?, responseObject: @escaping (Response<Item>) -> Void)
    func send(request: RequestProvider, keyPath: String?, responseArray: @escaping (Response<[Item]>) -> Void)
}
