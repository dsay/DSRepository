import Foundation

public protocol RequestBodyConvertible {
    
    func toHTTPBody() throws -> Data?
}

public struct JSONRequestBody: RequestBodyConvertible {
    
    var json: [String: Any]?
    
    public init(json: [String: Any]?) {
        self.json = json
    }
    
    public func toHTTPBody() throws -> Data? {
        guard let bodyParameters = json else { return nil }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
            return data
        } catch {
            throw RepositoryError.jsonEncodingFailed(error: error)
        }
    }
}
