import PromiseKit
import SwiftRepository

struct ImageRepository: Repository, Syncable, Storable {

    let remote: RemoteStoreAlamofire
    let local: LocalStoreFileManager

    func getImage(for url: String) -> Promise<UIImage> {
        let theFileName = (url as NSString).lastPathComponent
        return firstly {
            self.loadImageFromDiskWith(fileName: theFileName)
        }.recover { _ in
            self.loadImage(for: url)
        }
    }

    private func loadImage(for url: String) -> Promise<UIImage> {
        let theFileName = (url as NSString).lastPathComponent
        return firstly {
            self.remote.requestData(request: UIImage.get(url))
        }.then {
            self.local.saveItem($0, at: theFileName)
        }.then {
            self.loadImageFromDiskWith(fileName: theFileName)
        }
    }

    private func loadImageFromDiskWith(fileName: String) -> Promise<UIImage> {
        firstly {
            self.local.getItem(from: fileName)
        }.then {
            Promise.value(UIImage(data: $0)!)
        }
    }
}
