import SwiftRepository

extension UserDefaults: Storage {

    public func getData(_ key: String) -> Data? {
        return value(forKey: key) as? Data
    }

    @discardableResult
    public func set(_ value: Data, forKey key: String) -> Bool {
        setValue(value, forKey: key)
        return synchronize()
    }

    public func get(_ key: String) -> String? {
        return string(forKey: key)
    }

    @discardableResult
    public func set(_ value: String, forKey key: String) -> Bool {
        setValue(value, forKey: key)
        return synchronize()
    }

    public func get(_ key: String) -> Bool {
        return (value(forKey: key) as? Bool) ?? false
    }

    @discardableResult
    public func set(_ value: Bool, forKey key: String) -> Bool {
        setValue(value, forKey: key)
        return synchronize()
    }

    @discardableResult
    public func delete(_ key: String) -> Bool {
        removeObject(forKey: key)
        return synchronize()
    }
}
