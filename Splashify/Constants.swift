//
//  Constants.swift
//  Splashify
//
//  Created by João Leite on 24/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import Foundation

struct Constants {
    struct Endpoints {
        static let dataImageURL = URL(string: "https://apicloud-colortag.p.rapidapi.com/tag-file.json")!
        static let urlImageURL = URL(string: "https://apicloud-colortag.p.rapidapi.com/tag-url.json")!
    }
    
    static let header = ["X-RapidAPI-Key" : "416c185b9fmsh670b5a214f7f511p18383ejsn9fd071cf70ab",
                         "Content-Type" : "application/x-www-form-urlencoded"]
}
