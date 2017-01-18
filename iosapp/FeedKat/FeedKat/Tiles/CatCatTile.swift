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
    var UiName:UILabel!
    var UiLastFeed:UILabel!
    var UiNextFeed:UILabel!
    var parent:CatBoardVC!
    
    init(cat: Cat, parent:CatBoardVC)
    {
        super.init(type: -1)
        self.parent = parent
        let marg=Static.tileWidth*0.03+Static.tileHeight*0.75
        let iconsize = Static.tileHeight*0.35
        
        UiImage = UIImageView(frame : CGRect(x: Static.tileWidth*0.01, y: 0, width: Static.tileHeight, height: Static.tileHeight))
        
        UiName = UILabel(frame: CGRect(x: marg, y: Static.tileWidth*0.02, width: Static.tileWidth*0.98-marg, height: Static.tileHeight*0.3))
        
        UiLastFeed = UILabel(frame: CGRect(x: marg + iconsize, y: Static.tileHeight*0.5, width: Static.tileWidth*0.98-marg-iconsize, height: Static.tileHeight*0.2))
        
        UiNextFeed = UILabel(frame: CGRect(x: marg + iconsize, y: Static.tileHeight*0.7, width: Static.tileWidth*0.98-marg-iconsize, height: Static.tileHeight*0.2))
        
        if(cat.image == nil)
        {
            if(cat.getPhoto() != "")
            {
                if let checkedUrl = URL(string: cat.getPhoto())
                {
                    FeedKatAPI.downloadImage(url: checkedUrl, view: UiImage)
                    {
                        data in
                        cat.image = Static.getScaledUIImageWithHeight(data!, height: Static.tileHeight)
                        self.UiImage.image = cat.image!
                    }
                }
                else
                {
                    self.UiImage.image = Static.getScaledImageWithHeight("Icon", height: Static.tileHeight)
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
        
        UiName.text = cat.getName()
        UiName.textColor = Static.OrangeColor
        UiName.numberOfLines = 1
        UiName.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        UiName.textAlignment = NSTextAlignment.center
        addSubview(UiName)
        
        let lastfeed = Static.StringToInt(str: "2016:11:02:08:00:00")
        let lastweight = Static.StringToInt(str: "1000")
        
        if(lastfeed[2] == Static.nowDay)
        {
            if(lastfeed[3] == Static.nowHour)
            {
                if(lastfeed[4] == Static.nowMinute)
                {
                    UiLastFeed.text = "Last feed : \(lastweight[0])g maintenant"
                }
                else
                {
                    UiLastFeed.text = "Last feed : \(lastweight[0])g il y a \(Static.nowMinute - lastfeed[4])min"
                    UiLastFeed.textColor = UIColor.green
                }
            }
            else
            {
                UiLastFeed.text = "Last feed : \(lastweight[0])g il y a \(Static.nowHour - lastfeed[3])h"
                UiLastFeed.textColor = Static.OrangeColor
            }
        }
        else
        {
            UiLastFeed.text = "Last feed : \(lastweight[0])g il y a \(Static.nowDay - lastfeed[2])d"
            UiLastFeed.textColor = Static.RedColor
        }
        
        UiLastFeed.numberOfLines=1
        UiLastFeed.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
        UiLastFeed.textAlignment = NSTextAlignment.left
//        addSubview(UiLastFeed)
        
        var next:FeedTime = FeedTime()
        
        var h:[Int]
        
        for a in cat.getFeeds()
        {
            h = Static.StringToInt(str: a.Hour)
            if(h[0] > Static.nowHour || (h[0] == Static.nowHour && h[1] > Static.nowMinute))
            {
                next = a
                break
            }
        }
        
        if(cat.getFeeds().count != 0)
        {
            var text = "Prochain Repas : "
            if(next.Hour != "")
            {
                h = Static.StringToInt(str: next.Hour)
                if( (h[0]-Static.nowHour) == 0)
                {
                    text += "\(next.Weight)g dans \(h[1] - Static.nowMinute)min"
                }
                else
                {
                    if( (h[0]-Static.nowHour) > 0)
                    {
                        text += "\(next.Weight)g dans \(h[0] - Static.nowHour)h"
                    }
                    else
                    {
                        text += "\(next.Weight)g dans \(h[0] - Static.nowHour + 24)h"
                    }
                }
                UiNextFeed.text = text
            }
        }
        
        UiNextFeed.numberOfLines=1
        UiNextFeed.textColor = UIColor.black
        UiNextFeed.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
        UiNextFeed.textAlignment = NSTextAlignment.left

        addSubview(UiNextFeed)
        
        setEnabled(true)
        actionWidth = Static.tileWidth*0.20
        setActionHeightMultiplier(0.5)
        setActionColor(color: Static.TransparentColor)
        setActionImage(img: Static.getScaledImageWithHeight("Icon_cross", height: Static.tileHeight))
        
        addActionTarget {
            
            Cat.list.remove(at: Cat.list.index(of: cat)!)
            self.parent.container.removeAllSubviews()
            self.parent.list_tile = []
            self.parent.loadScroll()
            
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
