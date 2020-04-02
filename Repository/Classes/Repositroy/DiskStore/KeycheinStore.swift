import Foundation

open class KeycheinStore<Item: Decodable & Encodable>: DiskStore {
    
    public let store: PrivateStore
    
    public init(_ store: PrivateStore) {
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
        
        let encoded = store.getData(URL)
        return try JSONDecoder().decode(Item.self, from: encoded)
        
        
        
//        let mapper = Mapper<Item>(context: nil, shouldIncludeNilValues: false)
//        guard let object = store.get(URL),
//            let parsedObject = mapper.map(JSONString: object) else {
//                throw RepositoryError.objectNotFound
//        }
//        return parsedObject
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
