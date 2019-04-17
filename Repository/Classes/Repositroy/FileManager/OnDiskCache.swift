import UIKit

open class OnDiskCache: OnDiskStore {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    public init() {
    }
    
    public func get(from path: String) throws -> Data {
        let fileURL = documentsDirectory.appendingPathComponent(path)
        return try Data(contentsOf: fileURL)
    }
    
    public func remove(from path: String) throws {
        let fileURL = documentsDirectory.appendingPathComponent(path)
        try FileManager.default.removeItem(at: fileURL)
    }
    
    public func save(_ data: Data, to path: String) throws {
        let fileURL = documentsDirectory.appendingPathComponent(path)
        try data.write(to: fileURL)
    }
    
    public func fileExists(from path: String) -> Bool {
        let fileURL = documentsDirectory.appendingPathComponent(path)
        return FileManager.default.fileExists(atPath: fileURL.absoluteString)
    }
}
