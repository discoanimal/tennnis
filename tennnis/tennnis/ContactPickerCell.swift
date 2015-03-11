//  ContactPickerCell.swift
//  Created by Justin Lynch on 3/11/15.
//  Copyright (c) 2015 jlynch.co. All rights reserved.

import UIKit

class ContactPickerCell: UITableViewCell {
    var leftImage : UIImage?
    var leftImageView : UIImageView?
    var bubbleImage : UIImage?
    var bubbleImageView : UIImageView?
    var nameLabel : UILabel!
    var phoneNumberLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func commonSetup() {
        let height = CGFloat(70)
        let padding = CGFloat(10)
        let imgSize = CGFloat(25)
        let img2Size = CGFloat(50)
        leftImageView = UIImageView(frame: CGRectMake(padding + (padding / 4), ( height - imgSize ) / 2 , imgSize, imgSize))
        leftImageView?.backgroundColor = UIColor.clearColor()
        leftImageView?.image = leftImage?
        bubbleImageView = UIImageView(frame: CGRectMake(padding + imgSize + padding + padding, ( height - img2Size ) / 2, img2Size, img2Size))
        bubbleImageView?.backgroundColor = UIColor.clearColor()
        bubbleImageView?.image = bubbleImage?
        nameLabel = UILabel(frame: CGRectMake(5 * padding + imgSize + img2Size, padding + ( padding / 2 ), screenWidth - img2Size - imgSize - 4 * padding , 2 * padding ))
        nameLabel.textColor = UIColor.blackColor()
        phoneNumberLabel = UILabel(frame: CGRectMake(5 * padding + imgSize + img2Size, 3 * padding + ( padding / 2 ) , screenWidth - img2Size - imgSize - 4 * padding , 2 * padding ))
        phoneNumberLabel.textColor = UIColor.blackColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.addSubview(leftImageView!)
        self.contentView.addSubview(bubbleImageView!)
        self.contentView.addSubview(nameLabel!)
        self.contentView.addSubview(phoneNumberLabel!)
    }
    
}
