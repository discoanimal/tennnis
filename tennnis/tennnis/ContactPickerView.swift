//  ContactPickerView.swift
//  Created by Justin Lynch on 3/11/15.
//  Copyright (c) 2015 jlynch.co. All rights reserved.

import UIKit

protocol ContactPickerDelegate : class {
    func contactPickerTextViewDidChange(textViewText: String)
    func contactPickerDidRemoveContact(contact: AnyObject)
    func contactPickerDidResize(contactPickerView: ContactPickerView!)
}

class ContactPickerView: UIView, UITextViewDelegate, UIScrollViewDelegate, ContactBubbleDelegate {
    
    var selectedContactBubble : ContactBubble
    var delegate : ContactPickerDelegate?
    var limitToOne : Bool
    var viewPadding : CGFloat
    var font : UIFont
    
    func addContact(contact: AnyObject, withName name: String) {
    }
    func removeContact(contact: AnyObject) {
    }
    func removeAllContacts() {
    }
    func setPlaceholderString(placeholderString: String) {
    }
    func disableDropShadow() {
    }
    func resignKeyboard() {
    }
    func setBubbleColor(color: THBubbleColor!, selectedColor selectedColor: THBubbleColor!) {
    }
    
    
    var scrollView : UIScrollView
    var contacts : NSMutableDictionary
    var contactKeys : NSMutableArray
    var placeholderLabel : UILabel
    var lineHeight : CGFloat
    var textView : UITextView
    var bubbleColor : UIColor
    var bubbleSelectedColor : UIColor
    var _shouldSelectTextView : Bool
    var viewPadding : CGFloat
    let kViewPadding = CGFloat(5)
    let kHorizontalPadding = CGFloat(2)
    let kVerticalPadding = CGFloat(4)
    let kTextViewMinWIdth = CGFloat(130)
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()
    }
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.setUp()
    }
    
    
    
    
    
    func addContact(contact: AnyObject, withName name: String) {
        
    }
    
    func removeContact(contact: AnyObject) {
        
    }
    
    func removeAllContacts() {
        
    }
    
    func setPlaceholderString(placeholderString: String) {
        
    }
    
    func disableDropShadow() {
        
    }
    
    func resignKeyboard() {
        
    }
    
    func setBubbleColor(color: THBubbleColor!, selectedColor: THBubbleColor!) {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // After
    
    func setUp() {
        self.viewPadding = kViewPadding
        
        self.contacts = NSMutableDictionary()
        self.contactKeys = NSMutableArray()
        
        // Create a contact bubble to determine the height of a line
        
        var contactBubble = ContactBubble()
        self.lineHeight = contactBubble.frame.size.height + 2 * kVerticalPadding
        
        self.scrollView = UIScrollView(frame: self.bounds)
        self.scrollView.scrollsToTop = false
        self.scrollView.delegate = self
        self.addSubview(self.scrollView)
        
        // Create TextView
        // It would make more sense to use a UITextField (because it doesnt wrap text), however, there is no easy way to detect the "delete" key press using a UITextField when there is no string in the field
        self.textView = UITextView()
        self.textView.delegate = self;
        self.textView.font = contactBubble.label.font
        self.textView.backgroundColor = UIColor.clearColor()
        self.textView.contentInset = UIEdgeInsetsMake(-4, -2, 0, 0)
        self.textView.scrollEnabled = true
        self.textView.scrollsToTop = true
        self.textView.clipsToBounds = false
        self.textView.autocorrectionType = UITextAutocorrectionType.No
        //[self.textView becomeFirstResponder];
        
        // Add shadow to bottom border
        self.backgroundColor = UIColor.whiteColor()
        var layer = self.layer
        layer.shadowColor = UIColor.Flat.black
        layer.shadowOffset = CGSizeMake(0,2)
        layer.shadowOpacity = 1
        layer.shadowRadius = 1.0
        
        // Add placeholder label
        self.placeholderLabel = UILabel(frame: CGRectMake(8, viewPadding, self.frame.size.width, self.lineHeight))
        self.placeholderLabel.font = contactBubble.label.font
        self.placeholderLabel.textColor = UIColor.grayColor()
        self.placeholderLabel.backgroundColor = UIColor.clearColor()
        self.addSubview(self.placeholderLabel)
        
        var tapGesture = UITapGestureRecognizer(target: self, action:(Selector(handleTapGesture)))
        
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    func disableDropShadow() {
        var layer = self.layer
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
    }
    
    func setFont(font: UIFont) {
        var contactBubble = ContactBubble("Sample")
        contactBubble.setFont(font)
        self.lineHeight = contactBubble.frame.size.height + 2 * kVerticalPadding;
        
        self.textView.font = font;
        self.textView.sizeToFit()
        
        self.placeholderLabel.font = font
        self.placeholderLabel.frame = CGRectMake(8, self.viewPadding, self.frame.size.width, self.lineHeight)
    }
    
    func addContact(contact: AnyObject, withName: String) {
        var contactKey = NSValue.valueWithNonretainedObject(contact)
        if (self.contactKeys.containsObject(contactKey)) {
            println("Cannot add the same object twice to ContactPickerView")
            return
        }
        
        self.textView.text = ""
        var contactBubble = ContactBubble(name, color: self.bubbleColor, selectedColor: self.bubbleSelectedColor)
    
        if (self.font != nil) {
            contactBubble.setFont(self.font)
        }
        contactBubble.delegate = self
        self.contacts.setObject(contactBubble, forKey: contactKey)
        self.contactKeys.addObject(contactKey)
        
        // update layout
        self.layoutView()
        
        // scroll to bottom
        _shouldSelectTextView = true
        self.scrollToBottomWithAnimation(true)
    }
    
    func selectTextView() {
        self.textView.hidden = false
    }
    
    func removeAllContacts() {
        var contactKey = NSValue.valueForKeyPath("contact")
        var contactBubble = ContactBubble(self.contacts.objectForKey(contact))
        contactBubble.removeFromSuperView()
        self.contacts.removeAllObjects()
        self.contactKeys.removeAllObjects()
        self.layoutView()
        self.textView.hidden = false
        self.textView.text = ""
    }
    
    func removeContact(contact: contact) {
        var contactKey = NSValue.valueForKeyPath("contact")
        var contactBubble = ContactBubble(self.contacts.objectForKey(contactKey))
        contactBubble.removeFromSuperView()
        self.contactKeys.removeObject(contactKey)
        self.contactKeys.removeObject(contactKey)
        self.layoutView()
        self.textView.hidden = false
        self.textView.text = ""
        self.scrollToBottomWithAnimation(false)

        
    }
    
    func setPlaceholderString(placeholderString: String) {
        self.placeholderLabel.text = placeholderString
        self.layoutView()
    }
    
    func setBubbleColor(color: UIColor, selectedColor: UIColor) {
        self.bubbleColor = color
        self.bubbleSelectedColor = selectedColor
        
        for (var contactKey in self.contactKeys) {
            var contactBubble = ContactBubble(self.contacts.objectForKey(contact))
            contactBubble.color = color
            contactBubble.selectedColor = selectedColor
            
            if (contactBubble.isSelected) {
                contactBubble.select()
            } else {
                contactBubble.unSelect()
            }
        }
    }
    
    func scrollToBottomWithAnimation(animated: bool) {
        if (animated) {
            var size = self.scrollView.contentSize
            var frame = CGRectMake(0, size.height - self.scrollView.frame.size.height, size.width, self.scrollView.frame.size.height)
            self.scrollView.scrollRectToVisible(frame, animated: animated)
        } else {
            var offset = self.scrollView.contentOffset
            offset.y = self.scrollView.contentSize.height = self.scrollView.frame.size.height
            self.scrollView.contentOffset = offset
        }
    }
    
    func removeContactBubble(contactBubble: ContactBubble) {
        var contact = self.contactForContactBubble(contactBubble)
        if (contact == nil) {
            return
        }
        
        if self.delegate.respondsToSelector: Sel
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        self.textView.hidden = false
        if ( text == "\n"] ) {
            return true
        }
        
        // Capture "delete" key press when cell is empty
        if (textView.text == "" && text == "") {
            // If no contacts are selected, select the last contact
            self.selectedContactBubble = self.contacts.objectForKey(self.contactKeys.lastObject)
            self.selectedContactBubble.select()
        }
        
        return true
    }
        
        
    func textViewDidChange(textView: UITextView) {
        if (self.delegate.respondsToSelector(Selector(ContactPickerTextViewDidChange))) {
            self.delegate.contactPickerTextViewDidChange(textView.text)
        }
        if (textView.text == "" && self.contacts.count == 0) {
            self.placeholderLabel.hidden = false
        } else {
            self.placeholderLabel.hidden = true
        }
    }
    
    // layout view
    
    
    func layoutView() {
        var frameOfLastBubble = CGRectNull
        var lineCount = 0
        
        for var contactKey in self.contactKeys) {
            var contactBubble = ContactBubble(self.contacts.objectForKey(contactKey))
            var frame = contactBubble.frame
            
            if (CGRectNull(frameOfLastBubble)) {
                bubbleFrame.origin.x = kHorizontalPadding
                bubbleFrame.origin.y = kVerticalPadding + self.viewPadding
            
            
            } else {
                var width = bubbleFrame.size.width + 2 * kHorizontalPadding
            }
            
            if (self.frame.size.width - frameOfLastBubble.origin.x - frameOfLastBubble.size.width - width >= 0) {
                bubbleFrame.origin.x = frameOfLastBubble.origin.x + frameOfLastBubble.size.width + kHorizontalPadding * 2
                bubbleFrame.origin.y = frameOfLastBubble.origin.y;
            } else {
                lineCount++;
                bubbleFrame.origin.x = kHorizontalPadding;
                bubbleFrame.origin.y = (lineCount * self.lineHeight) + kVerticalPadding + 	self.viewPadding;
            }
            
            var frameOfLastBubble = bubbleFrame
            var contactBubble.frame = bubbleFrame
            
            if (contactBubble.superview == nil) {
                self.scrollView.addSubview(contactBubble)
            }
   
    
    // Now add a textView after the comment bubbles
    CGFloat minWidth = kTextViewMinWidth + 2 * kHorizontalPadding;
    CGRect textViewFrame = CGRectMake(0, 0, self.textView.frame.size.width, self.lineHeight/* - 2 * kVerticalPadding*/);
    // Check if we can add the text field on the same line as the last contact bubble
    if (self.frame.size.width - frameOfLastBubble.origin.x - frameOfLastBubble.size.width - minWidth >= 0){ // add to the same line
    textViewFrame.origin.x = frameOfLastBubble.origin.x + frameOfLastBubble.size.width + kHorizontalPadding;
    textViewFrame.size.width = self.frame.size.width - textViewFrame.origin.x;
    } else { // place text view on the next line
    lineCount++;
    
    textViewFrame.origin.x = kHorizontalPadding;
    textViewFrame.size.width = self.frame.size.width - 2 * kHorizontalPadding;
    
    if (self.contacts.count == 0){
    lineCount = 0;
    textViewFrame.origin.x = kHorizontalPadding;
    }
    }
    textViewFrame.origin.y = lineCount * self.lineHeight + kVerticalPadding + self.viewPadding;
    self.textView.frame = textViewFrame;
    
    // Add text view if it hasn't been added
    if (self.textView.superview == nil){
    [self.scrollView addSubview:self.textView];
    }
    
    // Hide the text view if we are limiting number of selected contacts to 1 and a contact has already been added
    if (self.limitToOne && self.contacts.count >= 1){
    self.textView.hidden = YES;
    lineCount = 0;
    }
    
    // Adjust scroll view content size
    CGRect frame = self.bounds;
    CGFloat maxFrameHeight = 2 * self.lineHeight + 2 * self.viewPadding; // limit frame to two lines of content
    CGFloat newHeight = (lineCount + 1) * self.lineHeight + 2 * self.viewPadding;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, newHeight);
    
    // Adjust frame of view if necessary
    newHeight = (newHeight > maxFrameHeight) ? maxFrameHeight : newHeight;
    if (self.frame.size.height != newHeight){
    // Adjust self height
    CGRect selfFrame = self.frame;
    selfFrame.size.height = newHeight;
    self.frame = selfFrame;
    
    // Adjust scroll view height
    frame.size.height = newHeight;
    self.scrollView.frame = frame;
    
    if ([self.delegate respondsToSelector:@selector(contactPickerDidResize:)]){
    [self.delegate contactPickerDidResize:self];
    }
    }
    
    // Show placeholder if no there are no contacts
    if (self.contacts.count == 0){
    self.placeholderLabel.hidden = NO;
    } else {
    self.placeholderLabel.hidden = YES;
    }
    }

    
    // contactBubble delegate
    
    func contactBubbleWasSelected(contactBubble: ContactBubble) {
        if (self.selectedContactBubble != nil) {
            self.selectedContactBubble.unSelect()
        }
        self.selectedContactBubble = contactBubble
    
        self.textView resignFirstResponder()
        self.textView.text = ""
        self.textView.hidden = false
    }
    
    func contactBubbleWasUnSelected(contactBubble: ContactBubble ) {
        if (self.selectedContactBubble != nil){
    
        }
        self.textView becomeFirstResponder()
        self.textView.text = ""
        self.textView.hidden = false
    }
    
    func contactBubbleShouldBeRemoved(contactBubble: ContactBubble) {
        self.removeContactBubble(contactBubble)
    }
    
    // gesture
    
    func handleTapGesture() {
        if (self.limitToOne && self.contactKeys.count == 1){
            return
        }
        self.scrollToBottomWithAnimation(true)
    
        // Show textField
        self.textView.hidden = false
        self.textView.becomeFirstResponder()
    
        // Unselect contact bubble
        self.selectedContactBubble.unSelect()
        self.selectedContactBubble = nil
    }
    
    // scroll view
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if (_shouldSelectTextView){
            _shouldSelectTextView = false
            self.selectTextView
        }
    }
        

    

}
