import UIKit

class ServiceLocator {

    static let shared = ServiceLocator()

    private var registry: [ServiceKey: Any] = [:]

    static func inject<T>() -> T {
        return ServiceLocator.shared.get()
    }

    func register<T>(service: T) {
        let key = ServiceKey(serviceType: T.self)
        registry[key] = service
    }

    func get<T>() -> T {
        let key = ServiceKey(serviceType: T.self)
        if let service = registry[key] as? T {
            return service
        } else {
            fatalError("Service: \(T.self) was not registerd!!!")
        }
    }

    func unregister<T>(service: T) {
        let key = ServiceKey(serviceType: T.self)
        registry.removeValue(forKey: key)
    }
}

private struct ServiceKey {

    let serviceType: Any.Type
}

extension ServiceKey: Hashable {

    static func == (lhs: ServiceKey, rhs: ServiceKey) -> Bool {
        return lhs.serviceType == rhs.serviceType
    }

    public func hash(into hasher: inout Hasher) {
        ObjectIdentifier(serviceType).hash(into: &hasher)
    }
}

@propertyWrapper
struct Injection<T> {

    var wrappedValue: T {
        get {
            return ServiceLocator.shared.get()
        }
        set {
            ServiceLocator.shared.register(service: newValue)
        }
    }
}
