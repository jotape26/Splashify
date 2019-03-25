//
//  InputURLController.swift
//  Splashify
//
//  Created by João Leite on 25/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import UIKit

class InputURLController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var txtUrl: UITextField!
    @IBOutlet weak var btSearch: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func searchBtnClicked(_ sender: Any) {
        if let txtUrl = txtUrl.text {
            if let url = URL(string: txtUrl) {
                ImageService.downloadImage(url: url,
                                           success: { (image) in
                                            self.dismiss(animated: true, completion: nil)
                                            
                                            ColorService.urlColorSearch(imageURL: txtUrl, success: { (colors) in
                                                let vc = ImageColorsController.create(image: image, colors: colors)
                                                UIApplication.shared.keyWindow?.visibleViewController()?.navigationController?.pushViewController(vc, animated: true)
                                            }, error: {
                                                print("error downloading colors")
                                            })
                }) {
                    print("error downloading image")
                }
            }
        }
    }
}
