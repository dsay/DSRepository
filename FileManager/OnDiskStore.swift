import UIKit

class OnDiskCache: OnDiskStore {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    func get(from path: String) throws -> Data {
        let fileURL = documentsDirectory.appendingPathComponent(path)
        return try Data(contentsOf: fileURL)
    }

    func remove(from path: String) throws {
        let fileURL = documentsDirectory.appendingPathComponent(path)
        try FileManager.default.removeItem(at: fileURL)
    }

    func save(_ data: Data, to path: String) throws {
        let fileURL = documentsDirectory.appendingPathComponent(path)
        try data.write(to: fileURL)
    }

    func fileExists(from path: String) -> Bool {
        let fileURL = documentsDirectory.appendingPathComponent(path)
        return FileManager.default.fileExists(atPath: fileURL.absoluteString)
    }
}
