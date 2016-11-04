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
    var fromC:Bool? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.cat = Cat.getList()[catId]
        initTop(title: cat!.getName())
        bot.removeFromSuperview()
        
        let arrow = UIButton(frame: CGRect(x: Int(Static.screenWidth*0.03), y: Int(Static.screenHeight*0.05), width: Int(Static.screenHeight*0.05), height: Int(Static.screenHeight*0.05)))
        arrow.setImage(Static.getScaledImageWithHeight("Arrow_left", height: Static.screenHeight*0.05), for: UIControlState())
        
        top.addSubview(arrow)
        arrow.addTarget(self, action: #selector(self.gotoBack(_:)), for: .touchUpInside)

        
    }
    
    override func loadScroll()
    {
        super.loadScroll()
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

