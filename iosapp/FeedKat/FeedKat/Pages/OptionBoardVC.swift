//
//  OptionBoardVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 05/10/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class OptionBoard : GenVC
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initTop(title: "Options")
        initBanner(i: 2)
        
        imgbot[0].addTarget(self, action: #selector(OptionBoard.gotoDB), for: .touchUpInside)
        imgbot[1].addTarget(self, action: #selector(OptionBoard.gotoC), for: .touchUpInside)
    }
    
    override func loadTiles()
    {
        list_tile.append(Tile(title:""))
        list_tile.append(Tile(title:""))
        list_tile.append(Tile(title:""))
        list_tile.append(Tile(title:""))
        list_tile.append(Tile(title:""))
        list_tile.append(Tile(title:""))
        //        list_tile.append(Tile(title:""))
        //        list_tile.append(Tile(title:""))
        //        list_tile.append(Tile(title:""))
        
        super.loadTiles()
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
