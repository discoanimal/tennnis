//  Constants.swift - SwiftMaster
//  Copyright (c) 2015 jlynch.co. All rights reserved.

import Foundation
import UIKit

// General
let origin = CGPoint(x: 0.0, y: 0.0)
let screenSize: CGRect = UIScreen.mainScreen().bounds
let screenRect = screenSize
let screenWidth = screenSize.width
let screenHeight = screenSize.height

// Navigation Bar
let navHeight = CGFloat(64.0)
let navSize = CGSize(width: screenWidth, height: navHeight)
let navRect = CGRectMake(origin.x, origin.y, navSize.width, navSize.height)

// Fonts
let numCellFont = UIFont (name: "HelveticaNeue", size: 14)
let nameCellFont = UIFont (name: "HelveticaNeue-Bold", size: 16)
let lightFont = UIFont (name: "HelveticaNeue-UltraLight", size: 20)
let lightFontBig = UIFont (name: "HelveticaNeue-UltraLight", size: 24)
let midFont = UIFont (name: "Avenir-Medium", size: 20)
let boldFont = UIFont (name: "AvenirNext-Bold", size: 20)
let labelFont = UIFont(name: "AlNile-Bold", size: 30)

// Icon Fonts
let iconFont = UIFont(name: "FontAwesome", size: 30.0)
let awesomeBigFont = UIFont(name: "FontAwesome", size: 50.0)
let gFont = UIFont(name: "googleicon", size: 30.0)
let gFont2 = UIFont(name: "googleicon", size: 90.0)

let ioniconFont = UIFont(name: "ionicons", size: 40.0)
let ioniconBigFont = UIFont(name: "ionicons", size: 50.0)
let iconicSmallFont = UIFont(name: "open-iconic", size: 14.0)
let iconicFont = UIFont(name: "open-iconic", size: 24.0)
let iconic50Font = UIFont(name: "open-iconic", size: 50.0)
let iconic80Font = UIFont(name: "open-iconic", size: 70.0)
let iconicBigFont = UIFont(name: "open-iconic", size: 40.0)
let iconicHugeFont = UIFont(name: "open-iconic", size: 120.0)
let octiconFont = UIFont(name: "octicons", size: 30.0)

// Buttons
let bHeight = CGFloat(60.0)
