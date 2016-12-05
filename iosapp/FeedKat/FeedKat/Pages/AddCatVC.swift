//
//  AddCatVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 05/12/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class AddCatVC : GenVC
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initTop(title: "Ajouter un chat")
        self.bot.removeFromSuperview()
        
        let arrow = UIButton(frame: CGRect(x: Int(Static.screenWidth*0.03), y: Int(Static.screenHeight*0.05), width: Int(Static.screenHeight*0.05), height: Int(Static.screenHeight*0.05)))
        arrow.setImage(Static.getScaledImageWithHeight("Arrow_left", height: Static.screenHeight*0.05), for: UIControlState())
        
        top.addSubview(arrow)
        arrow.addTarget(self, action: #selector(self.gotoBack), for: .touchUpInside)
    }
    
    func gotoBack()
    {
        self.performSegue(withIdentifier: "gotoCBfromAC", sender: self)
    }
}
