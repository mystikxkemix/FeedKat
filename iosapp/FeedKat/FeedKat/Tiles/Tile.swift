//
//  Tile.swift
//  FeedKat
//
//  Created by Mike OLIVA on 19/09/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit
import MadJohTools

class Tile:DragToActionView
{
    var banner:UIView!
    
    init(type: Int)
    {
        if(type == -1)
        {
            super.init(frame:CGRect (x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight))
            self.heightAnchor.constraint(equalToConstant: Static.tileHeight).isActive = true
        }
        else
        {
            super.init(frame:CGRect (x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*3))
            if(type != 2)
            {
                self.heightAnchor.constraint(equalToConstant: Static.tileHeight*3).isActive = true
            }
        }
        
        self.widthAnchor.constraint(equalToConstant: Static.tileWidth).isActive = true
        backgroundColor = UIColor.white
        
        banner = UIView()
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.backgroundColor = Static.OrangeColor
        addSubview(banner)
        addConstraint(NSLayoutConstraint(item: banner, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.01, constant: 0))
        
        setEnabled(false)
    }
    
    init(height: CGFloat)
    {
        super.init(frame:CGRect (x: 0, y: 0, width: Static.tileWidth, height: height))
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        self.widthAnchor.constraint(equalToConstant: Static.tileWidth).isActive = true
        backgroundColor = UIColor.white
        
        banner = UIView()
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.backgroundColor = Static.OrangeColor
        addSubview(banner)
        addConstraint(NSLayoutConstraint(item: banner, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.01, constant: 0))
        
        setEnabled(false)
    }
    
    init(title: String)
    {
        super.init(frame:CGRect (x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight))
        self.heightAnchor.constraint(equalToConstant: Static.tileHeight).isActive = true
        
        self.widthAnchor.constraint(equalToConstant: Static.tileWidth).isActive = true
        backgroundColor = UIColor.white
        
        banner = UIView()
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.backgroundColor = Static.OrangeColor
        addSubview(banner)
        addConstraint(NSLayoutConstraint(item: banner, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.01, constant: 0))
        
        let utitle = UILabel()
        utitle.textColor = UIColor.black
        utitle.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        utitle.textAlignment = NSTextAlignment.center
        utitle.translatesAutoresizingMaskIntoConstraints = false
        utitle.text = title
        addSubview(utitle)
        addConstraint(NSLayoutConstraint(item: utitle, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: utitle, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: utitle, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: utitle, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.99, constant: 0))
        
        setEnabled(false)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
