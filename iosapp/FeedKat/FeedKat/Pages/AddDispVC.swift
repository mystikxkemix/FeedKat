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
    var descriptionText:UILabel = UILabel()
    var serialDisp = ""
    var page = 1
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        initTop(title: "Ajouter un distributeur")
        UITitle.font = UIFont(name: "Arial Rounded MT Bold", size: 25)!
        bot.removeFromSuperview()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        view.removeAllSubviews()
        top = UIView()
        top.backgroundColor = Static.BlueColor
        top.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(top)
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.12, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))

        let arrow = UIButton(frame: CGRect(x: Int(Static.screenWidth*0.03), y: Int(Static.screenHeight*0.05), width: Int(Static.screenHeight*0.05), height: Int(Static.screenHeight*0.05)))
        arrow.setImage(Static.getScaledImageWithHeight("Arrow_left", height: Static.screenHeight*0.05), for: UIControlState())
        
        top.addSubview(arrow)
        arrow.addTarget(self, action: #selector(self.gotoBack), for: .touchUpInside)
        
        initTop(title: "Ajouter un distributeur")
        switch page {
        case 1:
            page1()
        default:
            page2()
        }
    }
    
    func gotoBack()
    {
        self.performSegue(withIdentifier: "gotoOBfromAD", sender: self)
    }
    
    func page1()
    {
        descriptionText.frame = CGRect(x: Static.screenWidth*0.1, y: Static.screenHeight*0.2, width: Static.screenWidth*0.8, height: Static.screenHeight*0.1)
        descriptionText.text =  "2) Rentrer le nom de votre Box (SSID)\n3) Rentrer votre clé WIFI"
        descriptionText.textColor = UIColor.black
        descriptionText.numberOfLines = 6
        descriptionText.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        descriptionText.isHidden = true
        self.view.addSubview(descriptionText)
        
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
        
        self.view.addSubview(button)
        
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
                    self.descriptionText.isHidden = false
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
                    if(str == "NOKNOK")
                    {
                        Static.stopLoading()
                        let pop = popUp(view: self.view, text: "Couple SSID/MotDePasse incorrect")
                        pop.ViewFunc()
                    }
                    else
                    {
                        serialDisp = str as String
                        page = 2
                        viewDidAppear(false)
                    }
                }
                else
                {
                    print("not a valid UTF-8 sequence")
                    Static.stopLoading()
                }
                break
            case .failure(let error):
                Static.stopLoading()
                
                page = 2
                viewDidAppear(true)
                
                print("Fuck : \(error)")
                break
            }
        }
    }
    
    func responsePage1()
    {
        SSIDField.resignFirstResponder()
        PASSField.resignFirstResponder()
    }
    
    //------ PAGE 2
    func page2()
    {
        descriptionText.frame = CGRect(x: Static.screenWidth*0.05, y: Static.screenHeight*0.2, width: Static.screenWidth*0.9, height: Static.screenHeight*0.1)
        descriptionText.text = "4) Rentrer un nom pour votre distributeur"
        descriptionText.textColor = UIColor.black
        descriptionText.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        descriptionText.isHidden = false
        self.view.addSubview(descriptionText)
        
        button.frame = CGRect(x: Static.screenWidth*0.6, y: Static.screenHeight*0.75, width: Static.screenWidth*0.35, height: Static.screenHeight*0.1)
        button.setTitle("Suivant", for: .normal)
        button.backgroundColor = Static.BlueColor
        button.isHidden = false
        self.view.addSubview(button)
        
        SSIDField.frame = CGRect(x: Static.screenWidth*0.2, y: Static.screenHeight*0.35, width: Static.screenWidth*0.6, height: Static.screenHeight*0.05)
        SSIDField.textColor = Static.BlueColor
        SSIDField.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        SSIDField.textAlignment = NSTextAlignment.left
        SSIDField.isHidden = false
        SSIDField.text = ""
        SSIDField.placeholder = "Mon Distributeur"
        SSIDField.autocorrectionType = .no
        SSIDField.textAlignment = .center
        SSIDField.layer.borderWidth = 1
        SSIDField.layer.cornerRadius = 10
        self.view.addSubview(SSIDField)
        
        self.button.addTarget(self, action: #selector(self.saveDisp), for: UIControlEvents.touchUpInside)

    }
    
    func saveDisp()
    {
        FeedKatAPI.putDisp(Static.userId, serialDisp: serialDisp, nameDisp: SSIDField.text == "" ? "Mon Distributeur" : SSIDField.text)
        {
            response, error in
            if(error == nil)
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
            else
            {
                Static.stopLoading()
                print("\(error)")
            }
        }

    }

}
