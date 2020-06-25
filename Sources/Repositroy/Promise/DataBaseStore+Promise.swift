import PromiseKit

public extension DataBaseStore {
    
    func getItems() -> Promise<[Item]> {
        Promise { resolver in
            getItems { result in
                switch result {
                case .success(let items):
                    resolver.fulfill(items)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
  
    public func getItem() -> Promise<Item> {
        Promise { resolver in
            getItem { result in
                switch result {
                case .success(let item):
                    resolver.fulfill(item)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    public func get(with id: Int) -> Promise<Item> {
        Promise { resolver in
            get(with: id) { result in
                switch result {
                case .success(let item):
                    resolver.fulfill(item)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    public func get(with id: String) -> Promise<Item> {
        Promise { resolver in
            get(with: id) { result in
                switch result {
                case .success(let item):
                    resolver.fulfill(item)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    public func get(with predicate: NSPredicate) -> Promise<[Item]> {
        Promise { resolver in
            get(with: predicate) { result in
                switch result {
                case .success(let item):
                    resolver.fulfill(item)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    public func update() -> Promise<Void> {
        Promise { resolver in
            update { result in
                switch result {
                case .success(let item):
                    resolver.fulfill(item)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    public func save(_ item: Item, policy: UpdatePolicy = .all) -> Promise<Void> {
        Promise { resolver in
            save(item, policy: policy) { result in
                switch result {
                case .success:
                    resolver.fulfill(())
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    public func save(_ items: [Item], policy: UpdatePolicy = .all) -> Promise<Void> {
        Promise { resolver in
            save(items, policy: policy) { result in
                switch result {
                case .success:
                    resolver.fulfill(())
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    public func remove(_ item: Item) -> Promise<Void> {
        Promise { resolver in
            remove(item) { result in
                switch result {
                case .success:
                    resolver.fulfill(())
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
    public func remove(_ items: [Item]) -> Promise<Void> {
        Promise { resolver in
            remove(items) { result in
                switch result {
                case .success:
                    resolver.fulfill(())
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
}
