import SwiftRepository
import PromiseKit

@testable import RepositoryExample

extension CardToken {

    static func mockCardToken() -> CardToken {
        return CardToken(JSON: ["accessToken": "12345678",
                                "refreshToken": "11111111"])!
    }
}

class MockActionSessionRepository: ActionSessionRepository {

    static func shared() -> ActionSessionRepository {
        
        let clientID: String = Bundle.main.object(forInfoDictionaryKey: "ActionClientID") as? String ?? ""
        let clientSecret = Bundle.main.object(forInfoDictionaryKey: "ActionClientSecret") as? String ?? ""
        let session: CardSessionManager = CardSessionManager.default(clientID: clientID, clientSecret: clientSecret)
        return MockActionSessionRepository(remote: ObjectsStore(session: session, handler: BaseHandler(DEBUGLog())))
    }
    
    override func get() -> Promise<CardToken> {
        return Promise<CardToken>.value(CardToken.mockCardToken())
    }
}

class MockFailActionSessionRepository: ActionSessionRepository {
    
    static func shared() -> ActionSessionRepository {
        
        let clientID: String = Bundle.main.object(forInfoDictionaryKey: "ActionClientID") as? String ?? ""
        let clientSecret = Bundle.main.object(forInfoDictionaryKey: "ActionClientSecret") as? String ?? ""
        let session: CardSessionManager = CardSessionManager.default(clientID: clientID, clientSecret: clientSecret)
        return MockFailActionSessionRepository(remote: ObjectsStore(session: session, handler: BaseHandler(DEBUGLog())))
    }
    
    override func get() -> Promise<CardToken> {
        return Promise.init(error: ContentError.contentNotFound)
    }
}
