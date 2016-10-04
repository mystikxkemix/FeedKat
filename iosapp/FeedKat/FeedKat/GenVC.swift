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
    var bot:UIView!
    var top:UIView!
    var UITitle:UILabel!
    var scrollView:UIScrollView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        bot = UIView()
        bot.backgroundColor = Static.OrangeColor
        bot.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bot)
        view.addConstraint(NSLayoutConstraint(item: bot, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bot, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bot, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bot, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        
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
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: bot, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: top, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.78, constant: 0))
        
        initTop(title: "DashBoard", index: 1)
        initBanner()
    }
    
    func initTop(title:String, index:Int)
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
        
    }
    
    func initBanner()
    {
        let icon_width = UIScreen.main.bounds.size.width/6
        let icon_space = (UIScreen.main.bounds.size.width-icon_width*4)/5
        var imgbot = [UIImageView]()
        imgbot.append(UIImageView(image: Static.getScaledImageWithWidth("Icon", width: icon_width)))
        imgbot.append(UIImageView(image: Static.getScaledImageWithWidth("Icon", width: icon_width)))
        imgbot.append(UIImageView(image: Static.getScaledImageWithWidth("Icon", width: icon_width)))
        imgbot.append(UIImageView(image: Static.getScaledImageWithWidth("Icon", width: icon_width)))
        
        
        for i in 0...(imgbot.count-1)
        {
            imgbot[i].frame = CGRect(x: CGFloat(i+1)*icon_space + CGFloat(i)*icon_width, y:0, width: icon_width, height: icon_width)
            bot.addSubview(imgbot[i])
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
