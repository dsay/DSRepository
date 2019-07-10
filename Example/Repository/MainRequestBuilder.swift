import SwiftRepository

class MainRequestBuilder: AlamofireRequestBuilder {
    
    init(path: String? = nil,
         keyPath: String? = nil,
         headers: [String: String]? = nil,
         method: HTTPMethod = .get,
         parameters: [String: Any]? = nil,
         encoder: Encoder = .url)
    {
        super.init( method: method,
                    url: "https://next.json-generator.com/api",
                    path: path,
                    headers: headers,
                    parameters: parameters,
                    encoder: encoder,
                    keyPath: keyPath)
    }
}
