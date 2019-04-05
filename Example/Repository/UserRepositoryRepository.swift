import Alamofire
import RealmSwift
import Repository
import PromiseKit

struct UserRepository: Repository, Syncable, Storable {
    typealias Item = User
    
    let remote: AlamofireStore<Item>
    let local: RealmStore<Item>

    static func `default`() -> UserRepository {
        return UserRepository(remote: AlamofireStore(ServiceLocator.shared.getService()),
                                local: RealmStore(ServiceLocator.shared.getService()))
    }
    
    func getAll() -> Promise<[User]> {
        return firstly {
                self.remote.send(request: User.getAll())
            }.then { newItems -> Promise<[User]> in
                self.local.save(newItems)
            }.then { _ in
                self.local.getItems()
            }.recover { _ in
                self.local.getItems()
        }
    }
}
