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
    @IBOutlet weak var imageContainer: UIImageView!
    var selectedImage: UIImage!
    var colors : [ColorDTO]?
    
    class func create(image: UIImage, colors: [ColorDTO]) -> ImageColorsController{
        let colorController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageColorsController") as! ImageColorsController
        colorController.selectedImage = image
        colorController.colors = colors
        return colorController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        colorsTable.delegate = self
        colorsTable.dataSource = self
        imageContainer.image = selectedImage
    }
}

extension ImageColorsController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorTableCell") as! ColorTableCell
        let color = colors![indexPath.row]
        
        if let literalColor = color.colorHex {
            cell.backgroundColor = UIColor(hexString: literalColor)
            cell.colorLabel.text = "\(color.colorName!) \n \(color.colorHex!)"
            
            if UIColor(hexString: literalColor).isDarkColor {
                cell.colorLabel.textColor = .white
            } else {
                cell.colorLabel.textColor = .black
            }
        } else {
            cell.backgroundColor = .white
            cell.colorLabel.textColor = .black
            cell.colorLabel.text = "Error parsing color \(color.colorName!)"
        }
        
        return cell
    }
}
