//
//  CatTile.swift
//  FeedKat
//
//  Created by Mike OLIVA on 06/10/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class DashCatTile:Tile
{
    var image:UIImageView!
    
    init(title:String)
    {
        super.init()
        image = UIImageView()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
