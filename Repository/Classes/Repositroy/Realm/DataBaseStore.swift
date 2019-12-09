import Foundation

public enum UpdatePolicy: Int {
    case error = 0
    case modified = 1
    case all = 2
}

public protocol DataBaseStore: LocalStore {
    
    associatedtype Item
    
    func getItems() -> [Item]
    func getItem() -> Item?
    func get(with id: Int) -> Item?
    func get(with id: String) -> Item?
    func get(with predicate: NSPredicate) -> [Item]
    
    func update(_ transaction: () -> Void) throws
    
    func save(_ item: Item, policy: UpdatePolicy) throws
    func save(_ items: [Item], policy: UpdatePolicy) throws
    
    func remove(_ item: Item) throws
    func remove(_ items: [Item]) throws
}
