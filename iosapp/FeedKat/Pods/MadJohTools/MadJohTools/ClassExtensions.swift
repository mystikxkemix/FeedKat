//
//  classExtensions.swift
//  Versus
//
//  Created by Valentin Barat on 23/01/2016.
//  Copyright © 2016 madjoh. All rights reserved.
//

import UIKit


// Adding a overload constructor to be able to use RGBA format
// Param hexString: "#RRGGBBAA" in hexadecimal
// Return: corresponding UIColor
public extension UIColor
{
    public convenience init?(hexString: String)
    {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#")
        {
            let start = hexString.characters.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber)
                {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}

public extension Double {
    /// Rounds the double to decimal places value
    public func roundToPlaces(_ places : Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    public func format(_ f: Int) -> String {
        return String(format: "%.\(f)f", self)
    }
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: Double
    {
        get
        {
            return Double(arc4random()) / 0xFFFFFFFF
        }
    }
    /**
    Create a random number Double
    
    - parameter min: Double
    - parameter max: Double
         
    - returns: Double
    */
    public static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
    
    public var degreesToRadians : CGFloat
    {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
}

public extension Int
{
    public var degreesToRadians : CGFloat
    {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
    
    public static var random : Int
    {
        get
        {
            return Int(arc4random_uniform(99999999))
        }
    }
}

public extension CGPoint
{
    public func normalize() -> CGPoint
    {
        let length = sqrt(self.x * self.x + self.y * self.y)
        return CGPoint(x: self.x / length, y: self.y / length)
    }
}

// Extensions to all UIView's children
public extension UIView
{
    public func removeAllSubviews()
    {
        for v in subviews
        {
            v.removeFromSuperview()
        }
    }
    
    public func disableAllSubviewsUsersInteraction()
    {
        for v in self.subviews
        {
            v.isUserInteractionEnabled = false
        }
    }
    
    public func rotateBy(radiant: CGFloat)
    {
        self.transform = self.transform.rotated(by: -radiant)
    }
    
    public func rotateBy(degrees: Int)
    {
        rotateBy(radiant: degrees.degreesToRadians)
    }
    
    // Round the given corner of the view
    // Usage: view.roundCorners([.TopLeft, .TopRight], radius: 20)
    public func roundCorners(_ corners:UIRectCorner, radius: CGFloat)
    {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    /**
     Get Set x Position
     
     - parameter x: CGFloat
     by DaRk-_-D0G
     */
    public var x:CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    /**
     Get Set y Position
     
     - parameter y: CGFloat
     by DaRk-_-D0G
     */
    public var y:CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    /**
     Get Set Height
     
     - parameter height: CGFloat
     by DaRk-_-D0G
     */
    public var height:CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    /**
     Get Set Width
     
     - parameter width: CGFloat
     by DaRk-_-D0G
     */
    public var width:CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    public func clone() -> AnyObject
    {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self))! as AnyObject
    }
}

public extension UILabel
{
    public func addLogoToText(logo: UIImage)
    {
        let attachment = NSTextAttachment()
        attachment.image = logo
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: self.text!)
        self.text = nil
        myString.append(attachmentString)
        self.attributedText = myString
    }
    
    public func adjustFont(_ maxFont: UIFont, maxWidth: CGFloat, fontName: String? = nil)
    {
        adjustFont(maxTextSize: maxFont.pointSize, maxWidth: maxWidth, fontName: fontName)
    }
    
    public func adjustFont(_ maxFont: UIFont, maxHeight: CGFloat, fontName: String? = nil)
    {
        adjustFont(maxTextSize: maxFont.pointSize, maxHeight: maxHeight, fontName: fontName)
    }
    
    public func adjustFont(_ maxFont: UIFont, maxWidth: CGFloat, maxHeight: CGFloat, fontName: String? = nil)
    {
        adjustFont(maxTextSize: maxFont.pointSize, maxWidth: maxWidth, maxHeight: maxHeight, fontName: fontName)
    }
    
    public func adjustFont(maxTextSize: CGFloat, maxWidth: CGFloat, fontName: String? = nil)
    {
        var size = CGFloat(maxTextSize)
        var font = fontName == nil ? UIFont(name: MadJohTools.textFont.fontName, size: size) : (UIFont(name: fontName!, size: size) ?? UIFont.systemFont(ofSize: size))
        
        self.font = font
        self.sizeToFit()
        
        while (self.width > maxWidth && size > 1) {
            size -= 1
            font = fontName == nil ? UIFont(name: MadJohTools.textFont.fontName, size: size) : (UIFont(name: fontName!, size: size) ?? UIFont.systemFont(ofSize: size))
            self.font = font
            self.sizeToFit()
        }
    }
    
    public func adjustFont(maxTextSize: CGFloat, maxHeight: CGFloat, fontName: String? = nil)
    {
        var size = CGFloat(maxTextSize)
        var font = fontName == nil ? UIFont(name: MadJohTools.textFont.fontName, size: size) : (UIFont(name: fontName!, size: size) ?? UIFont.systemFont(ofSize: size))
        
        self.font = font
        self.sizeToFit()
        
        while (self.height > maxHeight && size > 1) {
            size -= 1
            font = fontName == nil ? UIFont(name: MadJohTools.textFont.fontName, size: size) : (UIFont(name: fontName!, size: size) ?? UIFont.systemFont(ofSize: size))
            self.font = font
            self.sizeToFit()
        }
    }
    
    public func adjustFont(maxTextSize: CGFloat, maxWidth: CGFloat, maxHeight: CGFloat, fontName: String? = nil)
    {
        self.adjustFont(maxTextSize: maxTextSize, maxWidth: maxWidth, fontName: fontName)
        let size = self.font.pointSize
        self.adjustFont(maxTextSize: maxTextSize, maxWidth: maxHeight, fontName: fontName)
        let size2 = self.font.pointSize
        
        self.font = fontName == nil ? UIFont(name: MadJohTools.textFont.fontName, size: min(size, size2)) : (UIFont(name: fontName!, size: min(size, size2)) ?? UIFont.systemFont(ofSize: min(size, size2)))
    }
}

public extension UIImage {
    
    public var width:CGFloat {
        get {
            return self.size.width
        }
    }
    
    public var height:CGFloat {
        get {
            return self.size.height
        }
    }
    
    public func getGrayScale() -> UIImage
    {  
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")
        currentFilter!.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        var processedImage = UIImage(cgImage: cgimg!)
        processedImage = processedImage.getScaledWithWidth(width: self.width)
        return processedImage
    }
    
    // returns a copy of 'image' thats fit in 'size'
    public func scaleToSize(size: CGSize) -> UIImage
    {
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage == nil ? self : scaledImage!
    }
    
    public static func getScaledWithWidth(_ image: String, width: CGFloat) -> UIImage
    {
        let img = UIImage(named: image)
        return img!.getScaledWithWidth(width: width)
    }
    
    public func getScaledWithWidth(width: CGFloat) -> UIImage
    {
        let ratio = width / self.size.width
        let height = (self.size.height) * ratio
        
        return self.scaleToSize(size: CGSize(width: width, height: height))
    }
    
    public static func getScaledWithHeight(_ image: String, height: CGFloat) -> UIImage
    {
        let img = UIImage(named: image)
        return img!.getScaledWithHeight(height: height)
    }
    
    public func getScaledWithHeight(height: CGFloat) -> UIImage
    {
        let ratio = height / self.size.height
        let width = self.size.width * ratio
        
        return self.scaleToSize(size: CGSize(width: width, height: height))
    }
    
    public func getCroppedImageWithSize(size: CGFloat) -> UIImage
    {
        var imgScaled = self
        if (imgScaled.size.height > imgScaled.size.width)
        {
            imgScaled = imgScaled.getScaledWithWidth(width: size)
        }
        else
        {
            imgScaled = imgScaled.getScaledWithHeight(height: size)
        }
        imgScaled = imgScaled.cropImgToCenter(size: size)
        return imgScaled
    }
    
    public func cropImgToCenter(size: CGFloat) -> UIImage
    {
        let width = size
        let height = size
        
        let contextImage: UIImage = UIImage(cgImage: self.cgImage!)
        
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
        let image: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        return image
    }
}

public extension UIButton {
    private static let boucneDuration = 0.1
    private static let bounceScale : CGFloat = 0.9
    
    public func registerForBounce()
    {
        self.adjustsImageWhenHighlighted = false
        self.addTarget(UIButton.self, action: #selector(UIButton.grow(_:)), for: .touchDragExit)
        self.addTarget(UIButton.self, action: #selector(UIButton.grow(_:)), for: .touchDragOutside)
        self.addTarget(UIButton.self, action: #selector(UIButton.shrink(_:)), for: .touchDragEnter)
        self.addTarget(UIButton.self, action: #selector(UIButton.shrink(_:)), for: .touchDown)
    }
    
    public func waitForBounce(handler: (() -> ())? = nil)
    {
        self.isUserInteractionEnabled = false
        MadJohTools.delay(UIButton.boucneDuration)
        {
            UIButton.grow(self)
            
            MadJohTools.delay(UIButton.boucneDuration)
            {
                self.isUserInteractionEnabled = true
                
                handler?()
            }
        }
    }
    
    @objc static public func grow(_ view: UIButton) {
        UIView.animate(withDuration: boucneDuration, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations:{
            view.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    @objc static public func shrink(_ view: UIButton)
    {
        UIView.animate(withDuration: boucneDuration, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations:{
            view.transform = CGAffineTransform(scaleX: bounceScale, y: bounceScale)
        }, completion: nil)
    }
}
