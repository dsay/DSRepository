import Foundation

open class CodableStore<Item: Codable>: DiskStore {
    
    public let store: Storage
    
    public init(_ store: Storage) {
        self.store = store
    }
    
    public func isExists(at URL: String) -> Bool {
        if store.get(URL) {
            return true
        } else {
            return false
        }
    }
    
    public func get(from URL: String) throws -> Item {
        guard let encoded = store.getData(URL) else{
            throw RepositoryError.objectNotFound
        }
        return try JSONDecoder().decode(Item.self, from: encoded)
    }
    
    public func remove(from URL: String) throws {
        if store.delete(URL) == false {
            throw RepositoryError.cantDeleteObject
        }
    }
    
    public func save(_ item: Item, at URL: String) throws {
        let encoded = try JSONEncoder().encode(item)
        store.set(encoded, forKey: URL)
    }
}
