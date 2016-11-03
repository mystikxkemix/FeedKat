//
//  DashBoardVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 13/09/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class DashBoard: GenVC
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initTop(title: "Accueil")
        initBanner(i: 0)
        
        UIBot[1].addTarget(self, action: #selector(DashBoard.gotoC), for: .touchUpInside)
        UIBot[2].addTarget(self, action: #selector(DashBoard.gotoO), for: .touchUpInside)
    }
    
    override func loadScroll()
    {
        
        if(Cat.getList().count != 0)
        {
        
            for cat in Cat.getList()
            {
                list_tile.append(DashCatTile(cat: cat))
            }
        }
        
        if(Dispenser.getList().count != 0)
        {
            for a in Dispenser.getList()
            {
                list_tile.append(DashDistTile(disp: a))
            }
        }
        
        if(Dispenser.getList().count != 0 && Cat.getList().count != 0)
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
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
