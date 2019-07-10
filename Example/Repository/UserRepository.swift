import Alamofire
import RealmSwift
import SwiftRepository
import PromiseKit

struct UserRepository: Repository, Syncable, Storable {
    
    let remote: ObjectsStore<User>
    let local: RealmStore<User>
    
    static func `default`() -> UserRepository {
        return UserRepository(remote: ObjectsStore(ServiceLocator.shared.getService()),
                              local: RealmStore(ServiceLocator.shared.getService()))
    }
    
    func getAll() -> Promise<[User]> {
        return firstly {
                    self.remote.requestArray(request: User.getAll())
                .then { newItems -> Promise<[User]> in
                    self.local.save(newItems)
                }.then { _ in
                    self.local.getItems()
                }.recover { _ in
                    self.local.getItems()
            }
        }
    }
}
