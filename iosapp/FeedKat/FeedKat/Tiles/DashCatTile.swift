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
    var UIImage:UIImageView!
    var UIIcon:UIImageView!
    var UIName:UILabel!
    var UIStatus:UILabel!
    
    init(Im: UIImage, Name:String, State:Int, Status:String)
    {
        super.init()
        
        let marg=Static.tileWidth*0.03+Static.tileHeight
        let iconsize = Static.tileHeight*0.35
        
        UIImage = UIImageView(frame : CGRect(x: Static.tileWidth*0.01, y: 0, width: Static.tileHeight, height: Static.tileHeight))
        
        UIName = UILabel(frame: CGRect(x: marg, y: Static.tileWidth*0.02, width: Static.tileWidth*0.98-marg, height: Static.tileHeight*0.3))
        UIIcon = UIImageView(frame: CGRect(x: marg - Static.tileWidth*0.01, y: Static.tileHeight*0.57-Static.tileWidth*0.02, width: iconsize, height: iconsize))
        UIIcon.alpha = 0.3
        
        UIStatus = UILabel(frame: CGRect(x: marg + iconsize, y: Static.tileHeight*0.5-Static.tileWidth*0.02, width: Static.tileWidth*0.98-marg-iconsize, height: Static.tileHeight*0.5))
        
        switch State
        {
            case 1:
                UIIcon.image = Static.getScaledImageWithHeight("Icon_check", height: iconsize)
                break
            case 2:
                UIIcon.image = Static.getScaledImageWithHeight("Icon_cross", height: iconsize)
                break
            default:
                break
        }
        
        UIImage.image = Im
        addSubview(UIImage)
        
        addSubview(UIIcon)
        
        UIName.text = Name
        UIName.textColor = Static.OrangeColor
        UIName.numberOfLines = 1
        UIName.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        UIName.textAlignment = NSTextAlignment.center
        addSubview(UIName)
        
        UIStatus.text = Status
        UIStatus.numberOfLines=2
        UIStatus.textColor = UIColor.black
        UIStatus.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        UIStatus.textAlignment = NSTextAlignment.center
        addSubview(UIStatus)
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
