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
        super.init(frame:CGRect (x: 0, y: 0, width: view.getWidth(), height: view.getHeight()))
        backgroundColor = UIColor.black
//        translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0.5
        
        //---------------------------------------
        UICenter = UIView()
        UICenter.translatesAutoresizingMaskIntoConstraints = false
        UICenter.backgroundColor = UIColor.white
        UICenter.layer.cornerRadius = 10
        
        addSubview(UICenter)
        addConstraint(NSLayoutConstraint(item: UICenter, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: UICenter, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: UICenter, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.3, constant: 0))
        addConstraint(NSLayoutConstraint(item: UICenter, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.8, constant: 0))
        
        
        //---------------------------------------
        ButonOK = UIButton()
        ButonOK.layer.cornerRadius = 10
        ButonOK.layer.borderWidth = 1
        ButonOK.layer.borderColor = UIColor.black.cgColor
        ButonOK.setTitleColor(UIColor.black, for: UIControlState())
        ButonOK.setTitle("Ok", for: UIControlState())
        ButonOK.addTarget(self, action: #selector(self.okButtonImplementation), for: UIControlEvents.touchUpInside)
        ButonOK.translatesAutoresizingMaskIntoConstraints = false
        
        UICenter.addSubview(ButonOK)
        UICenter.addConstraint(NSLayoutConstraint(item: ButonOK, attribute: .bottom, relatedBy: .equal, toItem: UICenter, attribute: .bottom, multiplier: 1, constant: -20))
        UICenter.addConstraint(NSLayoutConstraint(item: ButonOK, attribute: .centerX, relatedBy: .equal, toItem: UICenter, attribute: .centerX, multiplier: 1, constant: 0))
        UICenter.addConstraint(NSLayoutConstraint(item: ButonOK, attribute: .height, relatedBy: .equal, toItem: UICenter, attribute: .height, multiplier: 0.1, constant: 0))
        UICenter.addConstraint(NSLayoutConstraint(item: ButonOK, attribute: .width, relatedBy: .equal, toItem: UICenter, attribute: .width, multiplier: 0.5, constant: 0))
        
        
        //---------------------------------------
        Texttile = UILabel()
        Texttile.text = text
        Texttile.textColor = UIColor.black
        Texttile.translatesAutoresizingMaskIntoConstraints = false
        Texttile.adjustsFontSizeToFitWidth = true
        Texttile.textAlignment = NSTextAlignment.center
        
        UICenter.addSubview(Texttile)
        UICenter.addConstraint(NSLayoutConstraint(item: Texttile, attribute: .centerX, relatedBy: .equal, toItem: UICenter, attribute: .centerX, multiplier: 1, constant: 0))
        UICenter.addConstraint(NSLayoutConstraint(item: Texttile, attribute: .top, relatedBy: .equal, toItem: UICenter, attribute: .top, multiplier: 1, constant: 10))
        UICenter.addConstraint(NSLayoutConstraint(item: Texttile, attribute: .width, relatedBy: .equal, toItem: UICenter, attribute: .width, multiplier: 0.8, constant: 0))
        UICenter.addConstraint(NSLayoutConstraint(item: Texttile, attribute: .height, relatedBy: .equal, toItem: UICenter, attribute: .height, multiplier: 0.5, constant: 0))
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ViewFunc()
    {
        isHidden = false
    }


    func okButtonImplementation(_ sender:UIButton)
    {
        UICenter.removeFromSuperview()
        ButonOK.removeFromSuperview()
        self.removeFromSuperview()
    }
}
