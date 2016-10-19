//
//  RegisterVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 19/10/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class RegisterPage : UIViewController
{
    
    @IBOutlet var mail: UITextField!
    @IBOutlet var pass: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var first_name: UITextField!
    
    @IBAction func tryConnection(_ sender: UIButton)
    {
        FeedKatAPI.register(mail.text!.lowercased(), password: pass.text!.lowercased(), last: name.text!, first: first_name.text!)
        {
            response, error in
            if(error == nil)
            {
                self.performSegue(withIdentifier: "gotoDBfromRegister", sender: self)
            }
            else
            {
//                let pop = popUp(view: self.UIcontent, text: "Le couple Login/MotDePasse incorrecte")
//                //                self.UIcontent.addSubview(pop)
//                pop.ViewFunc()
                print("login error : \(error)")
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
