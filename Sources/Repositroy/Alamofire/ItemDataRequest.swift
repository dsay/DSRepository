import Alamofire

extension DataRequest {
    
    static func processResponse(request: URLRequest?, response: HTTPURLResponse?, data: Data?, keyPath: String?) -> Any? {
        
        let jsonResponseSerializer = JSONResponseSerializer(options: .allowFragments)
        if let result = try? jsonResponseSerializer.serialize(request: request, response: response, data: data, error: nil) {
            
            let JSON: Any?
            if let keyPath = keyPath , keyPath.isEmpty == false {
                JSON = (result as AnyObject?)?.value(forKeyPath: keyPath)
            } else {
                JSON = result
            }
            
            return JSON
        }
        
        return nil
    }
    
    
    @discardableResult
    public func responseItem<T>(queue: DispatchQueue = .main,
                                keyPath: String? = nil,
                                mapToObject object: T? = nil,
                                completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self
    {
        return response(queue: queue,
                        responseSerializer: DataRequest.ItemResponseSerializer(mapToObject: object, serializeCallback: {
                            request, response, data, error in
                            
                            let JSONObject = DataRequest.processResponse(request: request, response: response, data: data, keyPath: keyPath)
                            
                            if let object = JSONObject as? T {
                                return object
                            } else {
                                throw AFError.responseSerializationFailed(reason: .decodingFailed(error: RepositoryError.serialize))
                            }
                        }),
                        completionHandler: completionHandler)
    }
    
    public final class ItemResponseSerializer<T>: ResponseSerializer {
        
        public let object: T?
        
        public let serializeCallback: (URLRequest?,HTTPURLResponse?, Data?,Error?) throws -> T
        
        public init(mapToObject object: T? = nil,
                    serializeCallback: @escaping (URLRequest?, HTTPURLResponse?, Data?, Error?) throws -> T) {
            
            self.object = object
            self.serializeCallback = serializeCallback
        }
        
        public func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> T {
            guard error == nil else { throw error! }
            
            guard let data = data, !data.isEmpty else {
                guard emptyResponseAllowed(forRequest: request, response: response) else {
                    throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                }
                
                guard let emptyValue = Empty.value as? T else {
                    throw AFError.responseSerializationFailed(reason: .invalidEmptyResponse(type: "\(T.self)"))
                }
                
                return emptyValue
            }
            return try self.serializeCallback(request, response, data, error)
        }
    }
}

