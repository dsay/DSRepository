import ObjectMapper

open class KeycheinStore<Item: KeycheinStoreItem>: LocalStore {
    
    public let store: PrivateStore
    
    public init(_ store: PrivateStore) {
        self.store = store
    }
    
    public func getItem() -> Item? {
        let mapper = Mapper<Item>(context: nil, shouldIncludeNilValues: false)
        guard let object = store.get(Item.primaryKey()) else { return nil }
        guard let parsedObject = mapper.map(JSONString: object) else { return nil }
        return parsedObject
    }
    
    public func save(_ item: Item, policy: UpdatePolicy = .all) throws {
        if store.set(item.toJSONString() ?? "", forKey: Item.primaryKey()) == false {
            throw RepositoryError.cantSaveObject
        }
    }
    
    public func remove(_ item: Item) throws {
        if store.delete(Item.primaryKey()) == false {
            throw RepositoryError.cantDeleteObject
        }
    }
    
    @available(*, deprecated, message: "KeycheinStore works with single object")
    public func getItems() -> [Item] {
        fatalError()
    }
    
    @available(*, deprecated, message: "KeycheinStore works with single object")
    public func get(with id: Int) -> Item? {
        fatalError()
    }
    
    @available(*, deprecated, message: "KeycheinStore works with single object")
    public func get(with id: String) -> Item? {
        fatalError()
    }
    
    @available(*, deprecated, message: "KeycheinStore works with single object")
    public func get(with predicate: NSPredicate) -> [Item] {
        fatalError()
    }
    
    @available(*, deprecated, message: "KeycheinStore works with single object")
    public func update(_ transaction: () -> Void) throws {
        fatalError()
    }
    
    @available(*, deprecated, message: "KeycheinStore works with single object")
    public func save(_ items: [Item], policy: UpdatePolicy = .all) throws {
        fatalError()
    }
    
    @available(*, deprecated, message: "KeycheinStore works with single object")
    public func remove(_ items: [Item]) throws {
        fatalError()
    }
}
