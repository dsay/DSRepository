import ObjectMapper

public protocol KeycheinStoreItem: BaseMappable {
    
    static func primaryKey() -> String
}

public extension KeycheinStoreItem {
    
    static func primaryKey() -> String {
        return String(describing: self)
    }
}
