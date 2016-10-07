//
//  DashDistTile.swift
//  FeedKat
//
//  Created by Mike OLIVA on 07/10/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class DashDistTile:Tile
{
    var UIImage:UIImageView!
    var UIName:UILabel!
    var UIStatus:UILabel!
    var UIBackBar:UIView!
    var UIBar:UIView!
    
    init(Name:String, Fill:Int)
    {
        super.init()
        
        let marg=Static.tileWidth*0.03+Static.tileHeight
        
        UIImage = UIImageView(frame : CGRect(x: Static.tileWidth*0.01, y: 0, width: Static.tileHeight, height: Static.tileHeight))
        UIName = UILabel(frame: CGRect(x: marg, y: Static.tileWidth*0.02, width: Static.tileWidth*0.98-marg, height: Static.tileHeight*0.3))
        UIStatus = UILabel(frame: CGRect(x: marg, y: Static.tileWidth*0.04+Static.tileHeight*0.3, width: Static.tileWidth*0.98-marg, height: Static.tileHeight*0.3))
        UIBar = UIView(frame: CGRect(x: marg, y: Static.tileHeight*0.8, width: (Static.tileWidth*0.98-marg)*(CGFloat(Fill)*0.01), height: Static.tileHeight*0.1))
        
        UIBackBar = UIView(frame: CGRect(x: marg-2, y: Static.tileHeight*0.8-2, width: (Static.tileWidth*0.98-marg)+4, height: Static.tileHeight*0.1+4))
        UIBackBar.layer.borderWidth = 1
        UIBackBar.layer.borderColor = UIColor.black.cgColor
        
        UIName.text = Name
        UIName.textColor = Static.OrangeColor
        UIName.numberOfLines = 1
        UIName.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        UIName.textAlignment = NSTextAlignment.center
        addSubview(UIName)
        
        UIImage.image = Static.getScaledImageWithHeight("Icon_dis", height: Static.tileHeight)
        addSubview(UIImage)
        
        UIStatus.text = "Niveau de croquette :"
        UIStatus.numberOfLines=2
        UIStatus.textColor = UIColor.black
        UIStatus.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        UIStatus.textAlignment = NSTextAlignment.center
        addSubview(UIStatus)
        
        if(Fill > 75)
        {
            UIBar.backgroundColor = UIColor.green
        }
        else if(Fill > 50)
        {
            UIBar.backgroundColor = UIColor.yellow
        }
        else if(Fill > 25)
        {
            UIBar.backgroundColor = Static.OrangeColor
        }
        else
        {
            UIBar.backgroundColor = Static.RedColor
        }
        
        addSubview(UIBackBar)
        addSubview(UIBar)
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
