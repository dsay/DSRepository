import Foundation

public protocol RequestPathConvertible {

    func toPath() -> String
}

extension String: RequestPathConvertible {
    
    public func allowed() -> CharacterSet {
        CharacterSet.urlPathAllowed
    }
    
    public func toPath() -> String {
        addingPercentEncoding(withAllowedCharacters: allowed()) ?? ""
    }
}

extension Array: RequestPathConvertible where Element == String {
    
    public func allowed() -> CharacterSet {
        CharacterSet.urlPathAllowed
    }
    
    public func toPath() -> String {
        compactMap {
            $0 == "" ? nil : $0
        }.map {
            $0.addingPercentEncoding(withAllowedCharacters: allowed())
        }.flatMap {
            $0
        }.compactMap {
            $0.hasPrefix("/") ? $0 : "/" + $0
        }.joined()
    }
}
