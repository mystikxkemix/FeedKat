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
        list_tile.append(AlertTile(title:"Votre distributeur n'a plus de croquette"))
        list_tile.append(DashCatTile(Im: Static.getScaledImageWithHeight("Icon", height: Static.tileHeight), Name: "Prince royal", State: 1, Status: "Votre chat va bien"))
        list_tile.append(DashCatTile(Im: Static.getScaledImageWithHeight("photo_batmane", height: Static.tileHeight), Name: "Batmane", State: 1, Status: "Votre chat a très bien mangé ce week-end"))
        list_tile.append(DashDistTile(Name:"Truc", Fill:25))
        list_tile.append(DashDistTile(Name:"Truc", Fill:100))
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
