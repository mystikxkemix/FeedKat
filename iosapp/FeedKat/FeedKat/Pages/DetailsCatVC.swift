//
//  DetailsCatVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 04/11/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class DetailsCatBoardVC : GenVC
{
    var catId:Int = -1
    var cat:Cat? = nil
    var fromC:Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.cat = Cat.getList()[catId]
        initTop(title: cat!.getName())
        bot.removeFromSuperview()
        
        let arrow = UIImageView(frame: CGRect(x: Int(Static.screenWidth*0.01), y: Int(Static.screenHeight*0.03), width: Int(Static.screenHeight*0.06), height: Int(Static.screenHeight*0.06)))
        arrow.image = Static.getScaledImageWithHeight("Arrow_left", height: Static.screenHeight*0.06)
        arrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.gotoBack(_:))))
        
        top.addSubview(arrow)
        
        
    }
    
    override func loadScroll()
    {
        super.loadScroll()
    }
    
    func gotoBack(_ sender: AnyObject)
    {
        if(fromC)
        {
            self.performSegue(withIdentifier: "fromCDtoC", sender: self)
        }
        else
        {
            self.performSegue(withIdentifier: "fromCDtoDB", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

