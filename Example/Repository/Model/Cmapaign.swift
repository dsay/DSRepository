import ObjectMapper
import RealmSwift
import SwiftRepository

class CampaignID: Object, Mappable {

    @objc dynamic var id: String = ""

    override class func primaryKey() -> String? {
        return #keyPath(id)
    }

    required convenience init?(map: Map) {
        self.init()
    }

    public func mapping(map: Map) {
        id <- map["campaignId"]
    }
}

class Campaign: Object, Mappable {

    @objc dynamic var id: String = ""
    @objc dynamic var tagline: String = ""
    @objc dynamic var about: String = ""
    @objc dynamic var themeId: Int = 0
    @objc dynamic var requiredPoints: Int = 0
    @objc dynamic var acquiredPoints: Int = 0
    @objc dynamic var startDate: Date?
    @objc dynamic var expirationDate: Date?
    @objc dynamic var status: String = ""
    @objc dynamic var termsAndConditions: String = ""
    @objc dynamic var reward: Reward?

    var theme: Theme?

    var formattedExpirationDate: String {
        return "01.01.2020"
    }

    override class func primaryKey() -> String? {
        return #keyPath(id)
    }

    required convenience init?(map: Map) {
        self.init()
    }

    public func mapping(map: Map) {
        id <- map["campaignId"]
        tagline <- (map["tagline"])
        status <- map["status"]
        requiredPoints <- map["requiredPoints"]
        acquiredPoints <- map["user.acquiredPoints"]
        startDate <- (map["campaignDateFrom"])
        expirationDate <- (map["campaignDateTo"])
        themeId <- map["themeId"]
        about <- map["description"]
        reward <- map["reward"]
        termsAndConditions <- (map["termsAndConditions"])
    }
}

class Reward: Object, Mappable {

    @objc dynamic var voucherCode: String = ""
    @objc dynamic var voucherName: String = ""
    @objc dynamic var expirationDate: Date?
    @objc dynamic var value: Double = 0
    @objc dynamic var currency: String = ""
    @objc dynamic var status: String = ""

    override class func primaryKey() -> String? {
        return #keyPath(voucherCode)
    }

    required convenience init?(map: Map) {
        self.init()
    }

    public func mapping(map: Map) {
        voucherCode <- map["voucherCode"]
        voucherName <- map["voucherName"]
        expirationDate <- (map["expirationDate"])
        value <- map["voucherValue"]
        currency <- map["voucherCurrency"]
        status <- map["status"]
    }
}

class Theme: Object, Mappable {

    @objc dynamic var id: Int = 0
    @objc dynamic var color: String = ""

    override class func primaryKey() -> String? {
        return #keyPath(id)
    }

    required convenience init?(map: Map) {
        self.init()
    }

    public func mapping(map: Map) {
        id <- map["themeId"]
        color <- map["themeColor"]
    }
}

extension Campaign {

    static func getIDs(token: String, userID: String) -> RequestProvider {
        let headers: [String: String] = [
            Keys.authorization: "\(Keys.bearer) \(token)",
            Keys.requestID: "12345",
            Keys.sourceID: "ACTIONAPP",
            Keys.userToken: userID]
        let path = String(format: "mulesoft/users/%@/campaigns?status=active", userID)
        return MainRequestBuilder(method: .get, path: path, headers: headers)
    }

    static func getCampaigns(token: String, userID: String, campaignIDs: [String]) -> RequestProvider {
        let idsString = campaignIDs.joined(separator: ",")
        let headers: [String: String] = [
            Keys.authorization: "\(Keys.bearer) \(token)",
            Keys.requestID: "12345",
            Keys.sourceID: "ACTIONAPP",
            Keys.userToken: userID]
        let path = String(format: "mulesoft/users/%@/campaigns/campaigndetails?id=%@", userID, idsString)
        return MainRequestBuilder(method: .get, path: path, headers: headers)
    }
}

