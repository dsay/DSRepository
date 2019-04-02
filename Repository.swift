import UIKit

enum RepositoryError: Error {
    case objectNotFound
    case fileNotExists
}

protocol Repository {
    associatedtype Item

    static func `default`() -> Self
}

protocol Syncable {
    associatedtype Remote: RemoteStore

    var remote: Remote { get }
}

protocol Storable {
    associatedtype Local: LocalStore

    var local: Local { get }
}

protocol OnDiskStorable {

    var onDisk: OnDiskStore { get }
}

protocol RemoteStore {
    associatedtype Item

    func send(request: RequestProvider, completionHandler: @escaping (Response<Item>) -> Void)
    func send(request: RequestProvider, completionHandler: @escaping (Response<[Item]>) -> Void)
    func send(request: RequestProvider, completionHandler: @escaping (Response<String>) -> Void)
    func send(request: RequestProvider, completionHandler: @escaping (Response<UIImage>) -> Void)
    func send(request: RequestProvider, completionHandler: @escaping (Response<Data>) -> Void)
}

protocol LocalStore {
    associatedtype Item

    func getItems() -> [Item]
    func getItem() -> Item?
    func get(with id: Int) -> Item?
    func get(with id: String) -> Item?
    func get(with predicate: NSPredicate) -> [Item]

    func update(_ transaction: () -> Void) throws

    func save(_ item: Item) throws
    func save(_ items: [Item]) throws

    func remove(_ item: Item) throws
    func remove(_ items: [Item]) throws
}

protocol OnDiskStore {

    func fileExists(from path: String) -> Bool
    func get(from path: String) throws -> Data
    func remove(from path: String) throws
    func save(_ data: Data, to path: String) throws
}
