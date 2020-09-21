import SwiftRepository

extension Token {
    
    static func login(_ email: String, _ password: String) -> RequestProvider {
         Request(path: "")
    }
    
    static func refresh(_ token: Token) -> RequestProvider {
         Request(path: "")
    }
}
