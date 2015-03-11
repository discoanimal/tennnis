//  ContactPickerVC.swift
//  Created by Justin Lynch on 3/11/15.
//  Copyright (c) 2015 jlynch.co. All rights reserved.

import UIKit
import AddressBookUI
import AddressBook


class ContactPickerVC : UIViewController, UITableViewDataSource, UITableViewDelegate, ABPersonViewControllerDelegate, ContactPickerDelegate {
    var barButton : UIBarButtonItem
    var addressBookRef : ABAddressBookRef
    var groups : [SwiftAddressBookGroup]? = []
    var people : [SwiftAddressBookPerson]? = []
    var names : [String?]? = []
    var numbers : [Array<String?>?]? = []
    var birthdates : [NSDate?]? = []
    var tableController : UITableView?
    var tableView: UITableView!
    var data : AnyObject?
    var contactPickerView : ContactPickerView?
    var contacts : NSArray = []
    var selectedContacts : NSMutableArray = []
    var filteredContacts : NSArray = []
    
    
    required init(coder aDecoder: NSCoder) { 
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setUpContentPickerView()
        self.tableView.registerClass(ContactPickerTableViewCell.self, forCellReuseIdentifier: "contactPickerCell")
        self.tableView.rowHeight = 70.0
        
        view.backgroundColor = UIColor.Flat.white
        self.title = "Select Contacts (0)"
        
        swiftAddressBook?.requestAccessWithCompletion { (b :Bool, _ :CFError?) -> Void in
            if b {
                self.people = swiftAddressBook?.allPeople
                
                let sources = swiftAddressBook?.allSources
                println(sources?.description)
//                var mutableContacts : NSMutableArray = NSMutableArray(capacity: self.sources.count)
                
                for source in sources! {
                    //println("\(source.sourceName)") //TODO: This throws an exception
                    let newGroups = swiftAddressBook!.allGroupsInSource(source)!
                    self.groups = self.groups! + newGroups
                }
                
                self.numbers = self.people?.map { (p) -> (Array<String?>?) in
                    return p.phoneNumbers?.map { return $0.value }
                }
                self.names = self.people?.map { (p) -> (String?) in
                    return p.compositeName
                }
                self.birthdates = self.people?.map { (p) -> (NSDate?) in
                    return p.birthday
                }
                
//                self.people.
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
            
        }
    }
    
    func setUpContentPickerView() {
        barButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("done:") )
        barButton.enabled = false
        self.navigationItem.rightBarButtonItem = barButton
        
        contactPickerView = ContactPickerView(frame: CGRectMake(0,0,self.view.frame.size.width, 100))
        

        self.view.addSubview(self.contactPickerView!)
    }
    
    func setupTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.tableView)
        
        let backView = UIView()
        backView.backgroundColor = UIColor.Flat.purple
        self.tableView.backgroundView = backView
    }

    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return groups == nil ? 1 : groups!.count+1
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
//        if groups == nil || section == groups?.count {
//            return people == nil ? 0 : people!.count
//        }
//        else {
//            if let members = groups![section].allMembers {
//                return members.count
//            }
//            else {
//                return 0
//            }
//        }
        return people == nil ? 0 : people!.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("contactPickerCell", forIndexPath: indexPath) as ContactPickerTableViewCell
        
//        if groups == nil || indexPath.section == groups?.count {
        cell.nameLabel.text = people![indexPath.row].compositeName
        cell.nameLabel?.textColor = UIColor.Flat.black
        cell.nameLabel.font = nameCellFont
        
        println(people![indexPath.row].compositeName)
        cell.phoneNumberLabel.text = numbers![indexPath.row]?.first?
        cell.phoneNumberLabel.font = numCellFont
        
        cell.leftImageView?.image = self.setupLeftImage("\u{f1db}")
//        cell.leftImageView?.image = self.setupLeftAltImage("\u{f058}")
        
        cell.bubbleImageView?.image = self.setupBubbleImage("\u{e60e}")
        
        cell.accessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as? UIView
//        }
//        else {
//            cell.nameLabel.text = groups![indexPath.section].allMembers![indexPath.row].compositeName
//            cell.phoneNumberLabel.text = numbers![indexPath.row]?.first?
//            cell.leftImageView?.image = self.setupLeftImage("\u{e086}")
//            cell.bubbleImageView?.image = self.setupBubbleImage("\u{f3a3}")
//        }
        
//        cell.textLabel?.text = people![indexPath.row].compositeName
//        cell.detailTextLabel?.text = numbers![indexPath.row]?.first?
//        cell.textLabel?.textColor = UIColor.Flat.black
//        cell.detailTextLabel?.textColor = UIColor.Flat.black
        
        return cell
    }
    
    func setupLeftImage(shortCode: String ) -> UIImage {
        return UIImage(text: shortCode, font: awesomeBigFont!, color: UIColor.Flat.gray, backgroundColor: UIColor.clearColor(), size: CGSize(width: 50.0, height: 50.0), offset: CGPoint(x: 0, y: 0))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
    }
    
    func setupLeftAltImage(shortCode: String ) -> UIImage {
        return UIImage(text: shortCode, font: awesomeBigFont!, color: UIColor.Flat.green, backgroundColor: UIColor.clearColor(), size: CGSize(width: 50.0, height: 50.0), offset: CGPoint(x: 0, y: 0))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
    }
    
    func setupBubbleImage(shortCode: String ) -> UIImage {
        return UIImage(text: shortCode, font: gFont2!, color: UIColor.Material.indigo, backgroundColor: UIColor.clearColor(), size: CGSize(width: 90.0, height: 90.0), offset: CGPoint(x: 0, y: 0))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
    }

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if groups == nil || section == groups?.count {
            return "All people"
        }
        else {
            return groups![section].name
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.contactPickerView?.resignFirstResponder()
        
        println(indexPath.row)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var cell = self.tableView.cellForRowAtIndexPath(indexPath) as ContactPickerTableViewCell
        
        var user = self.filteredContacts.objectAtIndex(indexPath.row)
        
        if (self.selectedContacts.containsObject(user)) {
            self.selectedContacts.removeObject(user)
            self.contactPickerView.removeContact(user)
            cell.leftImageView?.image = self.setupLeftAltImage("\u{f058}")
        } else {
            self.selectedContacts.addObject(user)
            self.contactPickerView.addContact(user, withName: user.fullName)
            cell.leftImageView?.image = self.setupLeftAltImage("\u{f058}")
        }
        
        println(cell.nameLabel?.text)
        
        if (self.selectedContacts.count > 0) {
            barButton.enabled = true
        } else {
            barButton.enabled = false
        }
        
        var forTitle = self.selectedContacts.count
        self.title = "Add Members (\(forTitle))"
        self.filteredContacts = self.contacts
        self.tableView.reloadData()

    }
    
    // Contact Picker Delegate
    
    func contactPickerTextViewDidChange(textViewText: NSString!) {
        if (textViewText == "") {
            self.filteredContacts = self.contacts
        } else {
            
            var predicate = NSPredicate(format: "self.contains or", textViewText)
            self.filteredContacts = self.contacts.filteredArrayUsingPredicate(predicate!)
            
        }
    }
    
    
    func contactPickerDidResize(textViewText: ContactPickerView!) {
        self.adjustTableViewFrame = true
    }
    
    
    func contactPickerDidRemoveContact(contact: AnyObject!) {
        self.selectedContacts.removeObject(contact)
        
        var index = self.contacts.indexOfObject(contact)
        var cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as ContactPickerTableViewCell
        
        if (self.selectedContacts.count > 0) {
            barButton.enabled = true
        } else {
            barButton.enabled = false
        }
        
        cell.leftImageView?.image = self.setupLeftImage("\u{f1db}")
        var forTitle = self.selectedContacts.count
        self.title = "Add Members (\(forTitle))"
    }

    
    func removeAllContacts(sender: AnyObject) {
        self.contactPickerView?.removeFromSuperview()
        self.selectedContacts.removeAllObjects()
        self.filteredContacts = self.contacts
        self.tableView.reloadData()
    }
    
    //ABA delegate
    
    func personViewController(personViewController: ABPersonViewController!, shouldPerformDefaultActionForPerson person: ABRecord!, property: ABPropertyID, identifier: ABMultiValueIdentifier) -> Bool {
        return true
    }
    
    func done(sender: AnyObject) {
        var alertView = UIAlertView(title: "Done", message: "Now DO sppmething", delegate: nil, cancelButtonTitle: "OK")
        alertView.show
    }
}
