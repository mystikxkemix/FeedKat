//
//  FeedTime.swift
//  FeedKat
//
//  Created by Mike OLIVA on 07/10/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class FeedTime:NSObject {
    var ID:Int
    var Id_cat:Int
    var Id_dispenser:Int
    var Weight:Int
    var Hour:String
    var Enable:Bool
    
    init(ID:Int, Id_cat:Int, Id_dispenser:Int, Weight:Int, Hour:String, Enable:Bool)
    {
        self.ID = ID
        self.Id_cat = Id_cat
        self.Id_dispenser = Id_dispenser
        self.Weight = Weight
        self.Hour = Hour
        self.Enable = Enable
        super.init()
    }
    
    override init()
    {   self.ID = -1
        self.Id_cat = -1
        self.Id_dispenser = -1
        self.Weight = -1
        self.Hour = ""
        self.Enable = false
        super.init()
    }
}
