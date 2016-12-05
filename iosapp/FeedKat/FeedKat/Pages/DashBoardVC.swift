//
//  DashBoardVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 13/09/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class DashBoardVC: GenVC
{
    var catId:Int = -1
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initTop(title: "Accueil")
        initBanner(i: 0)
        
        UIBot[1].addTarget(self, action: #selector(DashBoardVC.gotoC), for: .touchUpInside)
        UIBot[2].addTarget(self, action: #selector(DashBoardVC.gotoO), for: .touchUpInside)
    }
    
    override func loadScroll()
    {
        
        if(Cat.getList().count != 0)
        {
        
            for a in Cat.getList()
            {
                let catt = DashCatTile(cat:a)
                catt.tag = Cat.getList().index(of: a)!
                catt.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.gotoCD(_:))))
                list_tile.append(catt)
            }
        }
        
        if(Dispenser.getList().count != 0)
        {
            for a in Dispenser.getList()
            {
                list_tile.append(DashDistTile(disp: a))
            }
        }
        
        if(Dispenser.getList().count == 0 && Cat.getList().count == 0)
        {
            list_tile.append(AddCatTile())
        }
        
        super.loadScroll()
    }
    
    func gotoO()
    {
        self.performSegue(withIdentifier: "fromDBtoO", sender: self)
    }
    
    func gotoC()
    {
        self.performSegue(withIdentifier: "fromDBtoC", sender: self)
    }
    
    func gotoCD(_ sender: AnyObject)
    {
        Static.startLoading(view: self.view)
        let view = sender.view as UIView
        self.catId = view.tag
        self.performSegue(withIdentifier: "gotoCDfromDB", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "gotoCDfromDB"
        {
            let dst = segue.destination as! DetailsCatBoardVC
            dst.catId = self.catId
            dst.fromC = false
        }
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
