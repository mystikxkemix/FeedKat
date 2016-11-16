import Foundation
import Alamofire

open class FeedKatAPI:NSObject
{
    fileprivate static var isLocal = false
    fileprivate static var prodServerAddr = "http://feedkat.ddns.net:80/api/index.php"
    fileprivate static var localServerAddr = "http://192.168.43.12:80/api/index.php"
    
    open static func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url)
        {   (data, response, error) in
                completion(data, response, error)
        }.resume()
    }
    
    open static func downloadImage(url: URL, view : UIImageView, handler: @escaping(UIImage?) -> ())
    {
        getDataFromUrl(url: url)
        { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                view.image = UIImage(data: data)
                handler(UIImage(data: data))
            }
        }
    }
    
    open static func login(_ mail: String!, password: String!, handler: @escaping (NSDictionary?, NSError?) -> ())
    {
        let link = (isLocal ? localServerAddr : prodServerAddr) + "/login"
        
        var params = Parameters()
        _ = params.updateValue(mail, forKey: "mail")
        _ = params.updateValue(password, forKey: "password")
        
        Alamofire.request(link, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON
            { response in
                if let JSON = response.result.value
                {
                    let error = (JSON as! NSDictionary).value(forKey: "error") as! Int
                    if (error == 0)
                    {
                        handler(JSON as? NSDictionary, nil)
                        return
                    }
                    else
                    {
                        handler(nil, NSError(domain: "Could not login", code: 0, userInfo: nil))
                        return
                    }
                }
                else
                {
                    handler(nil, NSError(domain: "Could not connect to the server.", code: -1, userInfo: nil))
                    return
                }
            }
    }
    
    open static func register(_ mail: String!, password: String!,last: String!, first: String!, handler: @escaping (NSDictionary?, NSError?) -> ())
    {
        let link = (isLocal ? localServerAddr : prodServerAddr) + "/register"
        
        var params = Parameters()
        _ = params.updateValue(mail, forKey: "mail")
        _ = params.updateValue(password, forKey: "password")
        _ = params.updateValue(last, forKey: "surname")
        _ = params.updateValue(first, forKey: "first_name")
        
        Alamofire.request(link, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON
            { response in
                if let JSON = response.result.value
                {
                    let error = (JSON as! NSDictionary).value(forKey: "error") as! Int
                    if (error == 0)
                    {
                        handler(JSON as? NSDictionary, nil)
                        return
                    }
                    else
                    {
                        handler(nil, NSError(domain: "Could not create user", code: 1, userInfo: nil))
                        return
                    }
                }
                else
                {
                    handler(nil, NSError(domain: "Could not connect to the server.", code: -1, userInfo: nil))
                    return
                }
        }
    }
    
    open static func getCatbyUserId(_ userId:Int!, handler: @escaping (NSDictionary?, NSError?) -> ())
    {
        let link = (isLocal ? localServerAddr : prodServerAddr) + "/cat/user/\(userId!)"
        
        Alamofire.request(link, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON
            { response in
                if let JSON = response.result.value
                {
                    let error = (JSON as! NSDictionary).value(forKey: "error") as! Int
                    if (error == 0)
                    {
                        handler(JSON as? NSDictionary, nil)
                        return
                    }
                    else
                    {
                        handler(nil, NSError(domain: "Wrong user Id", code: 1, userInfo: nil))
                        return
                    }
                }
                else
                {
                    handler(nil, NSError(domain: "Could not connect to the server.", code: -1, userInfo: nil))
                    return
                }
                
            }
    }
    
    open static func getDispById(_ userId:Int!, handler: @escaping (NSDictionary?, NSError?)->())
    {
        let link = (isLocal ? localServerAddr : prodServerAddr) + "/dispenser/user/\(userId!)"
        
        Alamofire.request(link, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON
            { response in
                if let JSON = response.result.value
                {
                    let error = (JSON as! NSDictionary).value(forKey: "error") as! Int
                    if (error == 0)
                    {
                        handler(JSON as? NSDictionary, nil)
                        return
                    }
                    else
                    {
                        handler(nil, NSError(domain: "Wrong user Id", code: 1, userInfo: nil))
                        return
                    }
                }
                else
                {
                    handler(nil, NSError(domain: "Could not connect to the server.", code: -1, userInfo: nil))
                    return
                    
                }
        }
        
    }
    
    open static func getCatDetails(_ catId:Int!, handler: @escaping (NSDictionary?, NSError?)->())
    {
        let link = (isLocal ? localServerAddr : prodServerAddr) + "/cat/\(catId!)/details"
        
        Alamofire.request(link, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON
            { response in
                if let JSON = response.result.value
                {
                    let error = (JSON as! NSDictionary).value(forKey: "error") as! Int
                    if (error == 0)
                    {
                        handler(JSON as? NSDictionary, nil)
                        return
                    }
                    else
                    {
                        handler(nil, NSError(domain: "Wrong user Id", code: 1, userInfo: nil))
                        return
                    }
                }
                else
                {
                    handler(nil, NSError(domain: "Could not connect to the server.", code: -1, userInfo: nil))
                    return
                    
                }
            }
    }
    
    open static func modifyCat(_ catId:Int!, name:String!, UiImage:UIImage?, handler:@escaping(NSDictionary?, NSError?) -> ())
    {
        let link = (isLocal ? localServerAddr : prodServerAddr) + "/cat"
        
        var params = Parameters()
        params.updateValue(catId, forKey: "id_cat")
        params.updateValue(name, forKey: "name")
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key, value) in params
            {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            if (UiImage != nil)
            {
                multipartFormData.append(UIImagePNGRepresentation(UiImage!)!, withName: "photo", fileName: "image.png", mimeType: "image/png")
            }
        }, to: link, method: HTTPMethod.post) { encodingResult in
            switch encodingResult
            {
            case .success(let upload, _, _):
                    upload.responseJSON
                    {
                        response in
                        if (response.result.isSuccess)
                        {
                            let value = response.result.value as! NSDictionary
                            print("value : \(value)")
                            handler(value,nil)
                            return
                        }
                        else
                        {
                            handler(nil, NSError(domain: "Fuck", code: 1, userInfo: nil))
                        }
                    }
            case .failure:
                handler(nil, NSError(domain: "Could not connect to the server. Try again.", code: 66, userInfo: nil))
                return
            }
        }

    }

}
