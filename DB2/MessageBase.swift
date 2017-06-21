
import Foundation
import SwiftyJSON
import ObjectMapper

public class MessageBase: NSObject, Mappable {
    
    internal let kmessagesKey:                  String = "messages"
    
    public var messages = Array<Messages>()
    
    
    required public init?(map: Map){
        super.init()
    }
    
    required public override init() {
        super.init()
    }
    
    
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }
    
    public init(json: JSON) {
        super.init()
        
        
        if let items = json[kmessagesKey].array {
            for item in items {
                messages.append( Messages(json: item))
            }
        }
        
        
    }
    
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    public func mapping(map: Map) {
        
        
        var records: [Messages]?
        records <- map[kmessagesKey]
        if let records = records {
            for record in records {
                messages.append(record)
            }
        }
    }
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        
        dictionary.updateValue(messages as AnyObject, forKey: kmessagesKey)
        
        
        return dictionary
    }
    


}
