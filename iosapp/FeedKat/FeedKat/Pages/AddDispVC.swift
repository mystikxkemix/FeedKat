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
    
    override func viewDidLoad()
    {
        button.frame = CGRect(x: Static.screenWidth*0.6, y: Static.screenHeight*0.75, width: Static.screenWidth*0.35, height: Static.screenHeight*0.1)
        button.setTitle("Suivant", for: .normal)
        button.backgroundColor = Static.BlueColor
        button.isHidden = true

        super.viewDidLoad()
        initTop(title: "Ajouter un distributeur")
        UITitle.font = UIFont(name: "Arial Rounded MT Bold", size: 25)!
        bot.removeFromSuperview()
        
        self.view.addSubview(button)
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
        let client = TCPClient(address: "192.168.4.1", port: 86)
        switch client.connect(timeout: 10) {
        case .success:
            Static.startLoading(view: self.view)
            _ = client.send(string: "coucou toi")
            let array = client.read(23, timeout: 10) ?? [70, 65, 73, 76]
            
            if let str = NSString(bytes: array, length: 23, encoding: String.Encoding.utf8.rawValue) {
                print(str)
                client.close()
                Static.stopLoading()
            } else {
                print("not a valid UTF-8 sequence")
            }
            break
        case .failure(let error):
            print("Fuck : \(error)")
            break
        }
    }

}
