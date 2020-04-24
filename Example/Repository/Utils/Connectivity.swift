import Alamofire

class Connectivity {

    var last: Bool = false
    let reachability = NetworkReachabilityManager(host: "www.google.com")!

    func isConnectedToInternet() -> Bool {
        return reachability.isReachable
    }
}
