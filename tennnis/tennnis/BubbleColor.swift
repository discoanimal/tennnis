//
//  BubbleColor.swift
//  tennnis
//
//  Created by Justin Lynch on 3/11/15.
//  Copyright (c) 2015 jlynch.co. All rights reserved.
//

import UIKit

class BubbleColor: NSObject {
    var gradientTop = UIColor!
    var gradientBottom = UIColor!
    var border : UIColor!
    
    func initWithGradientTop(gradientTop: UIColor!, gradientBottom: UIColor!, border: UIColor!) -> AnyObject {
        self.gradientTop = gradientTop!
        self.gradientBottom = gradientBottom!
        self.border = border!
        return self
    }
   
}
