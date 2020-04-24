import ObjectMapper
import SwiftRepository

public class CardToken: Mappable {

    var accessToken: String = ""
    var refreshToken: String = ""

    required public init?(map: Map) {}

    public func mapping(map: Map) {
        accessToken <- map["accessToken"]
        refreshToken <- map["refreshToken"]
    }
}

extension CardToken {

    static func get() -> RequestProvider {
        return MainRequestBuilder(method: .post, path: "/token")
    }
}
