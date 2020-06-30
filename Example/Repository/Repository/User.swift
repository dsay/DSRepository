//import RealmSwift
//import SwiftRepository
//import ObjectMapper
//
////class User: Object, Codable {
//class User: Object, Mappable {
//
//    @objc dynamic var id: String = ""
//    @objc dynamic var company: String = ""
//    @objc dynamic var email: String = ""
//    
//    @objc dynamic var name: Name? = nil
//
//    var friends = List<Friend>()
//    
//    override class func primaryKey() -> String? {
//        return #keyPath(id)
//    }
//    
////    override static func ignoredProperties() -> [String] {
////        return ["email"]
////    }
////
////    override static func indexedProperties() -> [String] {
////         return ["email"]
////     }
//    
////    enum CodingKeys: String, CodingKey {
////      case id = "_id"
////      case name
////      case company
////      case email
////      case friends
////    }
//    
//    required convenience init?(map: Map) {
//        self.init()
//    }
//    
//    public func mapping(map: Map) {
//        id <- map["_id"]
//        name <- map["name"]
//        company <- map["company"]
//        email <- map["email"]
//        friends <- (map["friends"], ListTransform<Friend>())
//    }
//}
//
////class Friend: Object, Codable {
//class Friend: Object, Mappable {
//    
//    @objc dynamic var id: Int = 0
//    @objc dynamic var name: String = ""
//    
//    required convenience init?(map: Map) {
//        self.init()
//    }
//    
//    public func mapping(map: Map) {
//        id <- map["_id"]
//        name <- map["name"]
//    }
//}
//
////class Name: Object, Codable {
//class Name: Object, Mappable {
//
//    @objc dynamic var first: String = ""
//    @objc dynamic var last: String = ""
//    
//    required convenience init?(map: Map) {
//        self.init()
//    }
//    
//    public func mapping(map: Map) {
//        first <- map["first"]
//        last <- map["last"]
//    }
//}
