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
    
    init(view: UIView, text: String)
    {
        super.init(frame:CGRectMake (0, 0, view.frame.width, view.frame.height))
        backgroundColor = UIColor.blackColor()
        self.alpha = 0.5
        
        let UICentWidth = view.frame.width * 0.8
        let UICenterHeight = view.frame.height * 0.4
        self.UICenter = UIView(frame: CGRectMake((view.frame.width - UICentWidth) / 2, (view.frame.height - UICenterHeight) / 2,UICentWidth, UICenterHeight))
        self.UICenter.backgroundColor = UIColor.whiteColor()
        self.UICenter.layer.cornerRadius = 10
        
        let buttonHeight = view.frame.height*0.1
        let buttonWidth = view.frame.width*0.4
        self.ButonOK = UIButton(frame: CGRectMake((UICenter.frame.width - buttonWidth) / 2, (UICenter.frame.height - buttonHeight) / 2, buttonWidth, buttonHeight))
        self.ButonOK.setTitle("Ok", forState: UIControlState.Normal)
        ButonOK.addTarget(self, action: #selector(self.okButtonImplementation), forControlEvents: UIControlEvents.TouchUpInside)
        ButonOK.layer.cornerRadius = 10
        ButonOK.layer.borderWidth = 1
        ButonOK.layer.borderColor = UIColor.blackColor().CGColor
        ButonOK.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        view.addSubview(UICenter)
        self.UICenter.addSubview(ButonOK)
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
