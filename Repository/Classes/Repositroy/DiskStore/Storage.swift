import Foundation

public protocol Storage {

    func getData(_ key: String) -> Data?

    @discardableResult
    func set(_ value: Data, forKey key: String) -> Bool

    func get(_ key: String) -> String?

    @discardableResult
    func set(_ value: String, forKey key: String) -> Bool

    func get(_ key: String) -> Bool

    @discardableResult
    func set(_ value: Bool, forKey key: String) -> Bool

    @discardableResult
    func delete(_ key: String) -> Bool
}
