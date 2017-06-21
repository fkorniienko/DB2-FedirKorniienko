

import Foundation
import SwiftyJSON
import ObjectMapper

public class Messages: NSObject, Mappable {



    
    internal let kUsercreate_dateKey:               String = "create_date"
    internal let kSenderKey:                        String = "sender"
    internal let kUseris_readKey:                   String = "is_read"
    internal let ktextKey:                          String = "text"
    
    dynamic public var create_date                  = ""
    public var sender                               : SenderUser?
    dynamic public var is_read                      = ""
    dynamic public var text                         = ""
    
    
    
    
    
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
        
        create_date = json[kUsercreate_dateKey].stringValue
        is_read = json[kUseris_readKey].stringValue
        sender = SenderUser(json: json[kSenderKey])
        text = json[ktextKey].stringValue
        
        
        
        
        
        
    }
    
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    public func mapping(map: Map) {
        
        create_date <- map[kUsercreate_dateKey]
        is_read <- map[kUseris_readKey]
        sender <- map[kSenderKey]
        text <- map[ktextKey]
        
        
        
    }
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valcreate_date values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        
        dictionary.updateValue(create_date as AnyObject, forKey: kUsercreate_dateKey)
        dictionary.updateValue(is_read as AnyObject, forKey: kUseris_readKey)
        dictionary.updateValue(text as AnyObject, forKey: ktextKey)
        
        if sender != nil {
            dictionary.updateValue(sender!.dictionaryRepresentation() as AnyObject, forKey: kSenderKey)
        }
        
        
        return dictionary
    }

}
