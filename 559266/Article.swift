
import Foundation

public class Article {
    
	public var id : Int?
	public var feed : Int?
	public var title : String?
	public var summary : String?
	public var publishDate : String?
	public var image : String?
	public var url : String?
	public var related : Array<String>?
	public var categories : Array<Category>?
	public var isLiked : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let results_list = Article.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Articles Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Article]
    {
        var models:[Article] = []
        for item in array
        {
            models.append(Article(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let results = Results(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Results Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary["Id"] as? Int
		feed = dictionary["Feed"] as? Int
		title = dictionary["Title"] as? String
		summary = dictionary["Summary"] as? String
		publishDate = dictionary["PublishDate"] as? String
		image = dictionary["Image"] as? String
		url = dictionary["Url"] as? String
//		if (dictionary["Related"] != nil) { related = Related.modelsFromDictionaryArray(dictionary["Related"] as! NSArray) }
//		if (dictionary["Categories"] != nil) { categories = Categories.modelsFromDictionaryArray(dictionary["Categories"] as! NSArray) }
		isLiked = dictionary["IsLiked"] as? String
        

	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "Id")
		dictionary.setValue(self.feed, forKey: "Feed")
		dictionary.setValue(self.title, forKey: "Title")
		dictionary.setValue(self.summary, forKey: "Summary")
		dictionary.setValue(self.publishDate, forKey: "PublishDate")
		dictionary.setValue(self.image, forKey: "Image")
		dictionary.setValue(self.url, forKey: "Url")
		dictionary.setValue(self.isLiked, forKey: "IsLiked")

		return dictionary
	}
    
    
}
