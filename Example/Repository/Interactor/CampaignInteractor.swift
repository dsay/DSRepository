import SwiftRepository
import PromiseKit
import Alamofire

protocol Interactor {

}

class CampaignInteractor: Interactor {

    var session = ActionSessionRepository.default()
    var campaignRepository = CampaignRepository.default()
    var conectivity: Connectivity = Connectivity()
    var themeRepository = ThemeRepository.default()

    private lazy var themes: [Theme] = {
        return self.themeRepository.getLocalThemes()
    }()

    var isNetworkAvailable: Bool {
        return conectivity.isConnectedToInternet()
    }
    
    func getCampaigns(_ userID: String) -> Promise<[Campaign]> {
        return firstly {
            when(fulfilled: self.session.get(), self.themeRepository.getThemes())
        }.then { token, _ in
            self.campaignRepository.getCampaignIDs(token: token.accessToken, userID: userID)
                .then { campaignIDs in
                    self.campaignRepository.getCampaigns(token: token.accessToken, userID: userID, ids: campaignIDs).map { self.fillTheme(campaigns: $0) }
            }
        }.recover { _ in
            self.campaignRepository.getCampaigns(token: "", userID: "", ids: []).map { self.fillTheme(campaigns: $0) }
        }
    }

    func getStoredCamapigns() -> Promise<[Campaign]> {
        return campaignRepository.getStoredCampaigns().map { self.fillTheme(campaigns: $0) }
    }

    private func fillTheme(campaigns: [Campaign]) -> [Campaign] {
        campaigns.forEach { self.fillTheme(campaign: $0) }
        return campaigns
    }

    @discardableResult
    private func fillTheme(campaign: Campaign) -> Campaign {
        campaign.theme = themes.first(where: { $0.id == campaign.themeId })
        return campaign
    }
}
