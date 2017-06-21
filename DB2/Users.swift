

import Foundation
import SwiftyJSON
import ObjectMapper


public class Users: SenderUser {

    internal let kPostuserKey :String = "user"
    
    dynamic public var user   :SenderUser?
    
    
    /**
     Initates the class based on the JSON that was passed.
     - parameter json: JSON object from SwiftyJSON.
     - returns: An initalized instance of the class.
     */
    public override init(json: JSON) {
        super.init(json: json)
        
        user = SenderUser(json: json[kPostuserKey])
        
    }
    
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }
    required public init?(map: Map){
        super.init(map: map)
    }
    
    required public init() {
        fatalError("init() has not been implemented")
    }
    

    public override func mapping(map: Map) {
        super.mapping(map: map)
        
        user <- map[kPostuserKey]
        
        
    }

    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    override public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary = super.dictionaryRepresentation()
        
        if user != nil {
            dictionary.updateValue(user!.dictionaryRepresentation() as AnyObject, forKey: kPostuserKey)
        }
        
        return dictionary
    }

}
