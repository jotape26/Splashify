//
//  PreferencesController.swift
//  Splashify
//
//  Created by João Leite on 25/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import UIKit

enum SelectedPalette : Int {
    case kSimple
    case kW3C
    case kPrecise
    
    func paletteName() -> String {
        switch self {
        case .kSimple:
            return "Simple"
        case .kW3C:
            return "W3C"
        case .kPrecise:
            return "Precise"
        }
    }
    
    static func build(type: String) -> SelectedPalette {
        switch type {
        case "simple":
            return SelectedPalette.kSimple
        case "w3c":
            return SelectedPalette.kW3C
        case "precise":
            return SelectedPalette.kPrecise
        default:
            return SelectedPalette.kSimple
        }
    }
}

class PreferencesController: UIViewController {
    
    @IBOutlet weak var paleteSegment: UISegmentedControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        paleteSegment.addTarget(self, action: #selector(paletteDidChange(_:)), for: .valueChanged)
        paleteSegment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "SourceSansPro-Regular", size: 17.0)!], for: .normal)
        
        if let selected = UserDefaults.standard.value(forKey: "selectedPalette") as? String{
            let palette = SelectedPalette.build(type: selected)
            paleteSegment.selectedSegmentIndex = palette.rawValue
        } else {
            UserDefaults.standard.set("simple", forKey: "selectedPalette")
            paleteSegment.selectedSegmentIndex = 0
        }
        
        paletteDidChange(paleteSegment)
    }
    
    @objc func paletteDidChange(_ segment: UISegmentedControl){
        
        switch segment.titleForSegment(at: segment.selectedSegmentIndex) {
        case "Simple":
            descriptionLabel.text = "This is the default palette. It includes the most general colors (spectrum colors and few other)."
            UserDefaults.standard.set("simple", forKey: "selectedPalette")
        case "W3C":
            descriptionLabel.text = "This palette contains W3C-compliant colors (can be used in HTML and CSS)."
            UserDefaults.standard.set("w3c", forKey: "selectedPalette")
        case "Precise":
            descriptionLabel.text = "This palette contains about 1500 color names and can be used to precisely identify colors and tones."
            UserDefaults.standard.set("precise", forKey: "selectedPalette")
        default:
            break
        }
    }
    
    @IBAction func dismissClicked(_ sender: Any) {
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
