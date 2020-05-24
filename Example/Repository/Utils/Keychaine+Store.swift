import KeychainSwift
import SwiftRepository

extension KeychainSwift: Storage {
    
    public func getData(_ key: String) -> Data? {
        return self.getData(key, asReference: false)
    }
    
    @discardableResult
    public func set(_ value: String, forKey key: String) -> Bool {
        return self.set(value, forKey: key, withAccess: nil)
    }
    
    @discardableResult
    public func set(_ value: Data, forKey key: String) -> Bool {
        return self.set(value, forKey: key, withAccess: nil)
    }
    
    public func get(_ key: String) -> Bool {
        if let value = getBool(key) {
            return value
        }
        return false
    }
    
    @discardableResult
    public func set(_ value: Bool, forKey key: String) -> Bool {
        return set(value, forKey: key, withAccess: nil)
    }
}
