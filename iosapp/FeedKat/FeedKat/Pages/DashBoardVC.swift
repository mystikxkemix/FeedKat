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
                
        imgbot[1].addTarget(self, action: #selector(DashBoard.gotoC), for: .touchUpInside)
        imgbot[2].addTarget(self, action: #selector(DashBoard.gotoO), for: .touchUpInside)
    }
    
    override func loadScroll()
    {
        list_tile.append(AlertTile(title:"Votre distributeur n'a plus de croquette"))
        list_tile.append(Tile())
        list_tile.append(Tile())
        //        list_tile.append(Tile(title:""))
        //        list_tile.append(Tile(title:""))
        //        list_tile.append(Tile(title:""))
        
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
