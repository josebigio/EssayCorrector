//
//  CommentPicker.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/27/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation

class CommentPicker: UIView {
    
    var height = 10
    var width = 400
   

    // MARK: Initialization
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    override func layoutSubviews() {
       var picker = UIPickerView.init(frame: self.frame)
        self.addSubview(picker)
        
    }
    
    //MARK: Private
    private func setupView() {
        self.backgroundColor = UIColor.blueColor()
    }

    
}
