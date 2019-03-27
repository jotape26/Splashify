//
//  ColorPreviewController.swift
//  Splashify
//
//  Created by João Leite on 26/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import UIKit

class ColorPreviewController: UIViewController {

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var btClose: UIButton!
    var color : Color!

    class func create(color: Color) -> ColorPreviewController {
        let colorVC = ColorPreviewController(nibName: "ColorPreviewController", bundle: nil) as! ColorPreviewController
        colorVC.color = color
        return colorVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let hex = color.colorHex {
            let bgColor = UIColor(hexString: hex)
            view.backgroundColor = bgColor
            
            colorLabel.text = "\(color.colorName!) \n \(color.colorHex!)"
            
            if bgColor.isDarkColor {
                colorLabel.textColor = .white
                btClose.setTitleColor(UIColor.white, for: .normal)
            } else {
                colorLabel.textColor = .black
                btClose.setTitleColor(UIColor.black, for: .normal)
            }
        }
        
    }

    @IBAction func closeBtClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
