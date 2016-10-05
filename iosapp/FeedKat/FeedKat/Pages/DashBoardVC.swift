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
        imgbot[0].setImage(Static.getScaledImageWithHeight("Icon_home_pressed", height: icon_height), for: UIControlState())
        imgbot[1].setImage(Static.getScaledImageWithHeight("Icon_cats", height: icon_height), for: UIControlState())
        imgbot[2].setImage(Static.getScaledImageWithHeight("Icon_setting", height: icon_height), for: UIControlState())
        
        imgbot[1].addTarget(self, action: #selector(DashBoard.gotoC), for: .touchUpInside)
        imgbot[2].addTarget(self, action: #selector(DashBoard.gotoO), for: .touchUpInside)
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
