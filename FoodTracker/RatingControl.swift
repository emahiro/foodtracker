//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Hiromichi Ema on 2017/01/15.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    // MARK: Properties
    
    private var ratingButtons = [UIButton]() // empty when initialize
    var rating = 0 {
        didSet{
            updateButtonSelectionState()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet{
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 0 {
        didSet{
            setupButtons()
        }
    }

    // MARK: initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // MARK: Button Action
    
    func ratingButtonTapped(button: UIButton){
        guard let index = ratingButtons.index(of: button) else {
             fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calucurated the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // if the selected star represented the current rating, reset the rating to 0
            rating = 0
        }
        else {
            // otherwise set the rating to the seletcted star
            rating = selectedRating
        }
    }
    
    // MARK: private method
    
    private func setupButtons(){
        
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0 ..< starCount{
            // Create the Buttons
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.selected,
                                                    .highlighted])
            
            // Add constrains
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Set the accessibility label
            button.accessibilityLabel = "set \(index) star rating"
            
            // Add the button to the stack
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            
            // Add the new button to the raiting button array
            ratingButtons.append(button)
        }
        
        updateButtonSelectionState()
    }
    
    
    private func updateButtonSelectionState(){
        for(index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating , that button should  be selected
            button.isSelected = index < rating
            
            // Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero"
            }
            else {
                hintString = nil
                
            }
            
            // Calucurate the value string
            let valueString: String
            switch rating {
            case 0:
                valueString = "No rating Set"
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) star set"
            }
            
            // Assign the hint String and hint Value
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
