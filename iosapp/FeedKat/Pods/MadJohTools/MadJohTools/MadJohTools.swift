//
//  MadJohTools.swift
//  Versus
//
//  Created by Valentin Barat on 29/12/2016.
//  Copyright © 2016 madjoh. All rights reserved.
//

import Foundation
import UIKit

public class MadJohTools
{
    public static var textFont: UIFont!
    
    public static func delay(_ delay: Double, closure:@escaping ()->())
    {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    public static func repeatCode(_ delay: Double, closure:@escaping () -> Bool)
    {
        if (closure())
        {
            MadJohTools.delay(delay) {
                MadJohTools.repeatCode(delay, closure: closure)
            }
        }
    }
}
