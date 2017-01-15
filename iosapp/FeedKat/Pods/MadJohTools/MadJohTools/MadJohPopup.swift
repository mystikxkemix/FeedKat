//
//  MadJohPopup.swift
//  Versus
//
//  Created by Valentin Barat on 29/12/2016.
//  Copyright © 2016 madjoh. All rights reserved.
//

import Foundation
import UIKit

public class MadJohPopup
{
    // TODO add further params
    public static var textColor: UIColor!
    public static var borderColor: UIColor!
    
    public static var isShowingPopup: Bool = false
    fileprivate static var popupBG : UIView?
    public static func showPopup(view: UIView, text: String, image: String?)
    {
        if (isShowingPopup) { return }
        isShowingPopup = true
        popupBG = UIView(frame: CGRect(x: view.width / 2, y: view.height / 2, width: 0, height: 0))
        popupBG!.backgroundColor = UIColor(white: 0, alpha: 0.5)
        popupBG?.layer.masksToBounds = true
        view.addSubview(popupBG!)
        
        let popupWidth = view.width * 0.75
        let heightOffset = view.height * 0.05
        
        var imgView: UIImageView!
        if (image != nil)
        {
            imgView = UIImageView(image: UIImage.getScaledWithWidth(image!, width: view.width * 0.3))
            imgView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            imgView.isUserInteractionEnabled = false
        }
        
        let textView = UILabel()
        textView.numberOfLines = 0
        textView.text = text
        if (MadJohTools.textFont != nil) { textView.font = MadJohTools.textFont }
        textView.textColor = textColor ?? UIColor.black
        textView.textAlignment = .center
        textView.isUserInteractionEnabled = false
        let textViewWidth = popupWidth * 0.9
        let textSize = textView.sizeThatFits(CGSize(width: textViewWidth, height: CGFloat.greatestFiniteMagnitude))
        textView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        
        let popup = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        popup.backgroundColor = UIColor.white
        popup.layer.cornerRadius = 10
        popup.layer.borderWidth = 2
        popup.layer.borderColor = borderColor?.cgColor ?? UIColor.black.cgColor
        popup.layer.masksToBounds = true
        popup.isUserInteractionEnabled = false
        
        popupBG!.addSubview(popup)
        if (imgView != nil)
        {
            popupBG!.addSubview(imgView!)
        }
        popupBG!.addSubview(textView)
        
        
        let height = textSize.height + (imgView != nil ? imgView.image!.size.height + heightOffset : 0) + 2 * heightOffset
        UIView.animate(withDuration: 0.2)
        {
            popupBG?.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
            popup.frame = CGRect(x: (view.width - popupWidth) / 2, y: (view.height - height) / 2, width: popupWidth, height: height)
            if (imgView != nil)
            {
                imgView.frame = CGRect(x: (view.width - imgView.image!.size.width) / 2, y: popup.y + heightOffset, width: imgView.image!.size.width, height: imgView.image!.size.height)
            }
            let textY = imgView != nil ? imgView.y + imgView.height + heightOffset : (view.height - textSize.height) / 2
            textView.frame = CGRect(x: (view.width - textViewWidth) / 2, y: textY, width: textViewWidth, height: textSize.height)
        }
        
        
        
        popupBG?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidePopup)))
    }
    
    public static func showPopup(view: UIView, popup: UIView)
    {
        if (isShowingPopup) { return }
        isShowingPopup = true
        popupBG = UIView(frame: CGRect(x: view.width / 2, y: view.height / 2, width: 0, height: 0))
        popupBG!.backgroundColor = UIColor(white: 0, alpha: 0.5)
        popupBG?.layer.masksToBounds = true
        view.addSubview(popupBG!)
        
        popupBG!.addSubview(popup)
        popup.translatesAutoresizingMaskIntoConstraints = false
        
        UIView.animate(withDuration: 0.2)
        {
            popupBG?.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
            popupBG!.addConstraint(NSLayoutConstraint(item: popup, attribute: .centerX, relatedBy: .equal, toItem: popupBG, attribute: .centerX, multiplier: 1, constant: 0))
            popupBG!.addConstraint(NSLayoutConstraint(item: popup, attribute: .centerY, relatedBy: .equal, toItem: popupBG, attribute: .centerY, multiplier: 1, constant: 0))
            popupBG!.addConstraint(NSLayoutConstraint(item: popup, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: popup.width))
            popupBG!.addConstraint(NSLayoutConstraint(item: popup, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: popup.height))
        }
        
        popupBG?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidePopup)))
    }
    
    @objc public static func hidePopup()
    {
        if (!isShowingPopup) { return }
        
        let width = popupBG!.width
        let height = popupBG!.height
        
        for v in (popupBG?.subviews)!
        {
            v.removeFromSuperview()
        }
        
        UIView.animate(withDuration: 0.2, animations:
            {
                popupBG?.frame = CGRect(x: width / 2, y: height / 2, width: 0, height: 0)
                for v in (popupBG?.subviews)!
                {
                    v.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                }
        })
        { _ in
            popupBG?.removeFromSuperview()
            popupBG = nil
            isShowingPopup = false
        }
        
    }
}
