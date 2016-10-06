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
    var container:UIStackView!
    var imgbot:[UIButton] = []
    var list_tile = [Tile]()
    let icon_height = (UIScreen.main.bounds.size.height/10)*0.5
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        bot = UIView()
        bot.backgroundColor = Static.BlueColor
        bot.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bot)
        view.addConstraint(NSLayoutConstraint(item: bot, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bot, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bot, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bot, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        
        top = UIView()
        top.backgroundColor = Static.BlueColor
        top.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(top)
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.12, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        
        scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.masksToBounds = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: bot, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: top, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.78, constant: 0))
        
        loadScroll()
        
    }
    
    func initTop(title:String)
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
    
    func initBanner(i:Int)
    {
        let icon_space = (UIScreen.main.bounds.size.width-icon_height*3)/6
        imgbot.append(UIButton())
        imgbot.append(UIButton())
        imgbot.append(UIButton())
        
        imgbot[0].setImage(Static.getScaledImageWithHeight("Icon_home", height: icon_height), for: UIControlState())
        imgbot[1].setImage(Static.getScaledImageWithHeight("Icon_cats", height: icon_height), for: UIControlState())
        imgbot[2].setImage(Static.getScaledImageWithHeight("Icon_settings", height: icon_height), for: UIControlState())
        
        for i in 0...(imgbot.count-1)
        {
            imgbot[i].frame = CGRect(x: icon_space + CGFloat(i)*(UIScreen.main.bounds.size.width/3),
                                     y:((UIScreen.main.bounds.size.height/10) - icon_height)/2,
                                     width: icon_height,
                                     height: icon_height)
            bot.addSubview(imgbot[i])
        }
        
        var bar : UIView
        bar = UIView(frame: CGRect(x: CGFloat(i)*UIScreen.main.bounds.size.width/3,
                                   y: 0,
                                   width:UIScreen.main.bounds.size.width/3,
                                   height: UIScreen.main.bounds.size.height/100))
        bar.backgroundColor = Static.OrangeColor
        
        bot.addSubview(bar)
    }
    
    func loadScroll()
    {
        var heightStack : CGFloat = 0
        
        for _ in list_tile
        {
            heightStack += (Static.tileSpacing + Static.tileHeight)
        }
        heightStack -= Static.tileSpacing
        
        container = UIStackView(frame : CGRect(x: Static.tileMarging, y: Static.tileSpacing/2, width: Static.tileWidth, height: heightStack))
        container.autoresizesSubviews = true
        container.axis = .vertical
        container.spacing = Static.tileSpacing
        container.distribution = .fillProportionally
        
        scrollView.addSubview(container)
        
        var i = 0
        for cell in list_tile
        {
            container.insertArrangedSubview(cell, at: i)
            i+=1
        }
        
        scrollView.contentSize.height = heightStack + Static.tileSpacing
        scrollView.contentSize.width = 1
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
