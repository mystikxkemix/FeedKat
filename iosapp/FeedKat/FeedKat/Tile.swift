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
    var banner:UIView!
    
    init()
    {
        super.init(frame:CGRect (x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight))
        self.heightAnchor.constraint(equalToConstant: Static.tileHeight).isActive = true
        backgroundColor = UIColor.white
        
        banner = UIView()
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.backgroundColor = Static.OrangeColor
        addSubview(banner)
        addConstraint(NSLayoutConstraint(item: banner, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.01, constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
