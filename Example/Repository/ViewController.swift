import UIKit
import SwiftRepository
import AlamofireObjectMapper
import ObjectMapper
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    func updateData() {
        
        activityIndicator.startAnimating()        
        UserRepository.default().getAll()
            .done { data in
                print(data)
            }.ensure {
                self.activityIndicator.stopAnimating()
            }.catch { error in
                print(error)
        }
    }
}


class SomePrivateStore: PrivateStore {

    func getData(_ key: String) -> Data? {
        fatalError()
    }

    @discardableResult
    func set(_ value: Data, forKey key: String) -> Bool{
        fatalError()
    }

    func get(_ key: String) -> String?{
        fatalError()
    }

    @discardableResult
    func set(_ value: String, forKey key: String) -> Bool{
        fatalError()
    }

    func get(_ key: String) -> Bool{
        fatalError()
    }

    @discardableResult
    func set(_ value: Bool, forKey key: String) -> Bool{
        fatalError()
    }

    @discardableResult
    func delete(_ key: String) -> Bool{
        fatalError()
    }
}
