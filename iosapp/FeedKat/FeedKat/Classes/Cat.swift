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
    static var list:[Cat]
    
    static func getList() -> [Cat]
    {
        return list
    }
    
    init(ID: Int, Name: String, Birhdate:Date)
    {
        if(list == nil)
        {
            list = []
        }
    }
}
