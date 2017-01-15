//
//  MadJohLoading.swift
//  Versus
//
//  Created by Valentin Barat on 29/12/2016.
//  Copyright © 2016 madjoh. All rights reserved.
//

import Foundation
import UIKit

public class MadJohLoading
{
    // TODO add further params
    public static var buttonBorderColor: UIColor!
    public static var buttonBackgroundColor: UIColor!
    public static var buttonTextColor: UIColor!
    
    public static var isLoading: Bool = false
    fileprivate static var loadingBG : UIView?
    fileprivate static var loadingHandler : (() -> ())?
    fileprivate static var loadingButton : UIButton?
    public static func startLoading(view: UIView)
    {
        isLoading = true
        loadingBG = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height))
        loadingBG!.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.addSubview(loadingBG!)
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        let size = 50 as CGFloat
        activity.frame = CGRect(x: (view.width - size) / 2, y: (view.height - size) / 2, width: size, height: size)
        loadingBG!.addSubview(activity)
        activity.startAnimating()
    }
    
    public static func startLoading(view: UIView, buttonText: String, handler: @escaping () -> ())
    {
        isLoading = true
        loadingBG = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height))
        loadingBG!.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.addSubview(loadingBG!)
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        let size = 50 as CGFloat
        activity.frame = CGRect(x: (view.width - size) / 2, y: (view.height - size) / 2, width: size, height: size)
        loadingBG!.addSubview(activity)
        activity.startAnimating()
        
        loadingHandler = handler
        
        let buttonHeight = view.height * 0.1
        let buttonWidth = view.width * 0.5
        loadingButton = UIButton(frame: CGRect(x: (view.width - buttonWidth) / 2, y: (view.height - buttonHeight) / 2 + activity.height * 1.5, width: buttonWidth, height: buttonHeight))
        loadingButton!.setTitle(buttonText, for: .normal)
        loadingButton!.setTitleColor(buttonTextColor ?? UIColor.black, for: .normal)
        loadingButton!.layer.cornerRadius = 10
        loadingButton!.backgroundColor = buttonBackgroundColor ?? UIColor.white
        loadingButton!.layer.borderColor = buttonBorderColor?.cgColor ?? UIColor.black.cgColor
        loadingButton!.layer.borderWidth = 2
        loadingButton!.isUserInteractionEnabled = true
        loadingButton!.addTarget(MadJohLoading.self, action: #selector(handle), for: .touchUpInside)
        view.addSubview(loadingButton!)
    }
    
    @objc fileprivate static func handle() { loadingHandler?() }
    
    public static func stopLoading()
    {
        if (loadingBG == nil || !isLoading) { return }
        isLoading = false
        for v in (loadingBG?.subviews)!
        {
            v.removeFromSuperview()
        }
        loadingBG?.removeFromSuperview()
        loadingBG = nil
        loadingButton?.removeFromSuperview()
        loadingButton = nil
        loadingHandler = nil
    }
}
