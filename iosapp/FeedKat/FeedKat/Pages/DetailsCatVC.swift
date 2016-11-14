//
//  DetailsCatVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 04/11/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class DetailsCatBoardVC : UIViewController
{
    var top:UIView!
    var UITitle:UILabel!
    var scrollView:UIScrollView!
    var container:UIStackView!
    var list_tile = [Tile]()
    var UIBot = [UIButton]()
    let icon_height = (UIScreen.main.bounds.size.height/10)*0.5
    var catId:Int = -1
    var cat:Cat? = nil
    var fromC:Bool? = nil
    
    override func viewDidLoad()
    {
        self.cat = Cat.getList()[catId]
        
        super.viewDidLoad()
        
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
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: top, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.88, constant: 0))
        
        loadScroll()
        
        initTop(title: cat!.getName())
        
        let arrow = UIButton(frame: CGRect(x: Int(Static.screenWidth*0.03), y: Int(Static.screenHeight*0.05), width: Int(Static.screenHeight*0.05), height: Int(Static.screenHeight*0.05)))
        arrow.setImage(Static.getScaledImageWithHeight("Arrow_left", height: Static.screenHeight*0.05), for: UIControlState())
        
        top.addSubview(arrow)
        arrow.addTarget(self, action: #selector(self.gotoBack(_:)), for: .touchUpInside)
        
        cat!.getDetails()
        {
            res in
//            if(res!)
//            {
                for a in self.list_tile
                {
                    let b = a as! TabTile
                    b.setContent(type: b.type!)
                }
//            }
        }
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
    
    func loadScroll()
    {
        var heightStack : CGFloat = 0
        
        list_tile.append(TabTile(cat: cat!, type: 0))
        list_tile.append(TabTile(cat: cat!, type: 1))
        list_tile.append(TabTile(cat: cat!, type: 2))

        for a in list_tile
        {
            heightStack += (Static.tileSpacing + a.getWidth())
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
    
    func gotoBack(_ sender: AnyObject)
    {
        if(fromC!)
        {
            self.performSegue(withIdentifier: "gotoCfromCD", sender: self)
        }
        else
        {
            self.performSegue(withIdentifier: "gotoDBfromCD", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

