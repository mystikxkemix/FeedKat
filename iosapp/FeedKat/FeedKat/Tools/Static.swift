//
//  Static.swift
//  FeedKat
//
//  Created by Mike OLIVA on 19/09/2016.
//  Copyright © 2016 Mike OLIVA. All rights reserved.
//

import Foundation
import UIKit

class Static {
    static let OrangeColor = UIColor(colorLiteralRed: 1, green: 150/255, blue: 0, alpha: 1)
    static let GreenColor = UIColor(colorLiteralRed: 110/255, green: 1, blue: 110/255, alpha: 1)
    static let BlueColor = UIColor(colorLiteralRed: 103/255, green: 164/255, blue: 240/255, alpha: 1)
    static let WhiteGrayColor = UIColor(colorLiteralRed: 235/255, green: 235/255, blue: 235/255, alpha: 1)
    static let RedColor = UIColor(colorLiteralRed: 1, green: 110/255, blue: 110/255, alpha: 1)
    static let YellowColor = UIColor(colorLiteralRed: 245/255, green: 245/255, blue: 80/255, alpha: 1)
    static let TransparentColor = UIColor(colorLiteralRed: 1, green: 150/255, blue: 0, alpha: 0)
    
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let tileHeight = Static.screenHeight*0.15
    static let tileMarging = Static.screenHeight*0.0125
    static let tileWidth = Static.screenWidth - 2*tileMarging
    static let tileSpacing = Static.screenHeight*0.035
    static let iconAlertSize = Static.tileHeight*0.8
    static var userId = -1
    static let nowMinute = Calendar.current.component(.minute, from: Date())
    static let nowHour = Calendar.current.component(.hour, from: Date())
    static let nowDay = Calendar.current.component(.day, from: Date())
    
    public static var isLoading: Bool = false
    public static var isShowingPopup: Bool = false
    fileprivate static var loadingBG : UIView?
    fileprivate static var loadingHandler : (() -> ())?
    fileprivate static var loadingButton : UIButton?
    
    
    static func scaleUIImageToSize(_ image: UIImage, size: CGSize) -> UIImage
    {
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    static func getScaledImageWithWidth(_ image: String, width: CGFloat) -> UIImage
    {
        let img = UIImage(named: image)
        let ratio = width / img!.size.width
        let height = (img?.size.height)! * ratio
        
        return scaleUIImageToSize(img!, size: CGSize(width: width, height: height))
    }
    
    static func getScaledUIImageWithWidth(_ img: UIImage, width: CGFloat) -> UIImage
    {
        let ratio = width / img.size.width
        let height = (img.size.height) * ratio
        
        return scaleUIImageToSize(img, size: CGSize(width: width, height: height))
    }
    
    static func getScaledImageWithHeight(_ image: String, height: CGFloat) -> UIImage
    {
        let img = UIImage(named: image)
        let ratio = height / (img?.size.height)!
        let width = (img?.size.width)! * ratio
        
        return scaleUIImageToSize(img!, size: CGSize(width: width, height: height))
    }
    
    static func getScaledUIImageWithHeight(_ img: UIImage, height: CGFloat) -> UIImage
    {
        let ratio = height / img.size.height
        let width = img.size.width * ratio
        
        return scaleUIImageToSize(img, size: CGSize(width: width, height: height))
    }
    
    static func StringToInt(str : String) -> [Int]
    {
        var res:[Int] = []
        let fullNameArr = str.components(separatedBy: ":")

        for a in fullNameArr
        {
            res.append(Int(a)!)
        }
        
        return res
    }
    
    static func cropImgToCenter(_ image: UIImage, size: CGFloat) -> UIImage
    {
        let width = size
        let height = size
        
        let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
        
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
    static func startLoading(view: UIView)
    {
        isLoading = true
        loadingBG = UIView(frame: CGRect(x: 0, y: 0, width: view.getWidth(), height: view.getHeight()))
        loadingBG!.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.addSubview(loadingBG!)
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        let size = 50 as CGFloat
        activity.frame = CGRect(x: (view.getWidth() - size) / 2, y: (view.getHeight() - size) / 2, width: size, height: size)
        loadingBG!.addSubview(activity)
        activity.startAnimating()
    }
    
    static func stopLoading()
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
    
    static func delay(_ delay: Double, closure:@escaping ()->())
    {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }

}
