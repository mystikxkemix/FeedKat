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
        
        let ico = UIImageView(frame: CGRect(x: Static.tileWidth*0.02, y: (Static.tileHeight-Static.iconAlertSize)/2, width: Static.iconAlertSize, height: Static.iconAlertSize))
        ico.image = Static.getScaledImageWithHeight("Icon_alert", height: Static.iconAlertSize)
        addSubview(ico)
        
        let marg = Static.tileWidth*0.02 + Static.iconAlertSize + Static.tileWidth*0.02
        
        let text = UILabel(frame: CGRect(x: marg, y: Static.tileWidth*0.02, width: Static.tileWidth-marg-Static.tileWidth*0.02, height: Static.tileHeight-Static.tileWidth*0.04))
        text.numberOfLines = 3
        text.textColor = UIColor.white
        text.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        text.textAlignment = NSTextAlignment.center
        text.text = title
        
        addSubview(text)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
