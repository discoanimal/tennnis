//  SignUpVC.swift
//  Created by Justin Lynch on 3/9/15.
//  Copyright (c) 2015 jlynch.co. All rights reserved.

import UIKit
import Parse
import Foundation

protocol SignUpVCDelegate : class {
    func acceptData(data: AnyObject!)
}

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    var data : AnyObject?
    weak var delegate : SignUpVCDelegate?
    var nextButton : UIButton?
    var signOutButton : UIButton?
    var signUpButton : UIButton?
    var usernameTextField : UITextField?
    var emailTextField : UITextField?
    var passwordTextField : UITextField?
    var label : UILabel?
    
    var newUser = PFUser.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSignUp()
        setUpLabels()
        setUpLogo()
        setUpTextFields()
        view.backgroundColor = UIColor.Flat.blue
        
    }
    
    func setUpTextFields() {
        usernameTextField = UITextField(frame: CGRectMake(0, screenHeight / 6, screenWidth, bHeight))
        emailTextField = UITextField(frame: CGRectMake(0, screenHeight / 6 + bHeight, screenWidth, bHeight))
        passwordTextField = UITextField(frame: CGRectMake(0, screenHeight / 6 + 2 * bHeight, screenWidth, bHeight))
        
        usernameTextField?.backgroundColor = UIColor.whiteColor()
        emailTextField?.backgroundColor = UIColor.whiteColor()
        passwordTextField?.backgroundColor = UIColor.whiteColor()
        
        usernameTextField?.placeholder = "username"
        emailTextField?.placeholder = "email@example.com"
        passwordTextField?.placeholder = "password"
        
        self.view.addSubview(usernameTextField!)
        self.view.addSubview(emailTextField!)
        self.view.addSubview(passwordTextField!)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // adding a dismiss screen from touching anywhere on the screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func hideButton(button: UIButton) {
        button.hidden = true
    }
    
    func showButton(button: UIButton) {
        button.hidden = false
    }
    
    func setUpLabels() {
        label = UILabel(frame: CGRectMake(0, screenHeight / 2 - bHeight, screenWidth, bHeight))
        label!.text = "Sign Up"
        label!.textColor = UIColor.whiteColor()
        label!.font = labelFont
        label!.backgroundColor = UIColor.clearColor()
        label!.textAlignment = .Center
        self.view.addSubview(label!)
    }
    
    func setUpLogo() {
        let logo : UIImage = UIImage(text: "\u{f0c3}", font: awesomeBigFont!, color: UIColor.Tennnis.green, backgroundColor: UIColor.clearColor(), size: CGSize(width: 100.0, height: 100.0), offset: CGPoint(x: 0, y: 0))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
        var logoImage = UIImageView(image: logo)
        logoImage.center = CGPoint(x: screenWidth / 2, y: screenHeight / 2 - bHeight)
        self.view.addSubview(logoImage)
    }
    
    func setUpSignOut() {
        signOutButton = UIButton(frame: CGRectMake(0, bHeight, screenWidth, bHeight))
        signOutButton!.titleLabel!.font = midFont
        signOutButton!.setTitleColor(UIColor.Tennnis.backgroundBlue, forState: UIControlState.Normal)
        signOutButton!.tintColor = UIColor.blackColor()
        signOutButton!.backgroundColor = UIColor.whiteColor()
        signOutButton!.setTitle("Sign Out", forState: UIControlState.Normal)
        signOutButton!.addTarget(self, action: "signOutUser:", forControlEvents:.TouchUpInside)
        self.view.addSubview(signOutButton!)
    }
    
    func setUpNext() {
        nextButton = UIButton(frame: CGRectMake(0, screenHeight - bHeight, screenWidth, bHeight))
        nextButton!.titleLabel!.font = midFont
        nextButton!.setTitleColor(UIColor.Tennnis.backgroundBlue, forState: UIControlState.Normal)
        nextButton!.tintColor = UIColor.blackColor()
        nextButton!.backgroundColor = UIColor.whiteColor()
        nextButton!.setTitle("Next", forState: UIControlState.Normal)
        nextButton!.addTarget(self, action: "dismiss:", forControlEvents:.TouchUpInside)
        self.view.addSubview(nextButton!)
    }
    
    func setUpSignUp() {
        signUpButton = UIButton(frame: CGRectMake(0, screenHeight - bHeight, screenWidth, bHeight))
        signUpButton!.titleLabel!.font = midFont
        signUpButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        signUpButton!.tintColor = UIColor.blackColor()
        signUpButton!.backgroundColor = UIColor.whiteColor()
        signUpButton!.setTitle("Sign Up", forState: UIControlState.Normal)
        signUpButton!.addTarget(self, action: "signUpNewUser:", forControlEvents:.TouchUpInside)
        self.view.addSubview(signUpButton!)

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println(self.data)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isBeingDismissed() {
            self.delegate?.acceptData("Data From Sign Up VC")
        }
    }
    
    func signUpNewUser(sender:AnyObject?) {
        var usrEntered = usernameTextField!.text
        var emlEntered = emailTextField!.text
        var pwdEntered = passwordTextField!.text

        newUser.username = usrEntered
        newUser.email = emlEntered
        newUser.password = pwdEntered
        
        
        
        newUser["digits_UserID"] = Defaults["digits_UserID"].string
        newUser["digits_PhoneNumber"] = Defaults["digits_PhoneNumber"].string
        newUser["digits_AuthToken"] = Defaults["digits_AuthToken"].string
        newUser["digits_AuthTokenSecret"] = Defaults["digits_AuthTokenSecret"].string
        if usrEntered != "" && pwdEntered != "" && emlEntered != "" {
            
            newUser.signUpInBackgroundWithBlock {
                (succeeded: Bool!, error: NSError!) -> Void in
                if error == nil {
                    println("Successfully Signed Up")
                    self.hideButton(self.signUpButton!)
                    self.setUpSignOut()
                    self.setUpNext()
                    self.label!.text = "Hi \(self.newUser.username) you're Signed Up"
                } else {
                    println("Could Not Sign Up")
                    println(error)
                    var alert = UIAlertController(title: "Email Incomplete", message: "Please add a valid email address", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        } else {
            self.label!.text = "All Fields Required"
        }
    }

    
    func dismiss(sender:AnyObject?) {
        signOutUser()
        let hasSignedUpKey = "has_signed_up"
        Defaults[hasSignedUpKey] = true
        let hasActiveSessionKey = "has_active_session"
        Defaults[hasActiveSessionKey] = true
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signOutUser() {
        PFUser.logOut()
        let hasActiveSessionKey = "has_active_session"
        Defaults.remove(hasActiveSessionKey)
        self.hideButton(self.nextButton!)
        self.hideButton(self.signOutButton!)
        self.showButton(self.signUpButton!)
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
}