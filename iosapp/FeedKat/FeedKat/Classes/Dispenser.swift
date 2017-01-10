//
//  Dispenser.swift
//  FeedKat
//
//  Created by Mike OLIVA on 02/11/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class Dispenser:NSObject
{
    static var list:[Dispenser] = []
    var Name:String
    var ID:Int
    var Status:Int
    
    static func getList() -> [Dispenser]
    {
        return list
    }
    
    init(ID: Int, Name: String, Status:Int)
    {
        self.ID = ID
        self.Name = Name
        self.Status = Status
        super.init()
        Dispenser.list.append(self)
    }
    
    func getName() -> String
    {
        return self.Name
    }
    
    func getID() -> Int
    {
        return self.ID
    }
    
    func getStatus() -> Int
    {
        return self.Status
    }
    
    static func clearList()
    {
        list = []
    }

}
