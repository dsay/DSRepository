import UIKit
import SwiftRepository
import Alamofire
import CoreData
import ServiceLocator

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @Injection
    var userRepository: UserRepository
    @Injection
    var userMRepository: UserMapableRepository
    @Injection
    var db: Database

    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    func updateData() {
        
//        let defaultStore = db.createStoreDescription()
        
        let publicStore = db.createStoreDescription(configuration: .public)
        let privateStore = db.createStoreDescription("UserID", configuration: .private)
        
        db.addStores([publicStore, privateStore]) { result in
            switch result {
            case .success:
                print("Stores was created!!!")
            case .failure(let error):
                print("Stores created errrr: %@ !!!", error)
            }
            
            self.test()
        }
        
        let userID = "1"
        let sd = Request(method: .get,
                         path: [ "user", userID],
                         query: ["some" : nil, "some1": "sdf df", "some2": "іваіоа"],
                         headers: ["asdfadf": "adfsdf"],
                         body: ["df": ["dfdf":"2342"]])
        
        let request = try! sd.asURLRequest()
        
        print(request.httpMethod ?? "")
        print(request.url  ?? "")
        print(request.allHTTPHeaderFields ?? "")
        print(String(data: request.httpBody ?? Data(), encoding: .utf8) ?? "")
        
        userRepository.remote.requestData(request: sd).done { data in
                print(data)
        }.ensure {

        }.catch { error in
            print(error)
        }
        
        activityIndicator.startAnimating()        
        userRepository.getAll()
            .done { data in
                print(data)
        }.ensure {
            self.activityIndicator.stopAnimating()
        }.catch { error in
            print(error)
        }
        
        activityIndicator.startAnimating()
        userMRepository.getAll()
            .done { data in
                print(data)
        }.ensure {
            self.activityIndicator.stopAnimating()
        }.catch { error in
            print(error)
        }
        
        activityIndicator.startAnimating()
        userMRepository.getIndex()
            .done { data in
                print(data)
        }.ensure {
            self.activityIndicator.stopAnimating()
        }.catch { error in
            print(error)
        }
    }
    
    func test() {
        
//        let df: NSFetchRequest<CDUserPrivate> = CDUserPrivate.fetchRequest()
//        
//        let dfdf = try? db.container.viewContext.fetch(df)
//        
//        print(dfdf)
        
        //      let context = db.container.viewContext
        //        context.perform {
        //
        //            let user = CDUserPrivate(context: context)
        //            user.id = "11"
        //            user.name = "Super"
        //
        //            let user1 = CDUserPrivate(context: context)
        //            user1.id = "111"
        //            user1.name = "Super1"
        //
        //           try? context.save()
        //        }
    }
}

class InMemoryStorage: Storage {

    var store: [String: Any] = [:]
    
    func setString(_ string: String, forKey key: String) {
        store[key] = string
    }
    
    func setData(_ data: Data, forKey key: String) {
        store[key] = data
    }
    
    func setBool(_ bool: Bool, forKey key: String) {
        store[key] = bool
    }

    func getData(_ key: String) -> Data? {
        store[key] as? Data
    }
    
    func getString(_ key: String) -> String? {
        store[key] as? String
    }
    
    func getBool(_ key: String, defaultValue: Bool) -> Bool {
        store[key] as? Bool ?? defaultValue
    }
    
    func deleteValue(_ key: String) {
        store[key] = nil
    }
}

extension Result where Success == Void {
    
    public static func success() -> Self { .success(()) }
}
