//
//  AddDispVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 05/12/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit
import SwiftSocket

class AddDispVC : GenVC
{
    var button:UIButton = UIButton()
    var SSIDField:UITextField = UITextField()
    var PASSField:UITextField = UITextField()
    
    override func viewDidLoad()
    {
        button.frame = CGRect(x: Static.screenWidth*0.6, y: Static.screenHeight*0.75, width: Static.screenWidth*0.35, height: Static.screenHeight*0.1)
        button.setTitle("Suivant", for: .normal)
        button.backgroundColor = Static.BlueColor
        button.isHidden = true
        
        SSIDField.frame = CGRect(x: Static.screenWidth*0.2, y: Static.screenHeight*0.35, width: Static.screenWidth*0.6, height: Static.screenHeight*0.05)
        SSIDField.textColor = Static.BlueColor
        SSIDField.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        SSIDField.textAlignment = NSTextAlignment.left
        SSIDField.text = "SSID"
        SSIDField.isHidden = true
//        SSIDField.placeholder = "SSID"
        SSIDField.autocorrectionType = .no
        SSIDField.textAlignment = .center
        SSIDField.layer.borderWidth = 1
        SSIDField.layer.cornerRadius = 10
        self.view.addSubview(SSIDField)
        
        PASSField.frame = CGRect(x: Static.screenWidth*0.2, y: Static.screenHeight*0.45, width: Static.screenWidth*0.6, height: Static.screenHeight*0.05)
        PASSField.textColor = Static.BlueColor
        PASSField.text = "Clé WIFI"
        PASSField.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        PASSField.textAlignment = NSTextAlignment.left
        PASSField.isHidden = true
//        PASSField.placeholder = "Clé WIFI"
        PASSField.isSecureTextEntry = true
        PASSField.autocorrectionType = .no
        PASSField.textAlignment = .center
        PASSField.layer.borderWidth = 1
        PASSField.layer.cornerRadius = 10
        self.view.addSubview(PASSField)
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        initTop(title: "Ajouter un distributeur")
        UITitle.font = UIFont(name: "Arial Rounded MT Bold", size: 25)!
        bot.removeFromSuperview()
        
        self.view.addSubview(button)
        
        view.isUserInteractionEnabled = true
        let vSelector : Selector = #selector(self.response)
        let vapGesture = UITapGestureRecognizer(target: self, action: vSelector)
        vapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(vapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alertController = UIAlertController (title: "Ajout d'un distributeur", message: "Pour ajouter un distributeur vous devez vous connecter à son WIFI", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Réglages", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                    self.button.isHidden = false
                    self.PASSField.isHidden = false
                    self.SSIDField.isHidden = false
                    self.button.addTarget(self, action: #selector(self.connectAndSendTCP), for: UIControlEvents.touchUpInside)
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Annuler", style: .default) { (_) -> Void in
            self.gotoBack()
        }
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func gotoBack()
    {
        self.performSegue(withIdentifier: "gotoOBfromAD", sender: self)
    }
    
    func connectAndSendTCP()
    {
        if(SSIDField.text != "" && SSIDField.text != "")
        {
        
            Static.startLoading(view: self.view)

            let client = TCPClient(address: "192.168.4.1", port: 86)
            switch client.connect(timeout: 10) {
            case .success:
            let SSID = self.SSIDField.text!
            let mdp = self.PASSField.text!
//                let SSID = "OnePlusX"
//                let mdp = "e2isylvain"
            
                _ = client.send(string: "FeedKat\r\n\(Static.userId)\r\n\(SSID)\r\n\(mdp)")
                let array = client.read(20, timeout: 10) ?? [70, 65, 73, 76]
            
                if let str = NSString(bytes: array, length: 20, encoding: String.Encoding.utf8.rawValue)
                {
                    print("received : {\(str)}")
                    client.close()
                    if(str == "OKOK")
                    {
                        Static.delay(2.0)
                        {
                            FeedKatAPI.getDispById(Static.userId)
                            {
                                response,error in
                                if(error == nil)
                                {
                                    Dispenser.clearList()
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
                                    self.performSegue(withIdentifier: "gotoDBfromAD", sender: self)
                                }
                                else
                                {
                                    Static.stopLoading()
                                    print("\(error)")
                                }

                            }
                        }
                    }
                    else
                    {
                        Static.stopLoading()
                        let pop = popUp(view: self.view, text: "Couple SSID/MotDePasse incorrect")
                        pop.ViewFunc()
                    }
                }
                else
                {
                    print("not a valid UTF-8 sequence")
                    Static.stopLoading()
                }
                break
            case .failure(let error):
                print("Fuck : \(error)")
                Static.stopLoading()
                break
            }
        }
    }
    
    func response()
    {
        SSIDField.resignFirstResponder()
        PASSField.resignFirstResponder()
    }

}
