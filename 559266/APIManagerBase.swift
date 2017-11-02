import Foundation
import UIKit

class APIManagerBase{    
    let baseUrl = URL(string:"https://inhollandbackend.azurewebsites.net/api/")
    
    func perform(Method method: String,
                 fromPath path: String,
                 withHeaders headers: [String:String] = [:],
                 andParameters parameters: [String:AnyObject] = [:],
                 withSuccess success: @escaping (Any) ->(),
                 orFailure failure: @escaping (String) -> ()) -> URLSessionDataTask{
        let url = URL(string: path, relativeTo: baseUrl)
        var request = URLRequest(url: url!)
        request.httpMethod = method

        if let paramData = parameters.stringFromHttpParameters().data(using: .utf8){
            request.httpBody = paramData
        }
        
        
        for (key, value) in headers{
            request.addValue(value , forHTTPHeaderField: key )
        }

        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request, completionHandler:{(
            optData: Data?, response: URLResponse?, error: Error?) -> () in
            
            if let data = optData{
                if method != "PUT" && method != "DELETE"{
                    do {
                        let json = try JSONSerialization.jsonObject(with: data,  options: JSONSerialization.ReadingOptions())
                        success(json)
                    }
                    catch{
                        failure("NO JSON CONVERSION")
                    }
                }
                else{
                    success("Put done")
                }
            }
        })

        dataTask.resume()
        return dataTask
    }
    
    
    func get(atPath path: String,
             withHeaders headers: [String:String] = [:],
             andParameters parameters: [String:AnyObject] = [:],
             withSuccess success: @escaping (Any) ->(),
             orFailure failure: @escaping (String) -> ()) -> URLSessionDataTask{
        return perform(Method: "GET", fromPath: path, withHeaders: headers, andParameters: parameters, withSuccess: success, orFailure: failure)
    }
    
    func post(atPath path: String,
              withHeaders headers: [String:String] = [:],
              andParameters parameters: [String:AnyObject] = [:],
              withSuccess success: @escaping (Any) ->(),
              orFailure failure: @escaping (String) -> ()) -> URLSessionDataTask{
        return perform(Method: "POST",
                       fromPath: path,
                       withHeaders: headers,
                       andParameters: parameters,
                       withSuccess: success,
                       orFailure: failure)
    }
    
    func put(atPath path: String,
             withHeaders headers: [String:String] = [:],
             andParameters parameters: [String:AnyObject] = [:],
             withSuccess success: @escaping (Any) ->(),
             orFailure failure: @escaping (String) -> ()) -> URLSessionDataTask{
        return perform(Method: "PUT",
                       fromPath: path,
                       withHeaders: headers,
                       andParameters: parameters,
                       withSuccess: success,
                       orFailure: failure)
    }

    func delete(atPath path: String,
             withHeaders headers: [String:String] = [:],
             andParameters parameters: [String:AnyObject] = [:],
             withSuccess success: @escaping (Any) ->(),
             orFailure failure: @escaping (String) -> ()) -> URLSessionDataTask{
        return perform(Method: "DELETE",
                       fromPath: path,
                       withHeaders: headers,
                       andParameters: parameters,
                       withSuccess: success,
                       orFailure: failure)
    }

    
    
}

//extensions
extension String {
    
    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    ///
    /// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// - returns: Returns percent-escaped string.
    
    func addingPercentEncodingForURLQueryValue() -> String? {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)
        
        return addingPercentEncoding(withAllowedCharacters: allowed)
    }
    
}

extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// - returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    func stringFromHttpParameters() -> String {
        let parameterArray = map { key, value -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joined(separator: "&")
    }
    
}
