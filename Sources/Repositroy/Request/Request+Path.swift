import Foundation

extension String: URLComposer {
    
    public func compose(into url: URL) throws -> URL {
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw RepositoryError.invalidURL(url: url)
        }
        
        components.path += self.escape()
        
        guard let aUrl = components.url else {
            throw RepositoryError.invalidURL(url: url)
        }
        
        return aUrl
    }
}

extension Array: URLComposer where Element == String {
    
    public func toPath() -> String {
        compactMap {
            $0 == "" ? nil : $0
        }.map {
            $0.escape()
        }.flatMap {
            $0
        }.compactMap {
            $0.hasPrefix("/") ? $0 : "/" + $0
        }.joined()
    }
    
    public func compose(into url: URL) throws -> URL {
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw RepositoryError.invalidURL(url: url)
        }
        
        components.path += self.toPath()
        
        guard let aUrl = components.url else {
            throw RepositoryError.invalidURL(url: url)
        }
        
        return aUrl
    }
}
