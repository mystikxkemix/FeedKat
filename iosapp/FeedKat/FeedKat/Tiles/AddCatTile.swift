//
//  AddCatTile.swift
//  FeedKat
//
//  Created by Mike OLIVA on 02/11/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class AddCatTile : Tile
{
    var UIIcon:UIImageView!
    
    init()
    {
        super.init(type : -1)
        translatesAutoresizingMaskIntoConstraints = false
        
        UIIcon = UIImageView()
        UIIcon.translatesAutoresizingMaskIntoConstraints = false
        UIIcon.image = Static.getScaledImageWithHeight("Icon_plus", height: Static.tileHeight*0.8)
        addSubview(UIIcon)
        addConstraint(NSLayoutConstraint(item: UIIcon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: UIIcon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: UIIcon, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.8, constant: 0))
        addConstraint(NSLayoutConstraint(item: UIIcon, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.8, constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
