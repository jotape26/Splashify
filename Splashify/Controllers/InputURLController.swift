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
    
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        btSearch.layer.cornerRadius = 5.0
        activityIndicator.hidesWhenStopped = true
        errorLabel.alpha = 0
        errorLabel.textColor = .white
        dialogView.alpha = 0
        dialogView.clipsToBounds = true
        
        let blurredEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurredEffectView.frame = dialogView.bounds
        dialogView.layer.cornerRadius = 4.0
        blurredEffectView.layer.cornerRadius = 4.0
        dialogView.addSubview(blurredEffectView)
        dialogView.sendSubviewToBack(blurredEffectView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        txtUrl.becomeFirstResponder()
    }
    
    @IBAction func searchBtnClicked(_ sender: Any) {
        
        self.dialogView.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            self.dialogView.alpha = 1
            self.activityIndicator.startAnimating()
        }
        
        
        if let txtUrl = txtUrl.text {
            if let url = URL(string: txtUrl) {
                ImageService.downloadImage(url: url,
                                           success: { (image) in
                                            
                                            ColorService.urlColorSearch(imageURL: txtUrl, success: { (colors) in
                                                let vc = ImageColorsController.create(image: ImageDAO.saveImageWithColors(downloadedImage: image, imageUrl: txtUrl, colors: colors))
                                                self.dismiss(animated: true, completion: {UIApplication.shared.keyWindow?.visibleViewController()?.navigationController?.pushViewController(vc, animated: true)})
                                            }, error: {
                                                self.showError(message: "Error retrieving your colors. \nPlease check yout internet and try again.")
                                            })
                }) {
                    self.showError(message: "Error downloading the Image. \nPlease check the URL and your internet connection and try again")
                }
            } else {
                self.showError(message: "Invalid image URL. \n Please check the URL and try again.")
            }
        }
    }
    
    func showError(message: String){
        self.errorLabel.text = message
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.activityIndicator.stopAnimating()
                self.errorLabel.alpha = 1
                self.dialogView.backgroundColor = UIColor.red.withAlphaComponent(0.7)
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 3.0, options: .curveEaseOut, animations: {
                    self.dialogView.alpha = 0
                    self.errorLabel.alpha = 0
                    self.dialogView.backgroundColor = .white
                }, completion: { _ in
                    self.dialogView.isHidden = true
                    self.txtUrl.text = ""
                })
            })
        }
    }
}
