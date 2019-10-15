import UIKit

public enum RepositoryError: LocalizedError {
    case objectNotFound
    case fileNotExists
    case unknown
}

public protocol Repository {

}
