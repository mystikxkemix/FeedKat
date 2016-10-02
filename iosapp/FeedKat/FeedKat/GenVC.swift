//
//  GenVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 19/09/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class GenVC : UIViewController
{
    var banner:UIView!
    var top:UIView!
    var UITitle:UILabel!
    var scrollView:UIScrollView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        banner = UIView()
        banner.backgroundColor = Static.OrangeColor
        banner.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(banner)
        view.addConstraint(NSLayoutConstraint(item: banner, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: banner, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: banner, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: banner, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        
        top = UIView()
        top.backgroundColor = Static.OrangeColor
        top.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(top)
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.12, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: banner, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: top, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.78, constant: 0))
        
        initView(title: "DashBoard", index: 1)
    }
    
    func initView(title:String, index:Int)
    {
        UITitle = UILabel()
        UITitle.translatesAutoresizingMaskIntoConstraints = false
        UITitle.textColor = UIColor.white
        UITitle.text = title
        UITitle.font = UIFont(name: "Arial Rounded MT Bold", size: 30)!
        UITitle.numberOfLines = 1
        UITitle.sizeToFit()
        
        top.addSubview(UITitle)
        top.addConstraint(NSLayoutConstraint(item: UITitle, attribute: .centerX, relatedBy: .equal, toItem: top, attribute: .centerX, multiplier: 1, constant: 0))
        top.addConstraint(NSLayoutConstraint(item: UITitle, attribute: .centerY, relatedBy: .equal, toItem: top, attribute: .centerY, multiplier: 1, constant: 5))
        
        //top.addConstraint(NSLayoutConstraint(item: UITitle, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UITitle.bounds.width))
        //top.addConstraint(NSLayoutConstraint(item: UITitle, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UITitle.bounds.height))
        
        
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
