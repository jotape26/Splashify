//
//  Extensions.swift
//  Splashify
//
//  Created by João Leite on 24/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    // UIColor Extension from Hacking With Swift in order to make conversions from service easier.
    // https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    // UIColor Extension from StackOverflow in order to make color names and hex values readeable on the color cell.
    // https://stackoverflow.com/questions/47365583/determining-text-color-from-the-background-color-in-swift
    
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50 ? true : false
    }
    
}

public extension UIWindow {
    
    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(vc: rootViewController)
        }
        return nil
    }
    
    class func getVisibleViewControllerFrom(vc : Any) -> UIViewController {
        
        if vc is UINavigationController {
            
            let navigationController = (vc as! UINavigationController)
            return UIWindow.getVisibleViewControllerFrom(vc: navigationController.visibleViewController ?? UIViewController())
            
        } else if vc is UITabBarController {
            
            let tabBarController = (vc as! UITabBarController)
            return UIWindow.getVisibleViewControllerFrom(vc: tabBarController.selectedViewController ?? UIViewController())
            
        } else {
            
            let controller = (vc as! UIViewController)
            if let presentedViewController = controller.presentedViewController {
                
                return UIWindow.getVisibleViewControllerFrom(vc: presentedViewController)
                
            } else {
                
                return controller;
            }
        }
    }
}
