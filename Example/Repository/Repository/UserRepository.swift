import SwiftRepository
import PromiseKit

class UserRepository: Repository, Syncable, Storable {
    
    let remote: ObjectsStoreMappable<User>
    let local: RealmStore<User>
    
    init(remote: ObjectsStoreMappable<User>, local: RealmStore<User>) {
        self.remote = remote
        self.local = local
    }
    
    func getAll() -> Promise<[User]> {
        firstly {
            self.remote.requestArray(request: User.getAll())
        }.then { newItems in
            self.local.save(newItems)
        }.then { _ in
            self.local.getItems()
        }.recover { _ in
            self.local.getItems()
        }
    }
}

class UserMapableRepository: Repository, Syncable, Storable {
    
    let remote: ObjectsStoreMappable<User>
    let local: MappableStore<User>
    
    init(remote: ObjectsStoreMappable<User>, local: MappableStore<User>) {
        self.remote = remote
        self.local = local
    }
    
    func getAll() -> Promise<User> {
        firstly {
            self.remote.requestArray(request: User.getAll())
        }.then { newItems in
            self.local.saveItem(newItems[0], at: "User")
        }.then { _ in
            self.local.getItem(from: "User")
        }.recover { _ in
            self.local.getItem(from: "User")
        }
    }
    
    func getIndex() -> Promise<String> {
        remote.requestItem(request: User.get(), keyPath: "id")
    }
}
