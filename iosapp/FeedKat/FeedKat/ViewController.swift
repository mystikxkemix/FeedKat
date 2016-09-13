//
//  ViewController.swift
//  FeedKat
//
//  Created by Mike OLIVA on 13/09/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK : Properties
    @IBOutlet var texttitle: UILabel!
    @IBOutlet var edittextfield: UITextField!
    @IBOutlet var savebutton: UIButton!
    @IBOutlet var nametext: UILabel!

    @IBAction func onsaveclick(sender: UIButton) {
        nametext.text = "Name : \(edittextfield.text!)"
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

