//
//  SubCriteriaTableViewCell.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/14/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import UIKit

protocol SubCriteriaTableViewCellDelegate: class {
    func scoreChanged(cell: SubCriteriaTableViewCell)
}

class SubCriteriaTableViewCell: UITableViewCell, ECStepperLabelDelegate {

    @IBOutlet weak var subCriteria: UILabel!
    @IBOutlet weak var score: ECStepperLabel!
    var delegate:SubCriteriaTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        score.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func scoreChanged(stepper: ECStepperLabel) {
        delegate?.scoreChanged(self)
    }

}
