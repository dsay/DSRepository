import Foundation

public protocol RequestPathConvertible {

    func toPath() -> String
}

extension String: RequestPathConvertible {
    
    public func toPath() -> String {
        return self
    }
}

extension Array: RequestPathConvertible where Element == String {
    
    public func allowed() -> CharacterSet {
        return CharacterSet.urlPathAllowed
    }
    
    public func toPath() -> String {
        compactMap {
            $0.addingPercentEncoding(withAllowedCharacters: allowed()) ?? ""
        }.reduce("") {
            $0 + $1
        }
    }
}
