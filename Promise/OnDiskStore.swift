import PromiseKit

protocol PromiseRepository: Repository {

}

extension LocalStore {

    func getItems() -> Promise<[Item]> {
        return Promise { resolver in
            let items = getItems()
            if items.isEmpty {
                resolver.reject(RepositoryError.objectNotFound)
            } else {
                resolver.fulfill(items)
            }
        }
    }

    func getItem() -> Promise<Item> {
        return Promise { resolver in
            if let item = getItem() {
                resolver.fulfill(item)
            } else {
                resolver.reject(RepositoryError.objectNotFound)
            }
        }
    }

    func get(with id: Int) -> Promise<Item> {
        return Promise { resolver in
            if let item = get(with: id) {
                resolver.fulfill(item)
            } else {
                resolver.reject(RepositoryError.objectNotFound)
            }
        }
    }

    func get(with id: String) -> Promise<Item> {
        return Promise { resolver in
            if let item = get(with: id) {
                resolver.fulfill(item)
            } else {
                resolver.reject(RepositoryError.objectNotFound)
            }
        }
    }

    func get(with predicate: NSPredicate) -> Promise<[Item]> {
        return Promise { resolver in
            let items = get(with: predicate)
            if items.isEmpty {
                resolver.reject(RepositoryError.objectNotFound)
            } else {
                resolver.fulfill(items)
            }
        }
    }

    func update(_ transaction: () -> Void) -> Promise<Void> {
        return Promise { resolver in
            do {
                try update(transaction)
                resolver.fulfill(())
            } catch {
                resolver.reject(error)
            }
        }
    }

    func save(_ item: Item) -> Promise<Item> {
        return Promise { resolver in
            do {
                try save(item)
                resolver.fulfill(item)
            } catch {
                resolver.reject(error)
            }
        }
    }

    func save(_ items: [Item]) -> Promise<[Item]> {
        return Promise { resolver in
            do {
                try save(items)
                resolver.fulfill(items)
            } catch {
                resolver.reject(error)
            }
        }
    }

    func remove(_ item: Item) -> Promise<Void> {
        return Promise { resolver in
            do {
                try remove(item)
                resolver.fulfill(())
            } catch let error {
                resolver.reject(error)
            }
        }
    }

    func remove(_ items: [Item]) -> Promise<Void> {
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

extension RemoteStore {

    func send(request: RequestProvider) -> Promise<[Item]> {
        return Promise { resolver in
            send(request: request, completionHandler: { (response: Response<[Item]>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }

    func send(request: RequestProvider) -> Promise<Item> {
        return Promise { resolver in
            send(request: request, completionHandler: { (response: Response<Item>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }

    func send(request: RequestProvider) -> Promise<String> {
        return Promise { resolver in
            send(request: request, completionHandler: { (response: Response<String>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }

    func send(request: RequestProvider) -> Promise<UIImage> {
        return Promise { resolver in
            send(request: request, completionHandler: { (response: Response<UIImage>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }

    func send(request: RequestProvider) -> Promise<Data> {
        return Promise { resolver in
            send(request: request, completionHandler: { (response: Response<Data>) -> Void  in
                switch response {
                case .success(let value):
                    resolver.fulfill(value)
                case .error(let error):
                    resolver.reject(error)
                }
            })
        }
    }
}

extension OnDiskStore {

    func get(from path: String) -> Promise<Data> {
        return Promise { resolver in
            do {
                let data = try get(from: path)
                resolver.fulfill(data)
            } catch {
                resolver.reject(error)
            }
        }
    }

    func remove(from path: String) -> Promise<Void> {
        return Promise { resolver in
            do {
                try remove(from: path)
                resolver.fulfill(())
            } catch {
                resolver.reject(error)
            }
        }
    }

    func save(_ data: Data, to path: String) -> Promise<Void> {
        return Promise { resolver in
            do {
                try save(data, to: path)
                resolver.fulfill(())
            } catch {
                resolver.reject(error)
            }
        }
    }

    func fileExists(from path: String) -> Promise<Void> {
        return Promise { resolver in
            if fileExists(from: path) {
                resolver.fulfill(())
            } else {
                resolver.reject(RepositoryError.fileNotExists)
            }
        }
    }
}
