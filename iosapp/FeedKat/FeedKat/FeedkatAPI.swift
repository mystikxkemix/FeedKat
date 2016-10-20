//
//  FeedkatAPI.swift
//  FeedKat
//
//  Created by Mike OLIVA on 18/10/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import Foundation
import Alamofire

open class FeedKatAPI:NSObject
{
    fileprivate static var isLocal = true
    fileprivate static var prodServerAddr = "http://feedkat.ddns.net:80/api/index.php"
    fileprivate static var localServerAddr = "http://192.168.43.12:80/api/index.php"
    
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

}
