//
//  AlertTile.swift
//  FeedKat
//
//  Created by Mike OLIVA on 06/10/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class AlertTile:Tile
{
    init(title:String)
    {
        super.init()
        backgroundColor = Static.RedColor
        banner.removeFromSuperview()
        
        let ico = UIImageView()
        ico.image = Static.getScaledImageWithHeight("Icon_alert", height: Static.tileHeight*0.7)
        ico.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(ico)
        addConstraint(NSLayoutConstraint(item: ico, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: ico, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: ico, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: ico, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: ico, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.3, constant: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
