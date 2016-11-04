//
//  CatBoardVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 05/10/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class CatBoardVC : GenVC
{
    var catId:Int = -1
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initTop(title: "Chats")
        initBanner(i: 1)
        
        UIBot[0].addTarget(self, action: #selector(CatBoardVC.gotoDB), for: .touchUpInside)
        UIBot[2].addTarget(self, action: #selector(CatBoardVC.gotoO), for: .touchUpInside)
        
    }
    
    override func loadScroll()
    {
        if(Cat.getList().count != 0)
        {
            
            for a in Cat.getList()
            {
                let catt = CatCatTile(cat:a)
                catt.tag = Cat.getList().index(of: a)!
                catt.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.gotoCD(_:))))
                list_tile.append(catt)
            }
        }
        list_tile.append(AddCatTile())
        super.loadScroll()
    }
    
    func gotoDB()
    {
        self.performSegue(withIdentifier: "fromCtoDB", sender: self)
    }
    
    func gotoO()
    {
        self.performSegue(withIdentifier: "fromCtoO", sender: self)
    }
    
    func gotoCD(_ sender: AnyObject)
    {
        let view = sender.view as UIView
        self.catId = view.tag
        self.performSegue(withIdentifier: "gotoCDfromC", sender: self)
        
    }
    
    // Prepare data to be sent when a segue is performed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "gotoCDfromC"
        {
            let dst = segue.destination as! GenVC as! DetailsCatBoardVC
            dst.catId = self.catId
            dst.fromC = true
        }
        
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
