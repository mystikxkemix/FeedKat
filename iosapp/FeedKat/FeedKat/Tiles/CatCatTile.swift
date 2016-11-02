//
//  CatCatTile.swift
//  FeedKat
//
//  Created by Mike OLIVA on 07/10/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class CatCatTile: Tile
{
    var UiImage:UIImageView!
    var UiIcon:UIImageView!
    var UiName:UILabel!
    var UiStatus:UILabel!
    
    init(cat: Cat)
    {
        super.init()
        let marg=Static.tileWidth*0.03+Static.tileHeight
        let iconsize = Static.tileHeight*0.35
        
        UiImage = UIImageView(frame : CGRect(x: Static.tileWidth*0.01, y: 0, width: Static.tileHeight, height: Static.tileHeight))
        
        UiName = UILabel(frame: CGRect(x: marg, y: Static.tileWidth*0.02, width: Static.tileWidth*0.98-marg, height: Static.tileHeight*0.3))
        UiIcon = UIImageView(frame: CGRect(x: marg - Static.tileWidth*0.01, y: Static.tileHeight*0.57-Static.tileWidth*0.02, width: iconsize, height: iconsize))
        UiIcon.alpha = 0.3
        
        UiStatus = UILabel(frame: CGRect(x: marg + iconsize, y: Static.tileHeight*0.5-Static.tileWidth*0.02, width: Static.tileWidth*0.98-marg-iconsize, height: Static.tileHeight*0.5))
        
        switch cat.getStatus()
        {
        case 1:
            UiIcon.image = Static.getScaledImageWithHeight("Icon_check", height: iconsize)
            break
        case 2:
            UiIcon.image = Static.getScaledImageWithHeight("Icon_cross", height: iconsize)
            break
        default:
            break
        }
        
        var Im:UIImage
        
        if(cat.getPhoto() != "")
        {
            Im = Static.getScaledImageWithHeight("photo_batmane", height: Static.tileHeight)
        }
        else
        {
            Im = Static.getScaledImageWithHeight("Icon", height: Static.tileHeight)
        }
        
        UiImage.image = Im
        addSubview(UiImage)
        
        addSubview(UiIcon)
        
        UiName.text = cat.getName()
        UiName.textColor = Static.OrangeColor
        UiName.numberOfLines = 1
        UiName.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        UiName.textAlignment = NSTextAlignment.center
        addSubview(UiName)
        
        UiStatus.text = cat.getMessage()
        UiStatus.numberOfLines=2
        UiStatus.textColor = UIColor.black
        UiStatus.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        UiStatus.textAlignment = NSTextAlignment.center
        addSubview(UiStatus)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
