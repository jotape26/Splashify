//
//  ImageGridController.swift
//  Splashify
//
//  Created by João Leite on 24/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import UIKit
import Presentr
import CoreData

class ImageGridController: UIViewController {
    
    @IBOutlet weak var imageGrid: UICollectionView!
    var arrImages: [Image] = []
    var dataController : CoreDataController!
    
    var addNewPresenter : Presentr {
        let width = ModalSize.fluid(percentage: 0.9)
        let height = ModalSize.fluid(percentage: 0.25)
        let center = ModalCenterPosition.center
        let customType = PresentationType.custom(width: width, height: height, center: center)
        
        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = .coverVertical
        customPresenter.dismissTransitionType = .crossDissolve
        customPresenter.roundCorners = true
        customPresenter.backgroundOpacity = 0.5
        customPresenter.blurBackground = true
        customPresenter.dismissOnSwipe = true
        customPresenter.dismissOnSwipeDirection = .top
        customPresenter.keyboardTranslationType = .moveUp
        return customPresenter
    }
    
    var preferencesPresenter : Presentr {
        let width = ModalSize.fluid(percentage: 0.9)
        let height = ModalSize.fluid(percentage: 0.4)
        let center = ModalCenterPosition.center
        let customType = PresentationType.custom(width: width, height: height, center: center)
        
        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = .coverVertical
        customPresenter.dismissTransitionType = .crossDissolve
        customPresenter.roundCorners = true
        customPresenter.backgroundOpacity = 0.5
        customPresenter.blurBackground = false
        customPresenter.keyboardTranslationType = .moveUp
        return customPresenter
    }
    
    var alertPresenter: Presentr {
        let presenter = Presentr(presentationType: .alert)
        presenter.viewControllerForContext = self
        presenter.presentationType = .alert
        return presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageGrid.delegate = self
        imageGrid.dataSource = self
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 17.0)!]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchOldImages()
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        addNewPresenter.viewControllerForContext = self
        customPresentViewController(addNewPresenter, viewController: InputURLController(), animated: true)
    }
    
    @IBAction func parametersClicked(_ sender: Any) {
        preferencesPresenter.viewControllerForContext = self
        customPresentViewController(preferencesPresenter, viewController: PreferencesController(), animated: true)
    }
    
    func fetchOldImages(){
        self.arrImages = ImageDAO.retrieveImages()
        self.imageGrid.reloadData()
    }
    @objc func deleteLongPress(_ gesture: UILongPressGestureRecognizer) {
        let alertViewController = AlertViewController(title: "Delete Image", body: "Do you want to delete this image?")
        
        let deleteAction = AlertAction(title: "Yes", style: .custom(textColor: .red)) {
            if let tag = gesture.view?.tag {
                if ImageDAO.deleteImage(image: self.arrImages[tag]) {
                    self.fetchOldImages()
                }
            }
        }
        
        let okAction = AlertAction(title: "No", style: .default) {
            print("No Action Required!")
        }
        
        alertViewController.addAction(okAction)
        alertViewController.addAction(deleteAction)
        
        customPresentViewController(alertPresenter, viewController: alertViewController, animated: true, completion: nil)
    }
}

extension ImageGridController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageGridCell", for: indexPath) as! ImageGridCell
        if let imageData = arrImages[indexPath.row].image {
            cell.image.image = UIImage(data: imageData)!
        }
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(deleteLongPress(_:)))
        cell.addGestureRecognizer(gesture)
        gesture.view?.tag = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let selectedImage = arrImages[indexPath.row]
        
        if selectedImage.palette == UserDefaults.standard.value(forKey: "selectedPalette") as? String {
            let colorVC = ImageColorsController.create(image: selectedImage)
            navigationController?.pushViewController(colorVC, animated: true)
        } else {
            
            let alertViewController = AlertViewController(title: "Different Palettes",
                                                          body: "Your current palette is different from the one used to process this image.\nWhich palette do you want to use?")
            
            let oldPaletteAction = AlertAction(title: selectedImage.palette!.capitalized, style: .custom(textColor: .red)) {
                alertViewController.dismiss(animated: true, completion: nil)
                let colorVC = ImageColorsController.create(image: selectedImage)
                self.navigationController?.pushViewController(colorVC, animated: true)
            }
            
            let currentPaletteAction = AlertAction(title: (UserDefaults.standard.value(forKey: "selectedPalette") as! String).capitalized, style: .default) {
                self.reprocessImage(selectedImage: selectedImage, selectedPalette: UserDefaults.standard.value(forKey: "selectedPalette") as! String)
            }
            
            alertViewController.addAction(oldPaletteAction)
            alertViewController.addAction(currentPaletteAction)
            
            customPresentViewController(alertPresenter, viewController: alertViewController, animated: true, completion: nil)
        }
    }
    
    func reprocessImage(selectedImage: Image, selectedPalette: String) {
        ImageDAO.removeColorsFromImage(image: selectedImage)
        ImageService.downloadImage(url: URL(string: selectedImage.imageURL!)!,
                                   success: { (image) in
                                    self.dismiss(animated: true, completion: nil)
                                    
                                    ColorService.urlColorSearch(imageURL: selectedImage.imageURL!, success: { (colors) in
                                        ImageDAO.updateImage(image: selectedImage, palette: selectedPalette, colors: colors)
                                        let vc = ImageColorsController.create(image: selectedImage)
                                        UIApplication.shared.keyWindow?.visibleViewController()?.navigationController?.pushViewController(vc, animated: true)
                                    }, error: {
                                        print("error downloading colors")
                                    })
        }) {
            print("error downloading image")
        }
    }
}

//extension ImageGridController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
//            arrImages.insert(image, at: 0)
//            performSegue(withIdentifier: "GridToColorsSegue", sender: nil)
//        }
//    }
//}

extension ImageGridController: UICollectionViewDelegateFlowLayout {}

