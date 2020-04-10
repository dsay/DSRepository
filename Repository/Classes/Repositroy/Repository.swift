import Foundation

public enum RepositoryError: LocalizedError {
    
    case objectNotFound
    case fileNotExists
    case cantSaveObject
    case cantDeleteObject
    case unknown
    
    case invalidURL(url: String)
    case jsonEncodingFailed(error: Error)
}

public protocol Repository {

}
