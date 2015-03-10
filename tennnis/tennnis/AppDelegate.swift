//  AppDelegate.swift
//  Created by Justin Lynch on 3/9/15.
//  Copyright (c) 2015 jlynch.co. All rights reserved.

import UIKit
import Fabric
import TwitterKit

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // setup fabric, parse, and other 3rd party credentials
        Fabric.with([Twitter()])
        var mainVC = self.setupMainVC()
        
        window!.tintColor = UIColor.Flat.red
        window!.backgroundColor = UIColor.Flat.white
        window!.rootViewController = mainVC
        window!.makeKeyAndVisible()
        
        return true
    }
    
    func setupMainVC() -> UITabBarController {
        // mainVC
        let firstV : UIViewController = LandingVC()
        let secondV : UIViewController = LandingVC()
        let thirdV : UIViewController = LandingVC()
        let forthV : UIViewController = LandingVC()
        let fifthV : UIViewController = LandingVC()
        
        firstV.title = "Teams"
        secondV.title = "Players"
        thirdV.title = "Match Up"
        forthV.title = "Tools"
        fifthV.title = "Profile"
        
        let naviV1 : UINavigationController = UINavigationController(rootViewController: firstV)
        let naviV2 : UINavigationController = UINavigationController(rootViewController: secondV)
        let naviV3 : UINavigationController = UINavigationController(rootViewController: thirdV)
        let naviV4 : UINavigationController = UINavigationController(rootViewController: forthV)
        let naviV5 : UINavigationController = UINavigationController(rootViewController: fifthV)
        
        let tabbarCon : UITabBarController = UITabBarController()
        let tabBar = UITabBar(frame: CGRect(origin: CGPoint(x: 0,y: 0), size: CGSize(width: screenWidth, height: 60)))
        let arrV : NSArray = NSArray(objects: naviV1,naviV2,naviV3,naviV4,naviV5)
        tabbarCon.tabBar.translucent = false
        tabbarCon.setViewControllers(arrV, animated: true)
        
        var item1 : UITabBarItem = tabbarCon.tabBar.items?[0] as UITabBarItem
        var item2 : UITabBarItem = tabbarCon.tabBar.items?[1] as UITabBarItem
        var item3 : UITabBarItem = tabbarCon.tabBar.items?[2] as UITabBarItem
        var item4 : UITabBarItem = tabbarCon.tabBar.items?[3] as UITabBarItem
        var item5 : UITabBarItem = tabbarCon.tabBar.items?[4] as UITabBarItem
        
        
        let home : UIImage = UIImage(text: "\u{e078}", font: iconicFont!, color: UIColor.Tennnis.backgroundBlue, backgroundColor: UIColor.clearColor(), size: CGSize(width: 48.0, height: 48.0), offset: CGPoint(x: 0, y: 12))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
        let users : UIImage = UIImage(text: "\u{e0a4}", font: iconicFont!, color: UIColor.Tennnis.backgroundBlue, backgroundColor: UIColor.clearColor(), size: CGSize(width: 48.0, height: 48.0), offset: CGPoint(x: 0, y: 12))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
        let post : UIImage = UIImage(text: "\u{e020}", font: iconicFont!, color: UIColor.Tennnis.backgroundBlue, backgroundColor: UIColor.clearColor(), size: CGSize(width: 48.0, height: 48.0), offset: CGPoint(x: 0, y: 12))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
        let messages : UIImage = UIImage(text: "\u{e0bc}", font: iconicFont!, color: UIColor.Tennnis.backgroundBlue, backgroundColor: UIColor.clearColor(), size: CGSize(width: 48.0, height: 48.0), offset: CGPoint(x: 0, y: 12))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
        let profile : UIImage = UIImage(text: "\u{e0a5}", font: iconicFont!, color: UIColor.Tennnis.backgroundBlue, backgroundColor: UIColor.clearColor(), size: CGSize(width: 48.0, height: 48.0), offset: CGPoint(x: 0, y: 12))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
        
        let home2 : UIImage = UIImage(text: "\u{e078}", font: iconicFont!, color: UIColor.whiteColor(), backgroundColor: UIColor.clearColor(), size: CGSize(width: 48.0, height: 48.0), offset: CGPoint(x: 0, y: 12))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
        let users2 : UIImage = UIImage(text: "\u{e0a4}", font: iconicFont!, color: UIColor.whiteColor(), backgroundColor: UIColor.clearColor(), size: CGSize(width: 48.0, height: 48.0), offset: CGPoint(x: 0, y: 12))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
        let post2 : UIImage = UIImage(text: "\u{e020}", font: iconicFont!, color: UIColor.whiteColor(), backgroundColor: UIColor.clearColor(), size: CGSize(width: 48.0, height: 48.0), offset: CGPoint(x: 0, y: 12))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
        let messages2 : UIImage = UIImage(text: "\u{e0bc}", font: iconicFont!, color: UIColor.whiteColor(), backgroundColor: UIColor.clearColor(), size: CGSize(width: 48.0, height: 48.0), offset: CGPoint(x: 0, y: 12))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
        let profile2 : UIImage = UIImage(text: "\u{e0a5}", font: iconicFont!, color: UIColor.whiteColor(), backgroundColor: UIColor.clearColor(), size: CGSize(width: 48.0, height: 48.0), offset: CGPoint(x: 0, y: 12))!.reScale()!.imageWithRenderingMode(.AlwaysOriginal)
        
        item1.image = home
        item2.image = users
        item3.image = post
        item4.image = messages
        item5.image = profile
        
        item1.selectedImage = home2
        item2.selectedImage = users2
        item3.selectedImage = post2
        item4.selectedImage = messages2
        item5.selectedImage = profile2
        
        let font:UIFont! = UIFont(name:"HelveticaNeue-Bold",size:10)
        let selectedAttributes:NSDictionary! = [NSFontAttributeName:font,NSForegroundColorAttributeName:UIColor.Tennnis.green, NSBackgroundColorAttributeName:UIColor.Tennnis.green]
        UITabBar.appearance().shadowImage? = UIImage(color: UIColor.whiteColor(), size: CGSize(width: screenWidth, height: 60.0))!
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, forState: UIControlState.Selected)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, forState: UIControlState.Normal)
        UITabBar.appearance().selectedImageTintColor = UIColor.whiteColor()
        
        return tabbarCon
    }

    func applicationWillResignActive(application: UIApplication) {
    }
    func applicationDidEnterBackground(application: UIApplication) {
    }
    func applicationWillEnterForeground(application: UIApplication) {
    }
    func applicationDidBecomeActive(application: UIApplication) {
    }
    func applicationWillTerminate(application: UIApplication) {
    }

}

