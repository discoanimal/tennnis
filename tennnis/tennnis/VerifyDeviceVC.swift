//  VerifyDeviceVC.swift
//  Created by Justin Lynch on 3/9/15.
//  Copyright (c) 2015 jlynch.co. All rights reserved.

import UIKit
import TwitterKit
import Parse

protocol VerifyDeviceVCDelegate : class {
    func acceptData(data: AnyObject!)
}

class VerifyDeviceVC: UIViewController {
    
    var data : AnyObject?
    weak var delegate : VerifyDeviceVCDelegate?
    var nextButton : UIButton?
    var signOutButton : UIButton?
    var verifyButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
        setUpLabels()
        setUpLogo()
        view.backgroundColor = UIColor.Tennnis.backgroundBlue
    }
    
    func setUpLabels() {
        var label = UILabel(frame: CGRectMake(0, screenHeight / 2 - bHeight, screenWidth, bHeight))
        label.text = "Verify Device"
        label.textColor = UIColor.whiteColor()
        label.font = labelFont
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = .Center
        self.view.addSubview(label)
    }
    
    func setUpLogo() {
        let logo : UIImage = UIImage(text: "\u{f023}", font: awesomeBigFont!, color: UIColor.Tennnis.green, backgroundColor: UIColor.clearColor(), size: CGSize(width: 100.0, height: 100.0), offset: CGPoint(x: 0, y: 0))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
        var logoImage = UIImageView(image: logo)
        logoImage.center = CGPoint(x: screenWidth / 2, y: screenHeight / 2 - bHeight)
        self.view.addSubview(logoImage)
    }
    
    func setUpButton() {
        verifyButton = UIButton(frame: CGRectMake(0, screenHeight - bHeight, screenWidth, bHeight))
        verifyButton!.titleLabel!.font = midFont
        verifyButton!.setTitleColor(UIColor.Tennnis.backgroundBlue, forState: UIControlState.Normal)
        verifyButton!.tintColor = UIColor.blackColor()
        verifyButton!.backgroundColor = UIColor.whiteColor()
        verifyButton!.setTitle("Verify Device", forState: UIControlState.Normal)
        verifyButton!.addTarget(self, action: "didTapButton:", forControlEvents:.TouchUpInside)
        self.view.addSubview(verifyButton!)
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

    
    func hideButton(button: UIButton) {
        button.hidden = true
    }
    
    func showButton(button: UIButton) {
        button.hidden = false
    }

    
    func setUpSignOutButton() {
        signOutButton = UIButton(frame: CGRectMake(0, screenHeight / 3, screenWidth, bHeight))
        signOutButton!.titleLabel!.font = midFont
        signOutButton!.setTitleColor(UIColor.Tennnis.backgroundBlue, forState: UIControlState.Normal)
        signOutButton!.tintColor = UIColor.blackColor()
        signOutButton!.backgroundColor = UIColor.whiteColor()
        signOutButton!.setTitle("Drop Creds", forState: UIControlState.Normal)
        signOutButton!.backgroundColor = UIColor.whiteColor()
        signOutButton!.addTarget(self, action: "logOut:", forControlEvents:.TouchUpInside)
        self.view.addSubview(signOutButton!)
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
            self.delegate?.acceptData("Data From Verify Device VC")
        }
    }
    
    func didTapButton(sender: AnyObject) {
        let digitsAppearance = DGTAppearance()
        digitsAppearance.backgroundColor = UIColor.Tennnis.backgroundBlue
        digitsAppearance.accentColor = UIColor.Tennnis.green
        
        let digits = Digits.sharedInstance()
        digits.authenticateWithDigitsAppearance(digitsAppearance, viewController: self, title: "") { (session, error) in
            
            if error == nil {
                self.hideButton(self.verifyButton!)
                self.setUpSignOutButton()
                self.setUpNext()
                println(session.userID)
                println(session.phoneNumber)
                println(session.authToken)
                println(session.authTokenSecret)
                Defaults["digits_UserID"] = session.userID
                Defaults["digits_PhoneNumber"] = session.phoneNumber
                Defaults["digits_AuthToken"] = session.authToken
                Defaults["digits_AuthTokenSecret"] = session.authTokenSecret
            } else {
                println(error)
            }
            
        }

    }
    
    
    
//    func getDigitsAuthInfo(success:((info:AnyObject)->()), failure:((error:AnyObject) ->())) {
//        let digitsAppearance = DGTAppearance()
//        digitsAppearance.backgroundColor = UIColor.Tennnis.backgroundBlue
//        digitsAppearance.accentColor = UIColor.Tennnis.green
//        
//        let digits = Digits.sharedInstance()
//        digits.authenticateWithDigitsAppearance(digitsAppearance, viewController: self, title: "",  completion: { (session, error) in
//            if (error == nil) {
//                let sessionDict = NSMutableDictionary(capacity: 8)
//                let oauthSigning = TWTROAuthSigning(authConfig: Twitter.sharedInstance().authConfig, authSession: session)
//                let authHeaders = oauthSigning.OAuthEchoHeadersToVerifyCredentials()
//                let requestURLString: AnyObject? = authHeaders[TWTROAuthEchoRequestURLStringKey]
//                let authorizationHeader: AnyObject? = authHeaders[TWTROAuthEchoAuthorizationHeaderKey]
//                sessionDict["requestURLString"] = requestURLString
//                sessionDict["userID"] = session.userID
//                sessionDict["phoneNumber"] = session.phoneNumber
//                
//                success(info: sessionDict)
//                
//            } else {
//                failure(error:error)
//            }
//        })
//    }
    
    func logOut(sender: AnyObject?) {
        let digits = Digits.sharedInstance()
        digits.logOut()
        self.hideButton(self.nextButton!)
        self.hideButton(self.signOutButton!)
        self.showButton(self.verifyButton!)
    }

    func dismiss(sender:AnyObject?) {
        
        // just proving it works
        // self.dismissViewControllerAnimated(true, completion: nil)
        // vc.dismissViewControllerAnimated(true, completion: nil)
        // return;
        
        let hasVerifiedDeviceKey = "has_verified_device"
        Defaults[hasVerifiedDeviceKey] = true
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
