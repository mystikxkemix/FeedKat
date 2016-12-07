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
    var UiImage:UIImageView!
    var UiIcon:UIImageView!
    var UiName:UILabel!
    var UiStatus:UILabel!
    
    init(cat:Cat)
    {
        super.init(type: -1)
        
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
            case 0:
                UiIcon.image = Static.getScaledImageWithHeight("Icon_cross", height: iconsize)
                break
            default:
                break
        }
        
        if(cat.image == nil)
        {
            if(cat.getPhoto() != "")
            {
                self.UiImage.image = Static.getScaledImageWithHeight("Icon", height: Static.tileHeight)
                if let checkedUrl = URL(string: cat.getPhoto())
                {
                    FeedKatAPI.downloadImage(url: checkedUrl, view: UiImage)
                    {
                        data in
                        if(data != nil)
                        {
                            cat.image = Static.getScaledUIImageWithHeight(data!, height: Static.tileHeight)
                        }
                    }
                }
            }
            else
            {
                UiImage.image = Static.getScaledImageWithHeight("Icon", height: Static.tileHeight)
            }
        }
        else
        {
            UiImage.image = cat.image!
        }
        
        addSubview(UiImage)

        
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
