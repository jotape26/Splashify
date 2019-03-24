//
//  ImageColorsController.swift
//  Splashify
//
//  Created by João Leite on 24/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import UIKit

class ImageColorsController: UIViewController {

    @IBOutlet weak var colorsTable: UITableView!
    var selectedImage: UIImage!
    var colors : [ColorDTO]?
    
    class func create(image: UIImage) -> ImageColorsController{
        let colorController = ImageColorsController()
        colorController.selectedImage = image
        return colorController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
}
