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
        
        let banner = UIView()
        banner.backgroundColor = UIColor.black
        banner.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(banner)
        view.addConstraint(NSLayoutConstraint(item: banner, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: banner, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: banner, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: banner, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        
        //v.userInteractionEnabled = true
        //v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.resize)))
        
        // Do any additional setup after loading the view, typically from a nib.
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
