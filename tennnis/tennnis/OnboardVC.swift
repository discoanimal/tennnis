//  OnboardVC.swift
//  Created by Justin Lynch on 3/9/15.
//  Copyright (c) 2015 jlynch.co. All rights reserved.

import UIKit
import Parse

protocol OnboardVCDelegate : class {
    func acceptData(data: AnyObject!)
}

class OnboardVC: UIViewController {
    
    var data : AnyObject?
    weak var delegate : OnboardVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
        setUpLabels()
        setUpLogo()
        view.backgroundColor = UIColor.Tennnis.green
        
    }
    
    func setUpLabels() {
        var label = UILabel(frame: CGRectMake(0, screenHeight / 2 - bHeight, screenWidth, bHeight))
        label.text = "Onboarding"
        label.textColor = UIColor.whiteColor()
        label.font = labelFont
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = .Center
        self.view.addSubview(label)
    }
    
    func setUpLogo() {
        let logo : UIImage = UIImage(text: "\u{f4bb}", font: ioniconBigFont!, color: UIColor.Tennnis.backgroundBlue, backgroundColor: UIColor.clearColor(), size: CGSize(width: 100.0, height: 100.0), offset: CGPoint(x: 0, y: 0))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
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
        button.setTitle("Get Started", forState: UIControlState.Normal)
        button.addTarget(self, action: "dismiss:", forControlEvents:.TouchUpInside)
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
            self.delegate?.acceptData("Data From Onboard VC")
        }
    }
    
    func dismiss(sender:AnyObject?) {
        let hasOnboardedKey = "has_onboarded"
        Defaults[hasOnboardedKey] = true
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
