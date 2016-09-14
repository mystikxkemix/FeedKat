//
//  PopUp.swift
//  FeedKat
//
//  Created by Mike OLIVA on 13/09/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class popUp: UIView {
    
    var UICenter:UIView!
    var ButonOK:UIButton!
    var Texttile:UILabel!
    
    init(view: UIView, text: String)
    {
        super.init(frame:CGRectMake (0, 0, view.frame.width, view.frame.height))
        backgroundColor = UIColor.blackColor()
        self.alpha = 0.5
        
        //---------------------------------------
        UICenter = UIView()
        UICenter.translatesAutoresizingMaskIntoConstraints = false
        UICenter.backgroundColor = UIColor.whiteColor()
        UICenter.layer.cornerRadius = 10
        
        view.addSubview(UICenter)
        view.addConstraint(NSLayoutConstraint(item: UICenter, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: UICenter, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: UICenter, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.3, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: UICenter, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.8, constant: 0))
        
        
        //---------------------------------------
        ButonOK = UIButton()
        ButonOK.layer.cornerRadius = 10
        ButonOK.layer.borderWidth = 1
        ButonOK.layer.borderColor = UIColor.blackColor().CGColor
        ButonOK.setTitleColor(UIColor.blackColor(), forState: .Normal)
        ButonOK.setTitle("Ok", forState: UIControlState.Normal)
        ButonOK.addTarget(self, action: #selector(self.okButtonImplementation), forControlEvents: UIControlEvents.TouchUpInside)
        ButonOK.translatesAutoresizingMaskIntoConstraints = false
        
        UICenter.addSubview(ButonOK)
        UICenter.addConstraint(NSLayoutConstraint(item: ButonOK, attribute: .Bottom, relatedBy: .Equal, toItem: UICenter, attribute: .Bottom, multiplier: 1, constant: -20))
        UICenter.addConstraint(NSLayoutConstraint(item: ButonOK, attribute: .CenterX, relatedBy: .Equal, toItem: UICenter, attribute: .CenterX, multiplier: 1, constant: 0))
        UICenter.addConstraint(NSLayoutConstraint(item: ButonOK, attribute: .Height, relatedBy: .Equal, toItem: UICenter, attribute: .Height, multiplier: 0.1, constant: 0))
        UICenter.addConstraint(NSLayoutConstraint(item: ButonOK, attribute: .Width, relatedBy: .Equal, toItem: UICenter, attribute: .Width, multiplier: 0.5, constant: 0))
        
        
        //---------------------------------------
        Texttile = UILabel()
        Texttile.text = text
        Texttile.textColor = UIColor.blackColor()
        Texttile.translatesAutoresizingMaskIntoConstraints = false
        Texttile.adjustsFontSizeToFitWidth = true
        Texttile.textAlignment = NSTextAlignment.Center
        
        UICenter.addSubview(Texttile)
        UICenter.addConstraint(NSLayoutConstraint(item: Texttile, attribute: .CenterX, relatedBy: .Equal, toItem: UICenter, attribute: .CenterX, multiplier: 1, constant: 0))
        UICenter.addConstraint(NSLayoutConstraint(item: Texttile, attribute: .Top, relatedBy: .Equal, toItem: UICenter, attribute: .Top, multiplier: 1, constant: 10))
        UICenter.addConstraint(NSLayoutConstraint(item: Texttile, attribute: .Width, relatedBy: .Equal, toItem: UICenter, attribute: .Width, multiplier: 0.8, constant: 0))
        UICenter.addConstraint(NSLayoutConstraint(item: Texttile, attribute: .Height, relatedBy: .Equal, toItem: UICenter, attribute: .Height, multiplier: 0.5, constant: 0))
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ViewFunc()
    {
        hidden = false
    }


    func okButtonImplementation(sender:UIButton)
    {
        UICenter.removeFromSuperview()
        ButonOK.removeFromSuperview()
        self.removeFromSuperview()
    }
}
