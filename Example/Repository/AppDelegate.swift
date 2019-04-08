import UIKit
import Repository
import RealmSwift
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        do {
            let realm = try Realm()
            ServiceLocator.shared.registerService(service: realm)
        } catch {
            fatalError()
        }
        
        let session: SessionManager = MainSessionManager.default(user: "test", password: "password")
        ServiceLocator.shared.registerService(service: session)
        
        return true 
    }
}

