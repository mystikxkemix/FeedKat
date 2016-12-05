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
        
        timeFormatter.dateStyle = .medium
        timeFormatter.timeStyle = .none
        
        let arrow = UIButton(frame: CGRect(x: Int(Static.screenWidth*0.03), y: Int(Static.screenHeight*0.05), width: Int(Static.screenHeight*0.05), height: Int(Static.screenHeight*0.05)))
        arrow.setImage(Static.getScaledImageWithHeight("Arrow_left", height: Static.screenHeight*0.05), for: UIControlState())
        
        top.addSubview(arrow)
        arrow.addTarget(self, action: #selector(self.gotoBack), for: .touchUpInside)
        
        view.isUserInteractionEnabled = true
        let aSelector : Selector = #selector(self.resignResponder)
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        
        modImage.image = Static.getScaledImageWithWidth("Icon", width: Static.screenWidth*0.4)
        modImage.tintColor = UIColor.gray
        modImage.frame = CGRect(x: Static.screenWidth*0.05, y: Static.screenHeight*0.15, width: Static.screenWidth*0.4, height: Static.screenWidth*0.4)
        modImage.isUserInteractionEnabled = true
        modImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.pickImage)))
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
    
    func pickImage()
    {
        imagePicker.delegate = self
//        imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
//        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
        
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
    
    func gotoBack()
    {
        self.performSegue(withIdentifier: "gotoCBfromAC", sender: self)
    }
}
