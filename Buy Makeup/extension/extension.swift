//
//  extension.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 31/07/2021.
//

import UIKit
extension UIColor{
    convenience init(hexString: String){
        var colorString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        if colorString.hasPrefix("#"){
            colorString.remove(at: colorString.startIndex)
        }
        if colorString.count != 6 {
            self.init()
            return
        }
        let rgbValue = Int(colorString, radix: 16) ?? 0

        let red = CGFloat(rgbValue >> 16) / 255
        let green = CGFloat((rgbValue & 0x00ff00) >> 8 ) / 255
        let blue = CGFloat(rgbValue & 0x0000ff) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
