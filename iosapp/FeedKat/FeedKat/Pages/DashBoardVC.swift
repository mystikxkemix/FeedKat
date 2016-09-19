//
//  DashBoardVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 13/09/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class DashBoard: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = Static.BlueColor
        
        let banner = UIView()
        banner.backgroundColor = Static.OrangeColor
        banner.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(banner)
        view.addConstraint(NSLayoutConstraint(item: banner, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: banner, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: banner, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: banner, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        
        let top = UIView()
        top.backgroundColor = Static.OrangeColor
        top.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(top)
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.12, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        
        
    }
    
    func resize(_ sender: AnyObject)
    {
        let v = sender.view as UIView
        
        v.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        v.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 2))
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
