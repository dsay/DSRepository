import Foundation

public enum Response<Value> {
    case success(Value)
    case error(RequestError)

    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }

    var value: Value? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }

    var error: RequestError? {
        switch self {
        case .error(let value):
            return value
        default:
            return nil
        }
    }
}

public enum RequestError: Error {
    case notAuthorized(Int, String)
    case error(Int, String)

    var localizedDescription: String {
        switch self {
        case .notAuthorized(_, let value):
            return value
        case .error(_, let value):
            return value
        }
    }
}
