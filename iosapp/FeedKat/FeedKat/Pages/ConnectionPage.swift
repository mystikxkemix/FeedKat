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
        FeedKatAPI.login(account.text!.lowercased(), password: password.text!)
        {
            response, error in
            if(error == nil)
            {
                self.performSegue(withIdentifier: "gotoDashBoard", sender: self)
            }
            else
            {
//                let pop = popUp(view: self.UIcontent, text: "Le couple Login/MotDePasse incorrecte")
//                pop.ViewFunc()
//                self.UIcontent.addSubview(pop)
                print("login error")
            }
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

