//
//  ViewController.swift
//  FeedKat
//
//  Created by Mike OLIVA on 13/09/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit
import MadJohTools

class ConnectionPage: UIViewController {

    //MARK : Properties
    @IBOutlet var account: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var UIcontent: UIView!
    
    @IBAction func tryConnection(_ sender: UIButton)
    {
        Static.startLoading(view: self.view)

//        FeedKatAPI.login("kevin.berenger@gmail.com", password: "toto")
        FeedKatAPI.login(account.text!.lowercased(), password: password.text!)
        {
            response, error in
            if(error == nil && response != nil)
            {
                let id = response!.value(forKey: "id_user") as? String
                if(id != nil)
                {
                    Static.userId = Int(id!)!
                    DataCache.cache(Static.userId, forKey: FeedKatAPI.userIdCacheKey)
                    Static.stopLoading()
                    self.alreadyConnected()
                }
                else
                {
                    let pop = popUp(view: self.UIcontent, text: "Le couple Login/MotDePasse incorrect")
                    pop.ViewFunc()
                }
            }
            else
            {
                Static.stopLoading()
                print("error ConnectionPage : \(error)")
                
                
            }
        }
    }
    
    func alreadyConnected()
    {
        let id = DataCache.getInt(forKey: FeedKatAPI.userIdCacheKey)
        if(id == nil){return}
        
        Static.startLoading(view: self.view)
        Static.userId = id!
        
        FeedKatAPI.getCatbyUserId(Static.userId)
        {
            response, error in
            if(error == nil)
            {
                let ar = response?.value(forKey: "cats") as? [NSDictionary]
                if(ar != nil)
                {
                    for a in ar!
                    {
                        let name = a.value(forKey: "name") as! String
                        let id = a.value(forKey: "id_cat") as! Int
                        let message = a.value(forKey: "status") as! String
                        let status = a.value(forKey: "ok") as! Int
                        let photo = a.value(forKey: "photo") as! String
                        let weight = a.value(forKey: "weight") as! Int
                        let feed = a.value(forKey: "feed_times") as? [NSDictionary]
                        _ = Cat(ID: id, Name: name, Message: message, Photo: photo, Status:status, Weight:weight, FeedTimes: feed)
                    }
                }
                
                FeedKatAPI.getDispById(Static.userId)
                {
                    response, error in
                    if(error == nil)
                    {
                        let ar = response?.value(forKey: "dispensers") as? [NSDictionary]
                        if(ar != nil)
                        {
                            for a in ar!
                            {
                                let name = a.value(forKey: "name") as! String
                                let sid = a.value(forKey: "id_dispenser") as! String
                                let id = Int(sid)!
                                let sstock = a.value(forKey: "stock") as! String
                                let stock = Int(sstock)!
                                
                                _ = Dispenser(ID: id, Name: name, Status: stock)
                            }
                        }
                        Static.stopLoading()
                        self.performSegue(withIdentifier: "gotoDashBoard", sender: self)
                    }
                    else
                    {
                        Static.stopLoading()
                        print("\(error)")
                    }
                }
            }
            else
            {
                Static.stopLoading()
                print("error getCatbyId : \(error)")
            }
        }
    }
    
    @IBAction func gotoRegister(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "gotoRegister", sender: self)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        MadJohTools.textFont = UIFont(name: "Arial Rounded MT Bold", size: 20)
        alreadyConnected()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

