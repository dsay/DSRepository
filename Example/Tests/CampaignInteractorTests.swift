import Quick
import Nimble
import SwiftRepository

@testable import RepositoryExample

class CampaignInteractorTests: QuickSpec {
    
    override func spec() {
        var interactor: CampaignInteractor!
        
        beforeEach {
            interactor = CampaignInteractor()
            interactor.session = MockActionSessionRepository.shared()
            interactor.campaignRepository = MockCampaignRepository.shared()
            interactor.themeRepository = MockThemeRepository.shared()
        }

        describe("check internet connection") {
            it("Internet should be connected") {
                expect(interactor.isNetworkAvailable).to(beTrue())
            }
        }

        describe("call get campaigns") {
            it("should return stored campaign if session failed") {
                interactor.session = MockFailActionSessionRepository.shared()
                let storedCmapaign = Campaign.storedCampaign()
                waitUntil { done in
                    interactor.getCampaigns("").done { campaigns in
                        expect(campaigns.first?.id).to(equal(storedCmapaign.id))
                        done()
                    }.catch { _ in
                        fail()
                    }
                }
            }

            it("should return stored campaign if user id is not correct") {
                let storedCmapaign = Campaign.storedCampaign()
                waitUntil { done in
                    interactor.getCampaigns("").done { campaigns in
                        expect(campaigns.first?.id).to(equal(storedCmapaign.id))
                        done()
                    }.catch { _ in
                        fail()
                    }
                }
            }

            it("should return mock campaign if user id is correct") {
                let mockCmapaign = Campaign.mockCampaign()
                waitUntil { done in
                    interactor.getCampaigns("12345").done { campaigns in
                        expect(campaigns.first?.id).to(equal(mockCmapaign.id))
                        done()
                    }.catch { _ in
                        fail()
                    }
                }
            }
        }
    }
}
