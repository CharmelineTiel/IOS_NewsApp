
import Foundation

public class Category {
	public var id : Int?
	public var name : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let categories_list = Categories.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Categories Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Category]
    {
        var models:[Category] = []
        for item in array
        {
            models.append(Category(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let categories = Categories(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Categories Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary["Id"] as? Int
		name = dictionary["Name"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "Id")
		dictionary.setValue(self.name, forKey: "Name")

		return dictionary
	}

}
