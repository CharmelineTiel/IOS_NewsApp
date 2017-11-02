
import Foundation
 

public class Results {
    
    public var results : Array<Article>?
    public var nextId : Int?
/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let Result_list = Result.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Result Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Results]
    {
        var models:[Results] = []
        for item in array
        {
            models.append(Results(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Json4Swift_Base Instance.
*/
	required public init?(dictionary: NSDictionary) {

		if (dictionary["Article"] != nil) { results = Article.modelsFromDictionaryArray(array: dictionary["Article"] as! NSArray) }
		nextId = dictionary["NextId"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.nextId, forKey: "NextId")

		return dictionary
	}

    
    
    
}
