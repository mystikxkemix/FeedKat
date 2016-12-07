//
//  AddCatVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 05/12/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class AddCatVC : GenVC, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    var modName: UITextField = UITextField()
    var modBirthday:UITextField = UITextField()
    var modImage:UIImageView = UIImageView()
    var modCollar:UITextField = UITextField()
    var isNewDate = false;
    var isNewImage = false;
    let timeFormatter = DateFormatter()
    var imagePicker = UIImagePickerController()
    var date:Date = Date()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initTop(title: "Ajouter un chat")
        for a in self.bot.subviews
        {
            a.removeFromSuperview()
        }
        
        let botv = UILabel()
        botv.textColor = UIColor.white
        botv.text = "Enregistrer le chat"
        botv.font = UIFont(name: "Arial Rounded MT Bold", size: 20)!
        botv.numberOfLines = 1
        botv.translatesAutoresizingMaskIntoConstraints = false
        bot.addSubview(botv)
        botv.sizeToFit()
        bot.addConstraint(NSLayoutConstraint(item: botv, attribute: .centerX, relatedBy: .equal, toItem: bot, attribute: .centerX, multiplier: 1, constant: 0))
        bot.addConstraint(NSLayoutConstraint(item: botv, attribute: .centerY, relatedBy: .equal, toItem: bot, attribute: .centerY, multiplier: 1, constant: 0))
        
        botv.isUserInteractionEnabled = true
        let aSelector : Selector = #selector(self.saveCat)
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        botv.addGestureRecognizer(tapGesture)

        
        timeFormatter.dateStyle = .medium
        timeFormatter.timeStyle = .none
        
        let arrow = UIButton(frame: CGRect(x: Int(Static.screenWidth*0.03), y: Int(Static.screenHeight*0.05), width: Int(Static.screenHeight*0.05), height: Int(Static.screenHeight*0.05)))
        arrow.setImage(Static.getScaledImageWithHeight("Arrow_left", height: Static.screenHeight*0.05), for: UIControlState())
        
        top.addSubview(arrow)
        arrow.addTarget(self, action: #selector(self.gotoBack), for: .touchUpInside)
        
        view.isUserInteractionEnabled = true
        let vSelector : Selector = #selector(self.resignResponder)
        let vapGesture = UITapGestureRecognizer(target: self, action: vSelector)
        vapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(vapGesture)
        
        
        modImage.image = Static.getScaledImageWithWidth("Icon", width: Static.screenWidth*0.4)
        modImage.tintColor = UIColor.gray
        modImage.frame = CGRect(x: Static.screenWidth*0.05, y: Static.screenHeight*0.15, width: Static.screenWidth*0.4, height: Static.screenWidth*0.4)
        modImage.isUserInteractionEnabled = true
        modImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openAlert)))
        view.addSubview(modImage)
        
        modName.frame = CGRect(x: Static.screenWidth*0.05, y: Static.screenHeight*0.16 + Static.screenWidth*0.4, width: Static.screenWidth*0.5, height: Static.tileHeight*0.3)
        modName.text = "Nom"
        modName.textColor = Static.BlueColor
        modName.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        modName.autocorrectionType = .no
        modName.textAlignment = .center
        modName.layer.borderWidth = 1
        modName.layer.cornerRadius = 10
        view.addSubview(modName)
        
        modBirthday.frame = CGRect(x: Static.screenWidth*0.05, y: Static.screenHeight*0.25 + Static.screenWidth*0.4, width: Static.screenWidth*0.5, height: Static.tileHeight*0.3)
        modBirthday.text = "Anniversaire"
        modBirthday.delegate = self
        modBirthday.textColor = Static.BlueColor
        modBirthday.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        modBirthday.textAlignment = .center
        modBirthday.layer.borderWidth = 1
        modBirthday.layer.borderColor = UIColor.black.cgColor
        modBirthday.layer.cornerRadius = 10
        modBirthday.addTarget(self, action: #selector(self.txtFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        modBirthday.addTarget(self, action: #selector(self.dateField(_:)), for: .editingDidBegin)
        view.addSubview(modBirthday)
        
    }
    
    func openAlert()
    {
        let alertController = UIAlertController (title: "Charger une photo", message: "", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Appareil photo", style: .default) { (_) -> Void in
            self.pickImage(false)
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Librairie", style: .default) { (_) -> Void in
            self.pickImage(true)
        }
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func pickImage(_ type:Bool)
    {
        imagePicker.delegate = self
        
        if(type)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
            imagePicker.allowsEditing = false
        }
        else
        {
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
        }
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!)
    {
        
        self.dismiss(animated: true, completion: nil)
        
        var newImg = UIImage()
        
        if (image.size.width > image.size.height)
        {
            newImg = Static.getScaledUIImageWithHeight(image, height: Static.tileHeight*1.2)
        }
        else
        {
            newImg = Static.getScaledUIImageWithWidth(image, width: Static.tileHeight*1.2)
        }
        
        newImg = Static.cropImgToCenter(newImg, size: Static.tileHeight*1.2)
        
        modImage.image = newImg
        modImage.tintColor = Static.TransparentColor
        
        isNewImage = true
    }
    
    func dateField(_ sender: UITextView)
    {
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.handleDatePicker(_:)), for: UIControlEvents.valueChanged)
    }
    
    func handleDatePicker(_ sender: UIDatePicker)
    {
        modBirthday.text = timeFormatter.string(from: sender.date)
        self.date = sender.date
    }
    
    func txtFieldDidChange(textField: UITextField)
    {
        self.isNewDate = true
    }
    
    func resignResponder()
    {
        modBirthday.resignFirstResponder()
        modName.resignFirstResponder()
    }
    
    func saveCat()
    {
        if(modName.text! != "Nom" && modBirthday.text! != "Anniversaire")
        {
            Static.startLoading(view: self.view)
            
            FeedKatAPI.addCat(id_user: Static.userId,name: modName.text!, Birthdate: self.date, image: self.isNewImage ? self.modImage.image! : nil)
            {
                response, error in
                
                if(error == nil)
                {
                    let sId = response!.value(forKey: "id_cat") as! String
                    let Id = Int(sId)!
                    
                    _ = Cat(ID: Id, Name: self.modName.text!, Message: "", Photo: self.modImage.image!.base64(format: .PNG), Status: 10, Weight: 0, FeedTimes: nil)
                    
                    Static.stopLoading()
                    self.gotoBack()
                }
            }
        }
    }
    
    func gotoBack()
    {
        self.performSegue(withIdentifier: "gotoCBfromAC", sender: self)
    }
}
