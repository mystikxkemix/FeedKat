//
//  Cat.swift
//  FeedKat
//
//  Created by Mike OLIVA on 07/10/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class Cat:NSObject
{
    static var list:[Cat] = []
    var Name:String
    var ID:Int
    var Status:Int
    var Message:String
    var Photo:String
    var Birthdate:String
    var feeds:[FeedTime]
    var image:UIImage? = nil
    var loaded:Bool = false
    var weight:Int = 1000
    var statusBattery:Int = 75
    
    static func getList() -> [Cat]
    {
        return list
    }
    
    init(ID: Int, Name: String, Message:String, Photo:String, Status:Int, Weight:Int, FeedTimes : [NSDictionary]?)
    {
        self.Name = Name
        self.ID = ID
        self.Message = Message
        self.Status = Status
        self.Photo = Photo
        self.Birthdate=""
        self.weight = Weight
        self.feeds = []
        if(FeedTimes != nil)
        {
            for a in FeedTimes!
            {
                let ids_ft = a.value(forKey: "id_feedtime") as! String
                let id_ft = Int(ids_ft)!
                let ids_ds = a.value(forKey: "id_dispenser") as! String
                let id_ds = Int(ids_ds)!
                let time = a.value(forKey: "time") as! String
                let sweight = a.value(forKey: "weight") as! String
                let weight = Int(sweight)!
                let sena = a.value(forKey: "enabled") as! String
                let ena = Int(sena)! == 1
                
                feeds.append(FeedTime(ID: id_ft, Id_cat: ID, Id_dispenser: id_ds, Weight: weight, Hour: time, Enable: ena))
            }
        }
        super.init()
        Cat.list.append(self)
    }
    
    func getDetails(handler: @escaping(Bool?)->())
    {
        if(loaded)
        {
            handler(true)
            return
        }
        FeedKatAPI.getCatDetails(ID)
        {
            response, error in
            if(error == nil)
            {
                let cats = (response?.value(forKey: "cats") as! NSArray)[0] as! NSDictionary
                self.statusBattery = cats.value(forKey: "battery") as? Int ?? -1
                self.loaded = true
                handler(true)
            }
            else
            {
                handler(false)
            }
        }
    }
    
    func getName() -> String
    {
        return self.Name
    }
    
    func getID() -> Int
    {
        return self.ID
    }
    
    func getMessage() -> String
    {
        return self.Message
    }
    
    func getPhoto() -> String
    {
        return self.Photo
    }
    
    func getStatus() -> Int
    {
        return self.Status
    }
    
    func getBirthdate() -> String
    {
        return self.Birthdate;
    }
    
    func getFeeds() -> [FeedTime]
    {
        return self.feeds
    }
}
