

import Foundation
import SwiftyJSON
import ObjectMapper

public class BaseChat: NSObject, Mappable  {
    
    internal let kChannelsKey:                  String = "channels"

	public var channels = Array<Channels>()


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

        
        if let items = json[kChannelsKey].array {
            for item in items {
                channels.append( Channels(json: item))
            }
        }
        
        
    }
    
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    public func mapping(map: Map) {

        
        var records: [Channels]?
        records <- map[kChannelsKey]
        if let records = records {
            for record in records {
                channels.append(record)
            }
        }
    }
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        
        dictionary.updateValue(channels as AnyObject, forKey: kChannelsKey)

        
        return dictionary
    }

}
