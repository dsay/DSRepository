import UIKit

public enum RepositoryError: LocalizedError {
    case objectNotFound
    case fileNotExists
    case cantSaveObject
    case cantDeleteObject
    case unknown
}

public protocol Repository {

}
