//
//  ViewController.swift
//  FeedKat
//
//  Created by Mike OLIVA on 13/09/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class ConnectionPage: UIViewController {

    //MARK : Properties
    @IBOutlet var account: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var UIcontent: UIView!
    
    @IBAction func tryConnection(_ sender: UIButton)
    {
//        if(account.text == "ADMIN" && password.text == "pwd")
//        {
            self.performSegue(withIdentifier: "gotoDashBoard", sender: self)
//        }
//        else
//        {
//            let pop = popUp(view:self.view, text:"User or Password invalid")
//            pop.ViewFunc()
//            UIcontent.insertSubview(pop, at: 6)
//        }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

