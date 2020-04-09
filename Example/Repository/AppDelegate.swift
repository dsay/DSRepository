import UIKit
import SwiftRepository
import RealmSwift
import Alamofire
import KeychainSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        let realm: Realm = store()
        ServiceLocator.shared.register(service: realm)

        let session: Alamofire.Session = MainSessionManager.default()
        ServiceLocator.shared.register(service: session)
        
        let log = DEBUGLog()
        let handler = BaseHandler(log)
        ServiceLocator.shared.register(service: handler)

        let store: PrivateStore = KeychainSwift()
        ServiceLocator.shared.register(service: store)

        let user = UserRepository(remote: DecodableObjectsStore(session: session, handler: handler),
                                  local: RealmStore(realm))
        ServiceLocator.shared.register(service: user)

        let token = TokenRepository(remote: DecodableObjectsStore(session: session, handler: handler),
                                    local: KeycheinStore(store))
        ServiceLocator.shared.register(service: token)

        return true 
    }
    
    private func store() -> Realm {
        let config = Realm.Configuration (
            schemaVersion: 1,
            migrationBlock: { _, _ in
        })
        
        Realm.Configuration.defaultConfiguration = config
        
        do {
            return try Realm()
        } catch _ {
            try? FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
            return store()
        }
    }
}

//let transform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
//    // transform value from String? to Int?
//    return Int(value!)
//}, toJSON: { (value: Int?) -> String? in
//    // transform value from Int? to String?
//    if let value = value {
//        return String(value)
//    }
//    return nil
//})
