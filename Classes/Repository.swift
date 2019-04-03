import UIKit

public enum RepositoryError: Error {
    case objectNotFound
    case fileNotExists
}

public protocol Repository {
    associatedtype Item

    static func `default`() -> Self
}
