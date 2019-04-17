import UIKit

public enum RepositoryError: Error {
    case objectNotFound
    case fileNotExists
}

public protocol Repository {

    static func `default`() -> Self
}
