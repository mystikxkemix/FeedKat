//
//  CustomAnimations.swift
//  Versus
//
//  Created by Valentin Barat on 29/12/2016.
//  Copyright © 2016 madjoh. All rights reserved.
//

import Foundation

public extension UIView
{
    func disappearSmallFade(_ duration: Double = 0.2)
    {
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut, .allowUserInteraction], animations:{
            self.frame = CGRect(x: self.x + self.width / 2, y: self.y + self.height / 2, width: 0, height: 0)
            self.layer.opacity = 0
        }, completion: {
            finish in
            self.removeFromSuperview()
        })
    }
    
    func keepBouncing(_ multiplier: CGFloat, duration: TimeInterval, delay: TimeInterval)
    {
        self.animateBounce(multiplier, duration: duration)
        MadJohTools.delay(delay) {
            self.keepBouncing(multiplier, duration: duration, delay: delay)
        }
    }
    
    // change the view's size and get back to the original frame
    func animateBounce(_ multiplier: CGFloat, duration: TimeInterval)
    {
        let oldTransform = self.transform
        
        UIView.animate(withDuration: duration / 2, delay: 0.0, options: [.allowUserInteraction, .allowAnimatedContent], animations:
            {
                self.transform = self.transform.concatenating(CGAffineTransform(scaleX: multiplier, y: multiplier))
        }, completion:
            {
                finish in
                UIView.animate(withDuration: duration / 2, animations: {
                    self.transform = oldTransform //CGAffineTransform.identity
                })
        })
    }
    
    // create an error wizz
    func animateWizz(_ width: CGFloat, duration: TimeInterval)
    {
        UIView.animate(withDuration: duration / 5, delay: 0.0, options: .allowUserInteraction, animations:
            {
                self.transform = CGAffineTransform(translationX: -width, y: 0)
        }, completion:
            {
                finish in
                UIView.animate(withDuration: duration / 5, delay: 0.0, options: .allowUserInteraction, animations:
                    {
                        self.transform = CGAffineTransform(translationX: 4 * (width / 5), y: 0)
                }, completion:
                    {
                        finish in
                        UIView.animate(withDuration: duration / 5, delay: 0.0, options: .allowUserInteraction, animations:
                            {
                                self.transform = CGAffineTransform(translationX: -(3 * width / 5), y: 0)
                        }, completion:
                            {
                                finish in
                                UIView.animate(withDuration: duration / 5, delay: 0.0, options: .allowUserInteraction, animations:
                                    {
                                        self.transform = CGAffineTransform(translationX: (2 * width / 5), y: 0)
                                }, completion:
                                    {
                                        finish in
                                        UIView.animate(withDuration: duration / 5, delay: 0.0, options: .allowUserInteraction, animations:
                                            {
                                                self.transform = CGAffineTransform(translationX: -(width / 5), y: 0)
                                        }, completion:
                                            {
                                                finish in
                                                UIView.animate(withDuration: duration / 5, delay: 0.0, options: .allowUserInteraction, animations:
                                                    {
                                                        self.transform = CGAffineTransform(translationX: 0, y: 0)
                                                }, completion: nil)
                                        })
                                })
                        })
                })
        })
    }
    
    // change the view's size and get back to the original frame
    func animateAppear(_ duration: TimeInterval, oldTransform: CGAffineTransform? = nil)
    {
        let old = oldTransform == nil ? self.transform : oldTransform!
        
        self.layer.masksToBounds = true
        self.layer.opacity = 1
        self.transform = self.transform.concatenating(CGAffineTransform(scaleX: 0, y: 0))
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction, .curveEaseInOut], animations:
            {
                self.transform = old
        }, completion: nil)
    }
}
