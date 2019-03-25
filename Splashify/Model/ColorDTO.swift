//
//  ColorDTO.swift
//  Splashify
//
//  Created by João Leite on 24/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import Foundation
import ObjectMapper

class TagsDTO : ImmutableMappable {
    var tags : [ColorDTO]?
    required init(map: Map) throws {
        tags = try? map.value("tags")
    }
}

class ColorDTO : ImmutableMappable {
    var colorName: String?
    var colorHex: String?
    
    required init(map: Map) {
        colorHex = try? map.value("color")
        colorName = try? map.value("label")
    }
}
