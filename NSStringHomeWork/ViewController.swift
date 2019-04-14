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
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 25.0)! ]
        let myString = NSMutableAttributedString(string: " First ", attributes: myAttribute )
        myString.append(NSAttributedString(string: " string  "))
        let myString1Range1 = NSRange(location: 0, length: 7)
        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: myString1Range1)
        let myString2Range2 = NSRange(location: 8, length: 7)
        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: myString2Range2)
        myString.addAttribute(NSAttributedString.Key.font, value: UIFont(name:"Courier", size: 32)!, range: myString2Range2)
        
        label1.textAlignment = .right
        label1.lineBreakMode = NSLineBreakMode.byWordWrapping
        label1.attributedText = myString
        let myAttributeSecondString = [ NSAttributedString.Key.font: UIFont(name: "Damascus", size: 25.0)! ]
        
        let mySecondString = NSMutableAttributedString(string:"String is a Link", attributes: myAttributeSecondString )
        myRangeSecondString = NSRange(location: 12, length: 4)
        mySecondString.addAttribute(NSAttributedString.Key.link, value: "run", range: myRangeSecondString!)
        label2.attributedText = mySecondString
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



