import SwiftRepository
import PromiseKit

class UserRepository: Repository, Syncable, Storable {
    
    let remote: RemoteStoreMappable<User>
    let local: LocalStoreRealm<User>
    
    init(remote: RemoteStoreMappable<User>, local: LocalStoreRealm<User>) {
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
    
    let remote: RemoteStoreMappable<User>
    let local: LocalStoreMappable<User>
    
    init(remote: RemoteStoreMappable<User>, local: LocalStoreMappable<User>) {
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
