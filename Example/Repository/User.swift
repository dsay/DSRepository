import ObjectMapper
import RealmSwift
import ObjectMapperAdditions
import ObjectMapper_Realm

class User: Object, Mappable {
    
    @objc dynamic var id: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var company: String = ""
    @objc dynamic var email: String = ""
    
    var friends = List<Friend>()

    required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id <- map["_id"]
        firstName <- map["name.first"]
        lastName <- map["name.last"]
        company <- map["company"]
        email <- map["email"]
        friends <- map["friends"]
    }
}

class Friend: Object, Mappable {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
