//
//  StepperLabel2.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/15/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import UIKit

protocol ECStepperLabelDelegate: class {
    func scoreChanged(stepper: ECStepperLabel)
}

@IBDesignable
class ECStepperLabel: UIView {
    
    //constants(builders)
    private var hDist = 20
    private var vDist = 5
    private var textViewHeight = 30
    private var textViewWidth = 40
    
    
    
    private var max = 5
    private var count = 0
    private var textView = UILabel()
    private var incrementButton = UIButton()
    private var decrementButton = UIButton()
    
    var delegate:ECStepperLabelDelegate?
    
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
        let buttonDimension = textViewHeight/2 - vDist
        return CGSize(width: textViewWidth + hDist + buttonDimension, height: textViewHeight)
    }
    
    override func layoutSubviews() {
        let buttonDimension = textViewHeight/2 - vDist
        
        textView.frame = CGRect(x: 0,y: 0,width: textViewWidth,height: textViewHeight)
        incrementButton.frame = CGRect(x: textViewWidth + hDist,y: 0,width: buttonDimension,height: buttonDimension)
        decrementButton.frame = CGRect(x: textViewWidth + hDist,y: buttonDimension+vDist,width: buttonDimension,height: buttonDimension)
        
    }
    
    // MARK: Public
    func setMax(max: Int) {
        self.max = max
        textView.text = "\(count)/\(max)"
    }
    
    func setScore(count: Int) {
        self.count = count
        textView.text = "\(count)/\(max)"
    }
    
    func getScore() -> Int {
        return count
    }
    
    
    // MARK: Private
    @objc private func increment(button: UIButton) {
        if(count<max) {
            count += 1
            textView.text = "\(count)/\(max)"
            delegate?.scoreChanged(self)
        }
    }
    
    @objc private func decrement(button: UIButton) {
        if(count>0) {
            count -= 1
            textView.text = "\(count)/\(max)"
            delegate?.scoreChanged(self)
        }
    }
    
    private func setupView(){
        textView.text = "0/\(max)"
        
        incrementButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        incrementButton.setTitle("+", forState: .Normal)
        incrementButton.addTarget(self, action: #selector(ECStepperLabel.increment(_:)), forControlEvents: .TouchUpInside)
        
        decrementButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        decrementButton.setTitle("-", forState: .Normal)
        decrementButton.addTarget(self, action: #selector(ECStepperLabel.decrement(_:)), forControlEvents: .TouchUpInside)
        
        addSubview(textView)
        addSubview(incrementButton)
        addSubview(decrementButton)
    }
    
    private func callDelegate() {
        delegate?.scoreChanged(self)
    }
    
    
    
    
    
}
