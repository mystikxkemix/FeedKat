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
        
        /*let v = UIView()
        v.backgroundColor = UIColor.blackColor()
        v.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(v)
        view.addConstraint(NSLayoutConstraint(item: v, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: v, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: v, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.5, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: v, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.5, constant: 0))
        
        v.userInteractionEnabled = true
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.resize)))*/
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func resize(sender: AnyObject)
    {
        let v = sender.view as UIView
        
        v.transform = CGAffineTransformMakeScale(0.5, 0.5)
        v.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / 2))
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
