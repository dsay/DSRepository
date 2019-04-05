import UIKit

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

