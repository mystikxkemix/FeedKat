//
//  DragToActionView.swift
//  Versus
//
//  Created by Valentin Barat on 23/12/2016.
//  Copyright © 2016 madjoh. All rights reserved.
//

import UIKit

public class DragToActionView : UIView
{
    private var posX : CGFloat = 0
    private var oldWidth : CGFloat = 0
    private var action = UIButton()
    private var completionHandler : () -> () = {}
    
    public var actionWidth : CGFloat = 0
    private var actionHeightMultiplier = 0.5 as CGFloat
    
    override public init(frame: CGRect)
    {
        super.init(frame: frame)
        self.gestureRecognizers = []
        
        posX = frame.origin.x
        oldWidth = frame.width
        
        action.frame = CGRect(x: frame.width, y: 0, width: 0, height: frame.height)
        action.backgroundColor = UIColor.red
        action.addTarget(self, action: #selector(self.onClick(_:)), for: .touchUpInside)
        self.addSubview(action)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hideAction)))
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesBegan(touches, with: event)
        
        shouldLetSuperViewsScroll(false)
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesMoved(touches, with: event)
        
        let touch = (touches as NSSet).allObjects[0] as! UITouch
        let oldPos = touch.previousLocation(in: self)
        let moveX = touch.location(in: self).x - oldPos.x
        
        self.move(by: moveX)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesEnded(touches, with: event)
        
        if (self.x < self.posX - 2 * actionWidth / 3)
        {
            let moveX = (self.posX - actionWidth) - self.x
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                self.move(by: moveX)
            }, completion: nil)
        }
        else if (self.x > self.posX - 2 * actionWidth / 3)
        {
            self.hideAction()
        }
        
        shouldLetSuperViewsScroll(true)
    }
    
    // PUBLIC
    
    public func setActionY(_ y: CGFloat)
    {
        self.action.y = y
    }
    
    public func setActionX(_ x: CGFloat)
    {
        self.action.x = x
    }
    
    public func setActionCornerRadius(_ radius: CGFloat)
    {
        self.action.layer.cornerRadius = radius
        self.action.layer.masksToBounds = true
    }
    
    public func setActionHeight(_ height: CGFloat)
    {
        self.action.height = height
        if (action.image(for: .normal) != nil)
        {
            action.setImage(action.image(for: .normal)!.getScaledWithHeight(height: action.height * actionHeightMultiplier), for: .normal)
        }
    }
    
    public func setActionImage(img: UIImage)
    {
        action.setImage(img.getScaledWithHeight(height: action.height * actionHeightMultiplier), for: .normal)
    }
    
    public func setActionImage(imgName: String)
    {
        action.setImage(UIImage.getScaledWithHeight(imgName, height: action.height * actionHeightMultiplier), for: .normal)
    }
    
    public func setActionColor(color: UIColor)
    {
        action.backgroundColor = color
    }
    
    public func addActionTarget(_ handler: @escaping () -> ())
    {
        self.completionHandler = handler
    }
    
    // PRIVATE
    @objc private func onClick(_ button: UIButton)
    {
        completionHandler()
    }
    
    @objc private func hideAction()
    {
        let moveX = self.posX - self.x
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            self.move(by: moveX)
        }, completion: nil)
    }
    
    private func move(by: CGFloat)
    {
        if (x + by > posX)
        {
            x = posX
            width = oldWidth
            action.width = 0
        }
        else
        {
            self.x += by
            self.width -= by
            self.action.width -= by
        }
    }
    
    private func shouldLetSuperViewsScroll(_ b: Bool)
    {
        var superView = self.superview
        while (superView != nil)
        {
            let v = superView as? UIScrollView
            v?.isScrollEnabled = b
            superView = superView?.superview
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
}
