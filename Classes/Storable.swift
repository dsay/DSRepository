import UIKit

public protocol Storable {
    associatedtype Local: LocalStore
    
    var local: Local { get }
}

public protocol LocalStore {
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
