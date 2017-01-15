//
//  DataCache.swift
//  FeedKat
//
//  Created by Mike OLIVA on 15/01/2017.
//  Copyright © 2017 Mike OLIVA. All rights reserved.
//

import Foundation

public class DataCache
{
    
    //////////////////
    //  SET CACHED  //
    //////////////////
    static func cache(_ value:Any!, forKey:String)
    {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: forKey)
    }
    
    static func cache(_ value:Int!, forKey:String!)
    {
        cache(value as Any!, forKey:forKey)
    }
    
    static func cache(_ value:NSDictionary!, forKey:String!)
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        cache(data as Any, forKey: forKey)
    }
    
    static func cache(_ value:[NSDictionary]!, forKey:String!)
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        cache(data, forKey: forKey)
    }
    
    //////////////////
    //  GET CACHED  //
    //////////////////
    static func getCachedObject(forKey:String!) -> Any?
    {
        let st = UserDefaults.standard
        return st.object(forKey: forKey)
    }
    
    static func getInt(forKey: String!) -> Int?
    {
        let st = UserDefaults.standard;
        return st.integer(forKey: forKey)
    }
    
    static func getNSDictionary(forKey: String!) -> NSDictionary?
    {
        let data : Data? = getCachedObject(forKey: forKey) as? Data
        if (data == nil) { return nil }
        
        let array = NSKeyedUnarchiver.unarchiveObject(with: data!) as! NSDictionary
        return array
    }
    
    static func getNSDictionaryArray(forKey: String!) -> [NSDictionary]?
    {
        let data : Data? = getCachedObject(forKey: forKey) as? Data
        if (data == nil) { return nil }
        
        let array = NSKeyedUnarchiver.unarchiveObject(with: data!) as! [NSDictionary]
        return array
    }
    
    
    //////////////////
    //    REMOVE    //
    //////////////////
    public static func removeCache(forKey: String)
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: forKey)
    }
}
