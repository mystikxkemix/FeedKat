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
    static var OrangeColor = UIColor(colorLiteralRed: 1, green: 150/255, blue: 0, alpha: 1)
    static var GreenColor = UIColor(colorLiteralRed: 110/255, green: 1, blue: 110/255, alpha: 1)
    static var BlueColor = UIColor(colorLiteralRed: 103/255, green: 164/255, blue: 240/255, alpha: 1)
    static var WhiteGrayColor = UIColor(colorLiteralRed: 235/255, green: 235/255, blue: 235/255, alpha: 1)
    static var RedColor = UIColor(colorLiteralRed: 1, green: 110/255, blue: 110/255, alpha: 1)
    static var YellowColor = UIColor(colorLiteralRed: 245/255, green: 245/255, blue: 80/255, alpha: 1)
    
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
}
