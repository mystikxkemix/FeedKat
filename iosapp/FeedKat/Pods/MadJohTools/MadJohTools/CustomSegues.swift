//
//  customSegues.swift
//  Versus
//
//  Created by Valentin Barat on 25/02/2016.
//  Copyright © 2016 madjoh. All rights reserved.
//

import Foundation
import UIKit


// from left to right
public class appearFromLeft: UIStoryboardSegue
{
    override public func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
            delay: 0.0,
            options: UIViewAnimationOptions(),
            animations: {
                dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
            },
            completion: { finished in
                src.present(dst, animated: false, completion: nil)
            }
        )
    }
}

// from left to right
public class leaveFromLeft: UIStoryboardSegue
{
    override public func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        
        UIView.animate(withDuration: 0.25,
            delay: 0.0,
            options: UIViewAnimationOptions(),
            animations:
            {
                src.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
            },
            completion: { finished in
                src.present(dst, animated: false, completion: nil)
            }
        )
    }
}

// from right to left
public class appearFromRight: UIStoryboardSegue
{
    override public func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
            delay: 0.0,
            options: UIViewAnimationOptions(),
            animations: {
                dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
            },
            completion:
            {
                finished in
                src.present(dst, animated: false, completion: nil)
            }
        )
    }
}

// from right to left
public class leaveFromRight: UIStoryboardSegue
{
    override public func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        
        UIView.animate(withDuration: 0.25,
            delay: 0.0,
            options: UIViewAnimationOptions(),
            animations:
            {
                src.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
            },
            completion: { finished in
                src.present(dst, animated: false, completion: nil)
            }
        )
    }
}
