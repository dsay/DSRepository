import PromiseKit

public extension OnDiskStore {

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
