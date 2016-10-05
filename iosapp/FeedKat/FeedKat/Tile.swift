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
    
    init(title:String)
    {
        super.init(frame:CGRect (x: 0, y: 0, width: Static.tileWidth - Static.tileMarging/2, height: Static.tileHeight))
        backgroundColor = UIColor.white
        
        let banner = UIView()
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.backgroundColor = Static.OrangeColor
        addSubview(banner)
        addConstraint(NSLayoutConstraint(item: banner, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.01, constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
