//
//  YUNG.swift
//  FirebaseDemo
//
//  Created by Duncan on 2016/6/27.
//  Copyright © 2016年 Duncan. All rights reserved.
//

import Foundation
//import UIKit

extension UIViewController {
    
    func isSupport() -> Bool {
        return NSClassFromString("UIAlertController") != nil
    }
    
    public func YUNGalert(_ message: String!) {
        if isSupport() {
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}

/**
 Executes the closure on the main queue after a set amount of seconds.
 
 - parameter delay:   Delay in seconds
 - parameter closure: Code to execute after delay
 */
func delayOnMainQueue(_ delay: Double, closure: ()->()) {
    DispatchQueue.main.after(when: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

/**
 Executes the closure on a background queue after a set amount of seconds.
 
 - parameter delay:   Delay in seconds
 - parameter closure: Code to execute after delay
 */
/*
func delayOnBackgroundQueue(_ delay: Double, closure: ()->()) {
    DispatchQueue.global(Int(UInt64(DispatchQueueAttributes.qosUtility.rawValue)), 0).after(when: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
*/
