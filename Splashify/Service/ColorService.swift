//
//  ColorService.swift
//  Splashify
//
//  Created by João Leite on 24/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ColorService {
    
    static func urlColorSearch(imageURL: String,
                               success: @escaping ([ColorDTO])->(),
                               error: @escaping ()->()){
        
        let params : [String: Any] = ["url" : imageURL]
        
        
        Alamofire.request(Constants.Endpoints.urlImageURL,
                          method: .get,
                          parameters: params,
                          encoding: URLEncoding.default,
                          headers: Constants.header).responseString { (response) in
                            if response.response?.statusCode != 200 {
                                error()
                            }
                            if let value = response.result.value {
                                if let tagsResponse = try? TagsDTO(JSONString: value) {
                                    if let colorTags = tagsResponse.tags {
                                        success(colorTags)
                                    }
                                }
                            }
        }
    }
}
