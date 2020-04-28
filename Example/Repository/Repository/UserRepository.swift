import SwiftRepository
import PromiseKit

class UserRepository: Repository, Syncable, Storable {
    
    let remote: ObjectsStore<User>
    let local: RealmStore<User>
    
    init(remote: ObjectsStore<User>, local: RealmStore<User>) {
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
