//
//  Tile.swift
//  FeedKat
//
//  Created by Mike OLIVA on 19/09/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class Tile:UIView
{
    init(view: UIView, title:String)
    {
        super.init(frame:CGRect (x: 0, y: 0, width: view.frame.width, height: view.frame.height*0.2))
        backgroundColor = Static.WhiteGrayColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
