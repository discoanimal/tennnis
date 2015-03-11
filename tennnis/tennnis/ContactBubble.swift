//  ContactBubble.swift
//  Created by Justin Lynch on 3/11/15.
//  Copyright (c) 2015 jlynch.co. All rights reserved.

import UIKit
import QuartzCore
import Foundation

protocol ContactBubbleDelegate : class {
    func contactBubbleWasSelected(contactBubble: ContactBubble!)
    func contactBubbleWasUnSelected(contactBubble: ContactBubble!)
    func contactBubbleShouldBeRemoved(contactBubble: ContactBubble!)
}

class ContactBubble : UIView, UITextViewDelegate {
    let kHorizontalPadding = 10
    let kVerticalPadding = 2
    let kBubbleColor = UIColor(red: CGFloat(24.0/255.0), green: CGFloat(134.0/255.0), blue: CGFloat(242.0/255.0), alpha: CGFloat(1.0))
    let kBubbleColorSelected = UIColor(red: CGFloat(151.0/255.0), green: CGFloat(199.0/255.0), blue: CGFloat(250.0/255.0), alpha: CGFloat(1.0))
    var name : String
    var label : UILabel
    var textView : UITextView
    var isSelected : Bool
    var delegate : ContactBubbleDelegate?
    var gradientLayer : CAGradientLayer
    var color : BubbleColor
    var selectedColor : BubbleColor
    
    func initWithName(name: String) -> AnyObject {
        self.initWithName(name, color: nil, selectedColor: nil)
        return self
    }
    
    func initWithName(name: String, color: BubbleColor!, selectedColor: BubbleColor!) -> AnyObject {
        super.initWithName(name)
        self.name = name
        self.isSelected = false
        if (color == nil) {
            color = BubbleColor(kBubbleColor, kBubbleColor, kBubbleColor)
        }
        if (selectedColor == nil) {
            selectedColor = BubbleColor(kBubbleColorSelected, kBubbleColorSelected, kBubbleColorSelected)
        }
        self.color = color
        self.selectedColor = selectedColor
        self.setupView()
        return self
    }
    
    func setupView() {
        self.label = UILabel()
        self.label.backgroundColor = UIColor.clearColor()
        self.label.text = self.name
        self.addSubview(self.label)
        self.textView = UITextView()
        self.textView.delegate = self
        self.textView.hidden = true
        self.addSubview(self.textView)
        var tapGesture = UITapGestureRecognizer(target: self, action: "handleTapGesture")
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
        self.adjustSize()
        self.unSelect()
    }
    
    func adjustSize() {
        self.label.sizeToFit()
        var frame : CGRect = self.label.frame
        frame.origin.x = kHorizontalPadding
        frame.origin.y = kVerticalPadding
        self.label.frame = frame
        self.bounds = CGRectMake(0, 0, frame.size.width + 2 * kHorizontalPadding, frame.size.height + 2 * kVerticalPadding)
        if (self.gradientLayer == nil) {
            var layer : CAGradientLayer = self.gradientLayer
            layer.insertSublayer(self.gradientLayer, atIndex: 0)
        }
        self.gradientLayer.frame = self.bounds
        var viewLayer : CALayer = self.layer
        viewLayer.cornerRadius = self.bounds.size.height / 2
        viewLayer.borderWidth = 1
        viewLayer.masksToBounds = true
    }
    
    func setFont(font: UIFont!) {
        self.label.font = font
        self.adjustSize()
    }
    
    func select() {
        if self.delegate?.respondsToSelector(Selector("contactBubbleWasSelected:")) {
            self.delegate!.contactBubbleWasSelected!(self)
        }
        
        var viewLayer : CALayer = self.layer
        viewLayer.borderColor = self.selectedColor.border.CGColor
        self.gradientLayer.colors = NSArray(self.selectedColor.gradientTop.CGColor, self.selectedColor.gradientBottom.CGColor, nil)
        self.label.textColor = UIColor.whiteColor()
        self.isSelected = true
        self.textView.becomeFirstResponder()
    }
    
    func unSelect() {
        var viewLayer : CALayer = self.layer
        viewLayer.borderColor = self.selectedColor.border.CGColor
        self.gradientLayer.colors = NSArray(self.color.gradientTop.CGColor, self.color.gradientBottom.CGColor, nil)
        self.label.textColor = UIColor.whiteColor()
        self.isSelected = false
        self.textView.resignFirstResponder()
    }
    
    func handleTapGesture() {
        if (self.isSelected) {
            self.unSelect()
        } else {
            self.select()
        }
    }
    
    // TestView Delegate
    
    func textView(textView: UITextView!, shouldChangeTextInRange range: NSRange, replacementText text: String) -> CBool {
        self.textView.hidden = false
        if (textView.text == "\n") {
            return false
        }
        if (textView.text == "" && text == "") {
            if self.delegate?.respondsToSelector(Selector("contactBubbleShouldBeRemoved:")) {
                self.delegate!.contactBubbleShouldBeRemoved!(self)
            }
        }
        if (self.isSelected) {
            self.textView.text = ""
            self.unSelect()
            if self.delegate?.respondsToSelector(Selector("contactBubbleWasUnSelected:")) {
                self.delegate!.contactBubbleWasUnSelected!(self)
            }
        }
        return true
    }
    
}

