//  LandingVC.swift
//  Created by Justin Lynch on 3/9/15.
//  Copyright (c) 2015 jlynch.co. All rights reserved.

import UIKit

class LandingVC: UIViewController, SignInVCDelegate, SignUpVCDelegate, OnboardVCDelegate, VerifyDeviceVCDelegate {
    
    let hasOnboardedKey = "has_onboarded"
    let hasVerifiedDeviceKey = "has_verified_device"
    let hasSignedUpKey = "has_signed_up"
    let hasActiveSessionKey = "has_active_session"
    let sivc = SignInVC()
    let vdvc = VerifyDeviceVC()
    let suvc = SignUpVC()
    let onboardvc = OnboardVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpButtons()
        view.backgroundColor = UIColor.Tennnis.backgroundBlue
        self.navigationController?.navigationBar.hideBottomHairline()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(color: UIColor.Tennnis.green , size: navSize), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.shadowImage = UIImage(color: UIColor.Tennnis.green, size: CGSize(width: 60.0, height: 5.0))
        self.tabBarController?.tabBar.backgroundImage = UIImage(color: UIColor.Tennnis.green, size: CGSize(width: screenWidth, height: 2.0))

    }
    
    override func viewWillAppear(animated: Bool) {
        var attributes = [ NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Avenir", size: 18)! ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        super.viewWillAppear(animated)
        if Defaults.hasKey(hasOnboardedKey) {
            if Defaults.hasKey(hasVerifiedDeviceKey) {
                if Defaults.hasKey(hasSignedUpKey) {
                    if Defaults.hasKey(hasActiveSessionKey) {
                    } else {
                        self.presentSignInVC(self.tabBarController)
                    }
                } else {
                    self.presentSignUpVC(self.tabBarController)
                }
            } else {
                self.presentVerifyDeviceVC(self.tabBarController)
            }
        } else {
            self.presentOnboardVC(self.tabBarController)
        }
    }
    
    func setUpButtons() {
        var removeOnboardButton = UIButton(frame: CGRectMake(0, screenHeight / 4, screenWidth, bHeight))
        var removeVerifyButton = UIButton(frame: CGRectMake(0, screenHeight / 4 + bHeight, screenWidth, bHeight))
        var removeSignUpButton = UIButton(frame: CGRectMake(0, screenHeight / 4 + 2 * bHeight, screenWidth, bHeight))
        var removeSignInButton = UIButton(frame: CGRectMake(0, screenHeight / 4 + 3 * bHeight, screenWidth, bHeight))
        
        removeOnboardButton.titleLabel!.font = midFont
        removeVerifyButton.titleLabel!.font = midFont
        removeSignUpButton.titleLabel!.font = midFont
        removeSignInButton.titleLabel!.font = midFont
        
        removeOnboardButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        removeVerifyButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        removeSignUpButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        removeSignInButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        removeOnboardButton.tintColor = UIColor.blackColor()
        removeVerifyButton.tintColor = UIColor.blackColor()
        removeSignUpButton.tintColor = UIColor.blackColor()
        removeSignInButton.tintColor = UIColor.blackColor()
        
        removeOnboardButton.backgroundColor = UIColor.whiteColor()
        removeVerifyButton.backgroundColor = UIColor.whiteColor()
        removeSignUpButton.backgroundColor = UIColor.whiteColor()
        removeSignInButton.backgroundColor = UIColor.whiteColor()
        
        removeOnboardButton.setTitle("Remove Onboarding", forState: UIControlState.Normal)
        removeVerifyButton.setTitle("Remove Device Verify", forState: UIControlState.Normal)
        removeSignUpButton.setTitle("Remove Sign Up", forState: UIControlState.Normal)
        removeSignInButton.setTitle("Remove Session", forState: UIControlState.Normal)
        
        removeOnboardButton.addTarget(self, action: "removeOB:", forControlEvents:.TouchUpInside)
        removeVerifyButton.addTarget(self, action: "removeVD:", forControlEvents:.TouchUpInside)
        removeSignUpButton.addTarget(self, action: "removeSU:", forControlEvents:.TouchUpInside)
        removeSignInButton.addTarget(self, action: "removeSI:", forControlEvents:.TouchUpInside)
        
        self.view.addSubview(removeOnboardButton)
        self.view.addSubview(removeVerifyButton)
        self.view.addSubview(removeSignUpButton)
        self.view.addSubview(removeSignInButton)
        
    }
    
    func removeOB(sender:AnyObject?) {
        Defaults.remove(hasOnboardedKey)
        self.viewWillAppear(true)
    }
    
    func removeVD(sender:AnyObject?) {
        Defaults.remove(hasVerifiedDeviceKey)
        self.viewWillAppear(true)
    }
    
    func removeSU(sender:AnyObject?) {
        Defaults.remove(hasSignedUpKey)
        self.viewWillAppear(true)
    }
    
    func removeSI(sender:AnyObject?) {
        Defaults.remove(hasActiveSessionKey)
        self.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)!) {
        println("here") // prove that this is called by clicking on curl
        super.dismissViewControllerAnimated(flag, completion: completion)
    }
    
    func presentSignInVC(sender:AnyObject?) {
        
        sivc.data = "Data for Sign In VC From Landing VC"
        sivc.delegate = self
        sivc.modalTransitionStyle = .CoverVertical
        sivc.modalPresentationStyle = .FormSheet
        sender!.presentViewController(sivc, animated:true, completion:nil)
    }
    
    func presentVerifyDeviceVC(sender:AnyObject?) {
        
        vdvc.data = "Data for Verify Device VC From Landing VC"
        vdvc.delegate = self
        vdvc.modalTransitionStyle = .CoverVertical
        vdvc.modalPresentationStyle = .FormSheet
        sender!.presentViewController(vdvc, animated:true, completion:nil)
    }
    
    func presentSignUpVC(sender:AnyObject?) {
        
        suvc.data = "Data for Sign Up VC From Landing VC"
        suvc.delegate = self
        suvc.modalTransitionStyle = .CoverVertical
        suvc.modalPresentationStyle = .FormSheet
        sender!.presentViewController(suvc, animated:true, completion:nil)
    }
    
    func presentOnboardVC(sender:AnyObject?) {
        
        onboardvc.data = "Data for Onboard VC From Landing VC"
        onboardvc.delegate = self
        sender!.presentViewController(onboardvc, animated:true, completion:nil)
    }

    func acceptData(data:AnyObject!) {
        println(data)
    }

}
