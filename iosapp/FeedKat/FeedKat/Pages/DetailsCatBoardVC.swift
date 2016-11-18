//
//  DetailsCatVC.swift
//  FeedKat
//
//  Created by Mike OLIVA on 04/11/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import UIKit

class DetailsCatBoardVC : UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    var top:UIView!
    var UITitle:UILabel!
    var UiImage:UIImageView!
    var scrollView:UIScrollView!
    var container:UIStackView!
    var list_tile = [Tile]()
    var UIBot = [UIButton]()
    let icon_height = (UIScreen.main.bounds.size.height/10)*0.5
    var catId:Int = -1
    var cat:Cat? = nil
    var fromC:Bool? = nil
    var InfoTab:TabTile?
    var imagePicker = UIImagePickerController()
    var isNewImage = false
    var isNewDate = false
    let timeFormatter = DateFormatter()
    var dateView:UITextField?

    override func viewDidLoad()
    {
        self.cat = Cat.getList()[catId]
        let offsety = Static.tileHeight*0.6 + Static.tileWidth*0.02
        
        super.viewDidLoad()
        
        UiImage = UIImageView(frame : CGRect(x: Static.tileWidth*0.01, y: Static.tileHeight*0.6, width: Static.tileHeight*1.2, height: Static.tileHeight*1.2))
        
        if(self.cat?.image == nil)
        {
            if(self.cat?.getPhoto() != "")
            {
                self.UiImage.image = Static.getScaledImageWithHeight("Icon", height: Static.tileHeight)
                if let checkedUrl = URL(string: (cat?.getPhoto())!)
                {
                    UiImage.contentMode = .scaleAspectFit
                    FeedKatAPI.downloadImage(url: checkedUrl, view: UiImage)
                    {
                        data in
                        self.cat?.image = data
                    }
                }
            }
            else
            {
                UiImage.image = Static.getScaledImageWithHeight("Icon", height: Static.tileHeight)
            }
        }
        else
        {
            self.UiImage.image = self.cat?.image!
        }
        
        UiImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailsCatBoardVC.pickImage)))
        
        timeFormatter.dateStyle = .medium
        timeFormatter.timeStyle = .none
        
        dateView = UITextField(frame : CGRect(x: Static.tileWidth*0.03, y: Static.tileHeight*1.5 + offsety, width: Static.tileWidth*0.4, height: Static.tileHeight*0.2))
        dateView!.delegate = self
        dateView!.textColor = Static.BlueColor
        dateView!.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        dateView!.textAlignment = .center
        dateView!.layer.borderWidth = 1
        dateView!.layer.borderColor = UIColor.black.cgColor
        dateView!.layer.cornerRadius = 10
        dateView!.isHidden = true
        dateView!.addTarget(self, action: #selector(DetailsCatBoardVC.txtFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
//        dateView.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("BIRTHDATE", comment: ""), attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
//        cell.addSubview(dateView)
        
        dateView!.addTarget(self, action: #selector(DetailsCatBoardVC.dateField(_:)), for: .editingDidBegin)
        
        top = UIView()
        top.backgroundColor = Static.BlueColor
        top.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(top)
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.12, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: top, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        
        scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.masksToBounds = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: top, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.88, constant: 0))
        
        loadScroll()
        
        initTop(title: cat!.getName())
        
        let arrow = UIButton(frame: CGRect(x: Int(Static.screenWidth*0.03), y: Int(Static.screenHeight*0.05), width: Int(Static.screenHeight*0.05), height: Int(Static.screenHeight*0.05)))
        arrow.setImage(Static.getScaledImageWithHeight("Arrow_left", height: Static.screenHeight*0.05), for: UIControlState())
        
        top.addSubview(arrow)
        arrow.addTarget(self, action: #selector(self.gotoBack(_:)), for: .touchUpInside)
        
        cat!.getDetails()
        {
            res in
            if(res!)
            {
                for a in self.list_tile
                {
                    let b = a as! TabTile
                    b.setContent(type: b.type!)
                }
            }
        }
    }
    
    func initTop(title:String)
    {
        UITitle = UILabel()
        UITitle.translatesAutoresizingMaskIntoConstraints = false
        UITitle.textColor = UIColor.white
        UITitle.text = title
        UITitle.font = UIFont(name: "Arial Rounded MT Bold", size: 30)!
        UITitle.numberOfLines = 1
        UITitle.sizeToFit()
        
        top.addSubview(UITitle)
        top.addConstraint(NSLayoutConstraint(item: UITitle, attribute: .centerX, relatedBy: .equal, toItem: top, attribute: .centerX, multiplier: 1, constant: 0))
        top.addConstraint(NSLayoutConstraint(item: UITitle, attribute: .centerY, relatedBy: .equal, toItem: top, attribute: .centerY, multiplier: 1, constant: 5))
        
    }
    
    func loadScroll()
    {
        var heightStack : CGFloat = 0
        
        InfoTab = TabTile(cat: cat!, type: 0, parent:self, UiImage: self.UiImage, UiDate: self.dateView)
        list_tile.append(InfoTab!)
        list_tile.append(TabTile(cat: cat!, type: 1, parent:self, UiImage: nil, UiDate: nil))
        list_tile.append(TabTile(cat: cat!, type: 2, parent:self, UiImage: nil, UiDate: nil))

        for a in list_tile
        {
            heightStack += (Static.tileSpacing + a.getWidth())
        }
        heightStack -= Static.tileSpacing
        
        container = UIStackView(frame : CGRect(x: Static.tileMarging, y: Static.tileSpacing/2, width: Static.tileWidth, height: heightStack))
        container.autoresizesSubviews = true
        container.axis = .vertical
        container.spacing = Static.tileSpacing
        container.distribution = .fillProportionally
        
        scrollView.addSubview(container)
        
        var i = 0
        for cell in list_tile
        {
            container.insertArrangedSubview(cell, at: i)
            i+=1
        }
        
        scrollView.contentSize.height = heightStack + Static.tileSpacing
        scrollView.contentSize.width = 1
    }
    
    func gotoBack(_ sender: AnyObject)
    {
        if(fromC!)
        {
            self.performSegue(withIdentifier: "gotoCfromCD", sender: self)
        }
        else
        {
            self.performSegue(withIdentifier: "gotoDBfromCD", sender: self)
        }
    }
    
    func pickImage()
    {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
        imagePicker.allowsEditing = false
//        imagePicker.sourceType = .camera
//        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
        
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
        
        cat?.image = newImg
        InfoTab!.UiImage.image = newImg
        
        isNewImage = true
    }
    
    func dateField(_ sender: UITextView)
    {
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(DetailsCatBoardVC.handleDatePicker(_:)), for: UIControlEvents.valueChanged)
    }
    
    func handleDatePicker(_ sender: UIDatePicker)
    {
        InfoTab!.eDate!.text = timeFormatter.string(from: sender.date)
        self.InfoTab!.date! = sender.date
    }
    
    func txtFieldDidChange(textField: UITextField)
    {
        self.isNewDate = true
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

