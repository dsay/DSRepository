import SwiftRepository
import PromiseKit

class ActionSessionRepository: Repository, Syncable {

    let remote: ObjectsStore<CardToken>
    
    init(remote: ObjectsStore<CardToken>) {
        self.remote = remote
    }

    static func `default`() -> ActionSessionRepository {
        
        let clientID: String = Bundle.main.object(forInfoDictionaryKey: "ActionClientID") as? String ?? ""
        let clientSecret = Bundle.main.object(forInfoDictionaryKey: "ActionClientSecret") as? String ?? ""
        let session: CardSessionManager = CardSessionManager.default(clientID: clientID, clientSecret: clientSecret)
        return ActionSessionRepository(remote: ObjectsStore(session: session, handler: BaseHandler(DEBUGLog())))
    }

    func get() -> Promise<CardToken> {
        return remote.requestObject(request: CardToken.get(), keyPath: "data")
    }
}
