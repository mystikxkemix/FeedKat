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
        super.loadScroll()
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
