//
//  ImageService.swift
//  Splashify
//
//  Created by João Leite on 25/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ImageService {
    
    static func downloadImage(url: URL,
                              success: @escaping (UIImage)->(),
                              error: @escaping ()->()){
        
        Alamofire.request(url).responseImage { (response) in
            if response.response?.statusCode != 200 {
                error()
            }
            
            if let imageData = response.result.value?.pngData() {
                success(UIImage(data: imageData)!)
            }
        }
        
    }
    
}
