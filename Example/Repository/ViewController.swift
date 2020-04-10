import UIKit
import SwiftRepository
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @Injection
    var userRepository: UserRepository
    
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
    }
}
