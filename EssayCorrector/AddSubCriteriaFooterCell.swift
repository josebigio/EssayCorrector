//
//  AddSubCriteriaFooterCell.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/21/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import UIKit

protocol AddSubCriteriaFooterCellDelegate: class {
    func addSubCriteriaToCriteria(criteria: String?)
}

class AddSubCriteriaFooterCell: UITableViewCell {
    
    @IBOutlet weak var addButton: UIButton!
    var delegate:AddSubCriteriaFooterCellDelegate?
    var criteriaKey:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addButton.addTarget(self, action:#selector(callDelegate), forControlEvents: .TouchUpInside)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func callDelegate() {
       delegate?.addSubCriteriaToCriteria(criteriaKey)
    }
    
}
