
import Foundation
import SwiftyJSON
import ObjectMapper



public class SenderUser: NSObject, Mappable {

    internal let kUserlast_nameKey:                         String = "last_name"
    internal let kUseridKey:                                String = "id"
    internal let kphotoKey:                                 String = "photo"
    internal let kusernameKey:                              String = "username"
    internal let kfirst_nameKey:                            String = "first_name"
    
    dynamic public var last_name                            = ""
    dynamic public var id                                   = 0
    dynamic public var photo                                = ""
    dynamic public var username                             = ""
    dynamic public var first_name                           = ""
    
    
    
    
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
        
        last_name = json[kUserlast_nameKey].stringValue
        id = json[kUseridKey].intValue
        photo = json[kphotoKey].stringValue
        username = json[kusernameKey].stringValue
        first_name = json[kfirst_nameKey].stringValue

        
        
        
        
        
        
    }
    
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    public func mapping(map: Map) {
        
        last_name <- map[kUserlast_nameKey]
        id <- map[kUseridKey]
        photo <- map[kphotoKey]
        username <- map[kusernameKey]
        first_name <- map[kfirst_nameKey]
        
        
        
    }
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all vallast_name values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        
        dictionary.updateValue(last_name as AnyObject, forKey: kUserlast_nameKey)
        dictionary.updateValue(id as AnyObject, forKey: kUseridKey)
        dictionary.updateValue(photo as AnyObject, forKey: kphotoKey)
        dictionary.updateValue(username as AnyObject, forKey: kusernameKey)
        dictionary.updateValue(first_name as AnyObject, forKey: kfirst_nameKey)
        
        return dictionary
    }


}
