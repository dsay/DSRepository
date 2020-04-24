import SwiftRepository
import RealmSwift
import PromiseKit
import Alamofire

class CampaignRepository: Repository, Storable, Syncable {

    let remote: ObjectsStore<Campaign>
    let remoteIDs: ObjectsStore<CampaignID>
    let local: RealmStore<Campaign>
    
    init(remote: ObjectsStore<Campaign>, remoteIDs: ObjectsStore<CampaignID>, local: RealmStore<Campaign>) {
        self.remote = remote
        self.remoteIDs = remoteIDs
        self.local = local
    }

    static func `default`() -> CampaignRepository {
        let session: Alamofire.Session = ServiceLocator.shared.get()
        let local: Realm = ServiceLocator.shared.get()

        return CampaignRepository(remote: ObjectsStore(session: session, handler: BaseHandler(DEBUGLog())),
                                  remoteIDs: ObjectsStore(session: session, handler: BaseHandler(DEBUGLog())),
                                  local: RealmStore<Campaign>(local))
    }

    func getCampaignIDs(token: String, userID: String) -> Promise<[CampaignID]> {
        remoteIDs.requestArray(request: Campaign.getIDs(token: token, userID: userID), keyPath: "campaigns")
    }

    func getCampaigns(token: String, userID: String, ids: [CampaignID]) -> Promise<[Campaign]> {
        let campaignIDs = ids.map {$0.id}
        return firstly {
            self.remote.requestArray(request: Campaign.getCampaigns(token: token, userID: userID, campaignIDs: campaignIDs))
        }.then {
            self.local.save($0)
        }.then {
            self.local.getItems()
        }.recover { _ in
            self.local.getItems()
        }
    }

    func getStoredCampaigns() -> Promise<[Campaign]> {
        local.getItems()
    }

    func removeAll() -> Promise<Void> {
        return firstly {
            self.local.getItems()
        }.then {
            self.local.remove($0)
        }.recover {_ in }
    }
}
