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
    
    @IBAction func tryConnection(sender: UIButton)
    {
        if(account.text == "ADMIN" && password.text == "pwd")
        {
            self.performSegueWithIdentifier("gotoDashBoard", sender: self)
        }
        else
        {
            let pop = popUp(view:self.view, text:"Test")
            pop.ViewFunc()
            UIcontent.insertSubview(pop, atIndex: 6)
            print("Fini")
        }
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

