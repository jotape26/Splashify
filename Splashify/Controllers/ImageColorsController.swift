//
//  ImageColorsController.swift
//  Splashify
//
//  Created by João Leite on 24/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import UIKit
import CoreData

class ImageColorsController: UIViewController {

    @IBOutlet weak var colorsTable: UITableView!
    @IBOutlet weak var imageContainer: UIImageView!
    var selectedImage: Image!
    var arrColors : [Color]?
    
    class func create(image: Image) -> ImageColorsController {
        let colorController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageColorsController") as! ImageColorsController
        colorController.selectedImage = image
        colorController.arrColors = ColorDAO.fetchColors(selectedImage: image)
        return colorController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        colorsTable.delegate = self
        colorsTable.dataSource = self
        if let imageData = selectedImage.image {
            imageContainer.image = UIImage(data: imageData)!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = UIColor(hexString: "#BF5AF2")
    }
    
}

extension ImageColorsController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrColors?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorTableCell") as! ColorTableCell
        let color = arrColors![indexPath.row]
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ColorPreviewController.create(color: arrColors![indexPath.row])
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
}
