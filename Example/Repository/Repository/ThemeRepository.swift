import PromiseKit
import FirebaseRemoteConfig
import SwiftRepository
import RealmSwift
import ObjectMapper

enum RemoteConfigError: Error {
    case wrongStatus, noValue
}

class ThemeRepository {

    private struct Constants {
        static let themeKey = "action_themes"
        static let plistName = "RemoteConfig"
        static let minimumFetchInterval: TimeInterval = 0
    }

    private let local: RealmStore<Theme>
    private let remote: RemoteConfig
    
    init(local: RealmStore<Theme>, remote: RemoteConfig) {
        self.local = local
        self.remote = remote
    }

    static func `default`() -> ThemeRepository {
        let context: Realm = ServiceLocator.shared.get()
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.configSettings.minimumFetchInterval = Constants.minimumFetchInterval
        remoteConfig.setDefaults(fromPlist: Constants.plistName)
        return ThemeRepository(local: RealmStore(context), remote: remoteConfig)
    }

    func getThemes() -> Promise<[Theme]> {
        return firstly {
            fetchThemesJson().map { [Theme](JSONString: $0) ?? [] }
        }.then {
            self.local.save($0)
        }.then {
            self.local.getItems()
        }.recover { _ in
            self.local.getItems()
        }
    }

    func getLocalThemes() -> [Theme] {
        return local.getItems()
    }

    private func fetchThemesJson() -> Promise<String> {
        return Promise { resolver in
            self.remote.fetch(withExpirationDuration: Constants.minimumFetchInterval) { (status, error) in
                if let error = error {
                    resolver.reject(error)
                }

                if status == .success {
                    //ignore error here because of https://github.com/firebase/firebase-ios-sdk/issues/3586 is still open
                    self.remote.activate { _ in
                        if let value = self.remote.configValue(forKey: Constants.themeKey).stringValue {
                            resolver.fulfill(value)
                        } else {
                            resolver.reject(RemoteConfigError.noValue)
                        }
                    }
                } else {
                    resolver.reject(RemoteConfigError.wrongStatus)
                }
            }
        }
    }
}
