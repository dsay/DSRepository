import Foundation

public enum RepositoryError: LocalizedError {
    
    case notFound
    case notUpdate
    case notSave
    case notDelete
    case notExists
    case unknown
    
    case serialize

    case invalidURL(url: String)
    case jsonEncodingFailed(error: Error)
}

public protocol Repository {

}
