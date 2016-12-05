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
        for a in self.bot.subviews
        {
            a.removeFromSuperview()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alertController = UIAlertController (title: "Title", message: "Pour ajouter un distributeur vous devez vous connecter à son WIFI", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Réglages", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Annuler", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

}
