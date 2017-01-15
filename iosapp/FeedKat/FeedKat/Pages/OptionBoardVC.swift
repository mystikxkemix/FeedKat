//
//  OptionBoardVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 05/10/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class OptionBoardVC : GenVC
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initTop(title: "Options")
        initBanner(i: 2)
        
        UIBot[0].addTarget(self, action: #selector(OptionBoardVC.gotoDB), for: .touchUpInside)
        UIBot[1].addTarget(self, action: #selector(OptionBoardVC.gotoC), for: .touchUpInside)
        
    }
    
    override func loadScroll()
    {
        let AddDisp = Tile(title: "Ajouter un distributeur")
        let Logout = Tile(title: "Deconnexion")
        list_tile.append(AddDisp)
        list_tile.append(Logout)
        
        AddDisp.isUserInteractionEnabled = true
        let aSelector : Selector = #selector(self.gotoAD)
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        AddDisp.addGestureRecognizer(tapGesture)
        
        Logout.isUserInteractionEnabled = true
        let lSelector : Selector = #selector(self.gotoCP)
        let lapGesture = UITapGestureRecognizer(target: self, action: lSelector)
        lapGesture.numberOfTapsRequired = 1
        
        Logout.addGestureRecognizer(lapGesture)
        
        super.loadScroll()
    }
    
    func gotoAD()
    {
        self.performSegue(withIdentifier: "gotoADfromOB", sender: self)
    }
    
    func gotoCP()
    {
        Static.userId = -1
        DataCache.removeCache(forKey: FeedKatAPI.userIdCacheKey)
        Cat.list = [Cat]()
        Dispenser.list = [Dispenser]()
        self.performSegue(withIdentifier: "gotoCPfromOB", sender: self)
    }
    
    func gotoDB()
    {
        self.performSegue(withIdentifier: "fromOtoDB", sender: self)
    }
    
    func gotoC()
    {
        self.performSegue(withIdentifier: "fromOtoC", sender: self)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
