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
