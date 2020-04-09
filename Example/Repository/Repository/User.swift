import RealmSwift
import SwiftRepository

class User: Object, Codable {

    @objc dynamic var id: String = ""
    @objc dynamic var company: String = ""
    @objc dynamic var email: String = ""
    
    @objc dynamic var name: Name? = nil

    var friends = List<Friend>()
    
    override class func primaryKey() -> String? {
        return #keyPath(id)
    }
    
//    override static func ignoredProperties() -> [String] {
//        return ["email"]
//    }
//
//    override static func indexedProperties() -> [String] {
//         return ["email"]
//     }
    
    enum CodingKeys: String, CodingKey {
      case id = "_id"
      case name
      case company
      case email
      case friends
    }
}

class Friend: Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}

class Name: Object, Codable {
    @objc dynamic var first: String = ""
    @objc dynamic var last: String = ""
}
