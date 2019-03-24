//
//  ColorDTO.swift
//  Splashify
//
//  Created by João Leite on 24/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import Foundation
import UIKit

class ColorDTO {
    var colorName: String
    var colorHex: UIColor
    
    init(name: String, hex: String) {
        if let color = UIColor.init(hexString: hex) {
            self.colorName = name
            self.colorHex = color
        } else {
            self.colorName = "Error parsing color: \(name)"
            self.colorHex = UIColor.white
        } 
    }
}
