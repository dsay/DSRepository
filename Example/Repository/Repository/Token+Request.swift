import SwiftRepository

extension Token {
    
    static func login(_ email: String, _ password: String) -> RequestProvider {
         MainRequestBuilder(path: "")
    }
    
    static func refresh(_ token: Token) -> RequestProvider {
         MainRequestBuilder(path: "")
    }
}
