import Foundation

public enum Response<Value, Error> {
    case success(Value)
    case error(Error)

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

    var error: Error? {
        switch self {
        case .error(let value):
            return value
        default:
            return nil
        }
    }
}
