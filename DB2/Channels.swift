
import Foundation
import SwiftyJSON
import ObjectMapper

public class Channels: NSObject, Mappable  {

    internal let kUseridKey:                                String = "id"
    internal let kLastMessageKey:                           String = "last_message"
    internal let kUsersKey:                                 String = "users"
    internal let kUserunread_messages_countKey:             String = "unread_messages_count"

    dynamic public var id = 0
    var users                                               = Array<Users>()
    public var last_message                                 : LastMessage?
    dynamic public var unread_messages_count                = 0

    
    
    
    
    required public init?(map: Map){
        super.init()
    }
    
    required public override init() {
        super.init()
    }
    
    
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }
    
    /**
     Initates the class based on the JSON that was passed.
     - parameter json: JSON object from SwiftyJSON.
     - returns: An initalized instance of the class.
     */
    public init(json: JSON) {
        super.init()

        id = json[kUseridKey].intValue
        unread_messages_count = json[kUserunread_messages_countKey].intValue
         last_message = LastMessage(json: json[kLastMessageKey])
        
        
        if let items = json[kUsersKey].array {
            for item in items {
                users.append( Users(json: item))
            }
        }
        

        
    }
    
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    public func mapping(map: Map) {

        id <- map[kUseridKey]
        unread_messages_count <- map[kUserunread_messages_countKey]
        last_message <- map[kLastMessageKey]

        var users: [Users]?
        users <- map[kUsersKey]
        if let users = users {
            for record in users {
                self.users.append(record)
            }
        }

    }
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]

        dictionary.updateValue(id as AnyObject, forKey: kUseridKey)
        dictionary.updateValue(unread_messages_count as AnyObject, forKey: kUserunread_messages_countKey)
        dictionary.updateValue(users as AnyObject, forKey: kUsersKey)

        
        //        dictionary.updateValue(last_message as AnyObject, forKey: kLastMessageKey)
        if last_message != nil {
            dictionary.updateValue(last_message!.dictionaryRepresentation() as AnyObject, forKey: kLastMessageKey)
        }
        
        
        return dictionary
    }


}
