//
//  InputURLController.swift
//  Splashify
//
//  Created by João Leite on 25/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import UIKit
import CoreData

class InputURLController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var txtUrl: UITextField!
    @IBOutlet weak var btSearch: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btSearch.layer.cornerRadius = 5.0
    }


    @IBAction func searchBtnClicked(_ sender: Any) {
        if let txtUrl = txtUrl.text {
            if let url = URL(string: txtUrl) {
                ImageService.downloadImage(url: url,
                                           success: { (image) in
                                            self.dismiss(animated: true, completion: nil)
                                            
                                            ColorService.urlColorSearch(imageURL: txtUrl, success: { (colors) in
                                                self.saveImageWithColors(downloadedImage: image, colors: colors)
                                            }, error: {
                                                print("error downloading colors")
                                            })
                }) {
                    print("error downloading image")
                }
            }
        }
    }
    
    func saveImageWithColors(downloadedImage: UIImage, colors: [ColorDTO]){
        let deg = UIApplication.shared.delegate as! AppDelegate
        let dataController = deg.dataController
        
        let image = Image(context: dataController.viewContext)
        image.image = downloadedImage.pngData()!
        image.palette = "simple"
        
        var colorsCD : [Color] = []
        colors.forEach { (colorDto) in
            let color = Color(context: dataController.viewContext)
            color.colorHex = colorDto.colorHex
            color.colorName = colorDto.colorName
            color.image = image
            colorsCD.append(color)
        }
        
        try? dataController.viewContext.save()
        
        let vc = ImageColorsController.create(image: image, colors: colorsCD)
        UIApplication.shared.keyWindow?.visibleViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}
