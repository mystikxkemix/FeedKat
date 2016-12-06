//
//  AddDispVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 05/12/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class AddDispVC : GenVC
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initTop(title: "Ajouter un distributeur")
        UITitle.font = UIFont(name: "Arial Rounded MT Bold", size: 25)!
        for a in self.bot.subviews
        {
            a.removeFromSuperview()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alertController = UIAlertController (title: "Ajout d'un distributeur", message: "Pour ajouter un distributeur vous devez vous connecter à son WIFI", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Réglages", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    //print("Settings opened: \(success)") // Prints true
                    self.gotoBack()
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

}
