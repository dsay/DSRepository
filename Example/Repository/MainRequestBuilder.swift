import SwiftRepository

class MainRequestBuilder: RequestBuilder {
    
    init(method: HTTPMethod = .get,
         path: String? = nil,
         queryItems: [String: String?]? = nil,
         headers: [String: String]? = nil,
         body: [String: Any]? = nil)
    {
        super.init( method: method,
                    url: "https://next.json-generator.com/api",
                    path: path,
                    queryItems: queryItems,
                    headers: headers,
                    body: body)
    }
}
