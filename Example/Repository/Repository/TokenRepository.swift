import SwiftRepository
import PromiseKit

struct TokenRepository: Repository, Syncable, Storable {
    
    private struct Constants {
        static let key = String(describing: Token.self)
    }
    
    let remote: RemoteStoreCodable<Token>
    let local: LocalStoreCodable<Token>
    
    func get()-> Token? {
        try? local.get(from: Constants.key)
    }
    
    func login(_ email: String, _ password: String) -> Promise<Token> {
        firstly {
            self.remote.requestObject(request: Token.login(email, password))
        }
    }
    
    func refresh() -> Promise<Token> {
        firstly {
            self.local.getItem(from: Constants.key)
        }.then {
            self.remote.requestObject(request: Token.refresh($0))
        }.then {
            self.local.saveItem($0, at: Constants.key)
        }.then { _ in
            self.local.getItem(from: Constants.key)
        }
    }
}
