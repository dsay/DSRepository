import PromiseKit

public extension LocalStore {
    
    public func getItems() -> Promise<[Item]> {
        return Promise { resolver in
            let items = getItems()
            if items.isEmpty {
                resolver.reject(RepositoryError.objectNotFound)
            } else {
                resolver.fulfill(items)
            }
        }
    }
    
    public func getItem() -> Promise<Item> {
        return Promise { resolver in
            if let item = getItem() {
                resolver.fulfill(item)
            } else {
                resolver.reject(RepositoryError.objectNotFound)
            }
        }
    }
    
    public func get(with id: Int) -> Promise<Item> {
        return Promise { resolver in
            if let item = get(with: id) {
                resolver.fulfill(item)
            } else {
                resolver.reject(RepositoryError.objectNotFound)
            }
        }
    }
    
    public func get(with id: String) -> Promise<Item> {
        return Promise { resolver in
            if let item = get(with: id) {
                resolver.fulfill(item)
            } else {
                resolver.reject(RepositoryError.objectNotFound)
            }
        }
    }
    
    public func get(with predicate: NSPredicate) -> Promise<[Item]> {
        return Promise { resolver in
            let items = get(with: predicate)
            if items.isEmpty {
                resolver.reject(RepositoryError.objectNotFound)
            } else {
                resolver.fulfill(items)
            }
        }
    }
    
    public func update(_ transaction: () -> Void) -> Promise<Void> {
        return Promise { resolver in
            do {
                try update(transaction)
                resolver.fulfill(())
            } catch {
                resolver.reject(error)
            }
        }
    }
    
    public func save(_ item: Item) -> Promise<Item> {
        return Promise { resolver in
            do {
                try save(item)
                resolver.fulfill(item)
            } catch {
                resolver.reject(error)
            }
        }
    }
    
    public func save(_ items: [Item]) -> Promise<[Item]> {
        return Promise { resolver in
            do {
                try save(items)
                resolver.fulfill(items)
            } catch {
                resolver.reject(error)
            }
        }
    }
    
    public func remove(_ item: Item) -> Promise<Void> {
        return Promise { resolver in
            do {
                try remove(item)
                resolver.fulfill(())
            } catch let error {
                resolver.reject(error)
            }
        }
    }
    
    public func remove(_ items: [Item]) -> Promise<Void> {
        return Promise { resolver in
            do {
                try remove(items)
                resolver.fulfill(())
            } catch {
                resolver.reject(error)
            }
        }
    }
}
