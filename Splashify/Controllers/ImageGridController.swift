//
//  ImageGridController.swift
//  Splashify
//
//  Created by João Leite on 24/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import UIKit
import Photos
import Presentr

class ImageGridController: UIViewController {
    
    @IBOutlet weak var imageGrid: UICollectionView!
    var arrImages: [UIImage] = []
    
    var presenter : Presentr {
        let width = ModalSize.full
        let height = ModalSize.fluid(percentage: 0.30)
        let center = ModalCenterPosition.bottomCenter
        let customType = PresentationType.custom(width: width, height: height, center: center)
        
        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = .coverVerticalFromTop
        customPresenter.dismissTransitionType = .crossDissolve
        customPresenter.roundCorners = false
        customPresenter.backgroundOpacity = 0.5
        customPresenter.dismissOnSwipe = true
        customPresenter.dismissOnSwipeDirection = .top
        customPresenter.keyboardTranslationType = .moveUp
        return customPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageGrid.delegate = self
        imageGrid.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.imageGrid.reloadData()
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        
        customPresentViewController(presenter, viewController: InputURLController(), animated: true)
//        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
//            PHPhotoLibrary.requestAuthorization { (status) in
//                if status == .authorized {
//                    self.selectImage(sourceType: .photoLibrary)
//                } else {
//                    print("Not Authorized. Allow on settings.")
//                    //TODO MODAL TUTORIAL
//                }
//            }
//        } else if PHPhotoLibrary.authorizationStatus() == .authorized {
//            self.selectImage(sourceType: .photoLibrary)
//        }
    }
    
    func selectImage(sourceType: UIImagePickerController.SourceType) {
        let pickerVC = UIImagePickerController()
        pickerVC.delegate = self
        pickerVC.sourceType = sourceType
        present(pickerVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GridToColorsSegue" {
            if let vc = segue.destination as? ImageColorsController {
                vc.selectedImage = arrImages.first!
            }
        }
    }
}

extension ImageGridController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageGridCell", for: indexPath) as! ImageGridCell
        cell.image.image = arrImages[indexPath.row]
        return cell
    }
}

extension ImageGridController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            arrImages.insert(image, at: 0)
            performSegue(withIdentifier: "GridToColorsSegue", sender: nil)
        }
    }
}

extension ImageGridController: UICollectionViewDelegateFlowLayout {}

