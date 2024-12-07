//
//  UIColor.swift
//  testingtesting123
//
//  Created by Krystal Kymn on 12/6/24.
//
import UIKit

extension UIColor {
    static let hack = Hack()
    
    struct Hack {
        let black = UIColor.black
        let ruby = UIColor(red: 205/255, green: 37/255, blue: 32/255, alpha: 1)
        let silver = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        let green = UIColor(red: 95/255, green: 186/255, blue: 34/255, alpha: 1)
        let white = UIColor.white
    }
}
