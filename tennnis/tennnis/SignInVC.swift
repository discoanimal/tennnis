//  SignInVC.swift
//  Created by Justin Lynch on 3/9/15.
//  Copyright (c) 2015 jlynch.co. All rights reserved.

import UIKit

protocol SignInVCDelegate : class {
    func acceptData(data: AnyObject!)
}

class SignInVC: UIViewController {
    
    var data : AnyObject?
    weak var delegate : SignInVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpButtons()
        view.backgroundColor = UIColor.Flat.orange

    }
    
    func setUpButtons() {
        var button = UIButton(frame: CGRectMake(0, screenHeight - navHeight - bHeight, screenWidth, bHeight))
        button.titleLabel!.font = midFont
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.tintColor = UIColor.blackColor()
        button.backgroundColor = UIColor.whiteColor()
        button.setTitle("Sign In", forState: UIControlState.Normal)
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
            self.delegate?.acceptData("Data From Sign In VC")
        }
    }

    func dismiss(sender:AnyObject?) {
        let hasActiveSessionKey = "has_active_session"
        Defaults[hasActiveSessionKey] = true
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }


}
