import SwiftRepository
import PromiseKit
import Alamofire
import RealmSwift

@testable import RepositoryExample

public enum ContentError: LocalizedError {
    case contentNotFound
}

extension Campaign {

    static func mockCampaign() -> Campaign {
        return Campaign(JSON: ["campaignId": "2863928632",
                               "tagline": "Campaign tagline",
                               "description": "campaign description",
                               "termsAndConditions": "terms and conditions",
                               "themeId": 1,
                               "requiredPoints": 5,
                               "campaignDateFrom": "2019-10-09T09:00:00",
                               "campaignDateTo": "2019-10-09T09:00:00",
                               "status": "Active",
                               "reward": [
                                    "voucherName": "Gefeliciteerd...",
                                    "voucherCode": "92732ew9wd9t92302y3028",
                                    "expirationDate": "2019-11-09T09:00:00",
                                    "voucherValue": 5.0,
                                    "voucherCurrency": "EUR"],
                               "user": ["acquiredPoints": 5]])!
    }

    static func storedCampaign() -> Campaign {
        return Campaign(JSON: ["campaignId": "88888888",
                               "tagline": "Campaign tagline",
                               "description": "Stored campaign",
                               "termsAndConditions": "terms and conditions",
                               "themeId": 1,
                               "requiredPoints": 5,
                               "campaignDateFrom": "2019-10-09T09:00:00",
                               "campaignDateTo": "2019-10-09T09:00:00",
                               "status": "Active",
                               "reward": [
                                    "voucherName": "Gefeliciteerd...",
                                    "voucherCode": "92732ew9wd9t92302y3028",
                                    "expirationDate": "2019-11-09T09:00:00",
                                    "voucherValue": 5.0,
                                    "voucherCurrency": "EUR"],
                               "user": ["acquiredPoints": 5]])!
    }
}

extension CampaignID {

    static func mockCampaignID() -> CampaignID {
        return CampaignID(JSON: ["campaignId": "2863928632"])!
    }
}

class MockCampaignRepository: CampaignRepository {

    static func shared() -> CampaignRepository {
        let session: Alamofire.Session = ServiceLocator.shared.get()
        let local: Realm = ServiceLocator.shared.get()

        return MockCampaignRepository(remote: ObjectsStore(session: session, handler: BaseHandler(DEBUGLog())),
                                  remoteIDs: ObjectsStore(session: session, handler: BaseHandler(DEBUGLog())),
                                  local: RealmStore<Campaign>(local))
    }

    override func getCampaignIDs(token: String, userID: String) -> Promise<[CampaignID]> {
        if token == "" || userID == "" {
            return Promise.init(error: ContentError.contentNotFound)
        } else {
            return Promise<[CampaignID]>.value([CampaignID.mockCampaignID()])
        }
    }
    
    override func getCampaigns(token: String, userID: String, ids: [CampaignID]) -> Promise<[Campaign]> {
        if token == "" {
            return Promise<[Campaign]>.value([Campaign.storedCampaign()])
        } else {
            return Promise<[Campaign]>.value([Campaign.mockCampaign()])
        }
    }

    override func getStoredCampaigns() -> Promise<[Campaign]> {
        return Promise<[Campaign]>.value([Campaign.mockCampaign()])
    }
}
