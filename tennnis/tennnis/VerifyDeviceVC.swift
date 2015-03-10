//  VerifyDeviceVC.swift
//  Created by Justin Lynch on 3/9/15.
//  Copyright (c) 2015 jlynch.co. All rights reserved.

import UIKit
import TwitterKit

protocol VerifyDeviceVCDelegate : class {
    func acceptData(data: AnyObject!)
}

class VerifyDeviceVC: UIViewController {
    
    var data : AnyObject?
    weak var delegate : VerifyDeviceVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
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
    
    func setUpButtons() {
        var button = UIButton(frame: CGRectMake(0, screenHeight - bHeight, screenWidth, bHeight))
        button.titleLabel!.font = midFont
        button.setTitleColor(UIColor.Tennnis.backgroundBlue, forState: UIControlState.Normal)
        button.tintColor = UIColor.blackColor()
        button.backgroundColor = UIColor.whiteColor()
        button.setTitle("Verify Device", forState: UIControlState.Normal)
        button.addTarget(self, action: "didTapButton:", forControlEvents:.TouchUpInside)
        self.view.addSubview(button)
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
                println(session.userID)
                println(session.phoneNumber)
                println(session.authToken)
                println(session.authTokenSecret)
                Defaults["digits_UserID"] = session.userID
                Defaults["digits_UserID"] = session.phoneNumber
                Defaults["digits_UserID"] = session.authToken
                Defaults["digits_UserID"] = session.authTokenSecret
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
    
    func logout() {
        Digits.sharedInstance().logOut()
    }

    func dismiss(sender:AnyObject?) {
        
        
//        println(self.presentingViewController!)
//        println(self.presentingViewController!.presentedViewController)
//        var vc = self.delegate! as AnyObject as UIViewController
//        println(vc.presentedViewController)
        
        // just proving it works
        // self.dismissViewControllerAnimated(true, completion: nil)
        // vc.dismissViewControllerAnimated(true, completion: nil)
        // return;
        
        let hasVerifiedDeviceKey = "has_verified_device"
        Defaults[hasVerifiedDeviceKey] = true
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
