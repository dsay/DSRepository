import UIKit

public protocol OnDiskStorable {
    
    var onDisk: OnDiskStore { get }
}

public protocol OnDiskStore {
    
    func fileExists(from path: String) -> Bool
    func get(from path: String) throws -> Data
    func remove(from path: String) throws
    func save(_ data: Data, to path: String) throws
}
