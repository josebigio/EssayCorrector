//
//  SubCriteriaTableViewCell.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/14/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import UIKit

class SubCriteriaTableViewCell: UITableViewCell {

    @IBOutlet weak var subCriteria: UILabel!
    @IBOutlet weak var score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
