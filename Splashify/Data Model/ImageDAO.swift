//
//  ImageDAO.swift
//  Splashify
//
//  Created by João Leite on 25/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ImageDAO {
    
    static func saveImageWithColors(downloadedImage: UIImage, imageUrl: String, colors: [ColorDTO]) -> Image{
        let deg = UIApplication.shared.delegate as! AppDelegate
        let dataController = deg.dataController
        
        let image = Image(context: dataController.viewContext)
        image.image = downloadedImage.pngData()!
        image.palette = "simple"
        image.imageURL = imageUrl
        
        var colorsCD : [Color] = []
        colors.forEach { (colorDto) in
            let color = Color(context: dataController.viewContext)
            color.colorHex = colorDto.colorHex
            color.colorName = colorDto.colorName
            color.image = image
            colorsCD.append(color)
        }
        
        try? dataController.viewContext.save()
        return image
    }
    
    static func removeColorsFromImage(image: Image){
        let deg = UIApplication.shared.delegate as! AppDelegate
        let dataController = deg.dataController
        
        let request: NSFetchRequest<Color> = Color.fetchRequest()
        request.predicate = NSPredicate(format: "image = %@", image)
        
        if let result = try? dataController.viewContext.fetch(request) {
            result.forEach { (color) in
                dataController.viewContext.delete(color)
            }
            try? dataController.viewContext.save()
        }
        
    }
    
    static func updateImage(image: Image, palette: String, colors: [ColorDTO]) {
        let deg = UIApplication.shared.delegate as! AppDelegate
        let dataController = deg.dataController
        
        image.palette = palette
        
        var colorsCD : [Color] = []
        colors.forEach { (colorDto) in
            let color = Color(context: dataController.viewContext)
            color.colorHex = colorDto.colorHex
            color.colorName = colorDto.colorName
            color.image = image
            colorsCD.append(color)
        }
        
        try? dataController.viewContext.save()
    }
    
}

class ColorDAO {
    
    static func fetchColors(selectedImage: Image) -> [Color]{
        let deg = UIApplication.shared.delegate as! AppDelegate
        let dataController = deg.dataController
        
        let request: NSFetchRequest<Color> = Color.fetchRequest()
        request.predicate = NSPredicate(format: "image = %@", selectedImage)
        
        if let result = try? dataController.viewContext.fetch(request) {
            return result
        } else {
            return []
        }

    }

}
