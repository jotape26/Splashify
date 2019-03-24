//
//  ColorTableCell.swift
//  Splashify
//
//  Created by João Leite on 24/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import UIKit

class ColorTableCell: UITableViewCell {

    @IBOutlet weak var colorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
