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
    
    var presenter : Presentr {
        let width = ModalSize.full
        let height = ModalSize.fluid(percentage: 0.2)
        let center = ModalCenterPosition.bottomCenter
        let customType = PresentationType.custom(width: width, height: height, center: center)
        
        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = .coverVertical
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
        fetchOldImages()
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        customPresentViewController(presenter, viewController: InputURLController(), animated: true)
    }
    
    func fetchOldImages(){
        let deg = UIApplication.shared.delegate as! AppDelegate
        self.dataController = deg.dataController
        
        let request: NSFetchRequest<Image> = Image.fetchRequest()
        if let result = try? dataController.viewContext.fetch(request) {
            self.arrImages = result
        }
        self.imageGrid.reloadData()
    }
    
//    func selectImage(sourceType: UIImagePickerController.SourceType) {
//        let pickerVC = UIImagePickerController()
//        pickerVC.delegate = self
//        pickerVC.sourceType = sourceType
//        present(pickerVC, animated: true, completion: nil)
//    }
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let selectedImage = arrImages[indexPath.row]
        
        let colorVC = ImageColorsController.create(image: selectedImage)
        navigationController?.pushViewController(colorVC, animated: true)     
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

