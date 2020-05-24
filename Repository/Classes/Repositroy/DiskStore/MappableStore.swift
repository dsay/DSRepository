import ObjectMapper

open class MappableStore<Item: BaseMappable>: DiskStore {
    
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
        let mapper = Mapper<Item>(context: nil, shouldIncludeNilValues: false)
        guard let object = store.get(URL),
            let parsedObject = mapper.map(JSONString: object) else {
                throw RepositoryError.objectNotFound
        }
        return parsedObject
    }
    
    public func remove(from URL: String) throws {
        if store.delete(URL) == false {
            throw RepositoryError.cantDeleteObject
        }
    }
    
    public func save(_ item: Item, at URL: String) throws {
        guard let JSONString = item.toJSONString(),
            store.set(JSONString, forKey: URL) else {
                throw RepositoryError.cantSaveObject
        }
    }
}
