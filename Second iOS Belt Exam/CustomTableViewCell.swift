//
//  CustomTableViewCell.swift
//  Second iOS Belt Exam
//
//  Created by Ian Yang on 3/27/18.
//  Copyright © 2018 Ian Yang. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    var indexPath: IndexPath?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
