//
//  ViewController.swift
//  NSStringHomeWork
//
//  Created by VyacheslavKrivoi on 4/13/19.
//  Copyright © 2019 VyacheslavKrivoi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    var myRangeSecondString: NSRange?
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextLabels()
        
    }
    
    func setTextLabels() {
        
        let myShadowToString1 = NSShadow()
        myShadowToString1.shadowBlurRadius = 5
        myShadowToString1.shadowOffset = CGSize(width: 3, height: 3)
        myShadowToString1.shadowColor = UIColor.black
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 25.0)! ]
        let AttrStringToLabel1 = NSMutableAttributedString(string: " First ", attributes: myAttribute )
        AttrStringToLabel1.append(NSAttributedString(string: " string  "))
        
        let label1Range1 = NSRange(location: 0, length: 7)
        let label1Range2 = NSRange(location: 8, length: 7)
        let label1FullRange = NSRange(location: 0, length: 15)
        
        AttrStringToLabel1.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: label1Range1)
        AttrStringToLabel1.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: label1Range2)
        AttrStringToLabel1.addAttribute(NSAttributedString.Key.font, value: UIFont(name:"Courier", size: 32)!, range: label1Range2)
        AttrStringToLabel1.addAttribute(NSAttributedString.Key.shadow, value: myShadowToString1, range: label1FullRange)
        
        
        
        label1.textAlignment = .right
        label1.lineBreakMode = NSLineBreakMode.byWordWrapping
        label1.attributedText = AttrStringToLabel1
        let myAttributeSecondString = [ NSAttributedString.Key.font: UIFont(name: "Damascus", size: 25.0)! ]
        
        
        
        let label2String = NSMutableAttributedString(string:"String is a Link", attributes: myAttributeSecondString )
        myRangeSecondString = NSRange(location: 12, length: 4)
        label2String.addAttribute(NSAttributedString.Key.link, value: "run", range: myRangeSecondString!)
        label2.attributedText = label2String
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapLabel(gesture:)))
        label2.addGestureRecognizer(gesture)
    }
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        if gesture.didTapAttributedTextInLabel(label: label2, inRange: myRangeSecondString!) {
            if label1.backgroundColor == UIColor.yellow {
                label1.backgroundColor = UIColor.green
            } else {
                label1.backgroundColor = UIColor.yellow
            }
        }
    }
}


extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}



