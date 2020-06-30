import UIKit
import SwiftRepository
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @Injection
    var userRepository: UserRepository
    @Injection
    var userMRepository: UserMapableRepository
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    func updateData() {
        
        let userID = "1"
        let sd = MainRequestBuilder(method: .get,
                                    path: ["api", "user", userID],
                                    query: ["some" : nil, "some1": "sdf df", "some2": "іваіоа"],
                                    headers: ["asdfadf": "adfsdf"],
                                    body: ["df": ["dfdf":"2342"]])
        
        let request = try! sd.asURLRequest()
        
        print(request.httpMethod ?? "")
        print(request.url  ?? "")
        print(request.allHTTPHeaderFields ?? "")
        print(String(data: request.httpBody ?? Data(), encoding: .utf8) ?? "")
        
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
