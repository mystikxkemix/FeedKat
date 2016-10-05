//
//  CatBoardVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 05/10/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class CatBoard : GenVC
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initTop(title: "Chats")
        initBanner(i: 1)
        
        imgbot[0].addTarget(self, action: #selector(CatBoard.gotoDB), for: .touchUpInside)
        imgbot[2].addTarget(self, action: #selector(CatBoard.gotoO), for: .touchUpInside)
    }
    
    func gotoDB()
    {
        self.performSegue(withIdentifier: "fromCtoDB", sender: self)
    }
    
    func gotoO()
    {
        self.performSegue(withIdentifier: "fromCtoO", sender: self)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
