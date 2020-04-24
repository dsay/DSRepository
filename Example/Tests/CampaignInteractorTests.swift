import Quick
import Nimble
import SwiftRepository

@testable import RepositoryExample

class CampaignInteractorTests: QuickSpec {
    
    override func spec() {
        var interactor: CampaignInteractor!
        
        beforeEach {
            interactor = CampaignInteractor()
            interactor.session = MockFailActionSessionRepository.shared()
            interactor.campaignRepository = MockCampaignRepository.shared()
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
        }
    }
}
