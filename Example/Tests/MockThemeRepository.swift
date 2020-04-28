import PromiseKit
import FirebaseRemoteConfig
import SwiftRepository
import RealmSwift
import ObjectMapper

@testable import RepositoryExample

extension Theme {

    static func mockTheme() -> Theme {
        return Theme(JSON: ["themeId": "1",
                            "themeColor": "#FFFFFF"])!
    }
}

class MockThemeRepository: ThemeRepository {

    static func shared() -> ThemeRepository {
        let context: Realm = ServiceLocator.shared.get()
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.configSettings.minimumFetchInterval = 0
        remoteConfig.setDefaults(fromPlist: "RemoteConfig")
        return MockThemeRepository(local: RealmStore(context), remote: remoteConfig)
    }
    
    override func getThemes() -> Promise<[Theme]> {
        return Promise<[Theme]>.value([Theme.mockTheme()])
    }
}
