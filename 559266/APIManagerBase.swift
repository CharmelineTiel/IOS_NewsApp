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
//
//        if let paramData = parameters.stringFromHttpParameters().data(using: .utf8){
//            request.httpBody = paramData
//        }
//        
        
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

