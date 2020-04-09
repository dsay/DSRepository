import SwiftRepository
import PromiseKit

struct UserRepository: Repository, Syncable, Storable {    
    
    let remote: DecodableObjectsStore<User>
    let local: RealmStore<User>
    
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
