//
//  FTMiMyBlacklistTableViewCell.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/9/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMiMyBlacklistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cancelBlacklistBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cancelBlacklistBtn.layer.borderColor = baseColor.CGColor
        cancelBlacklistBtn.layer.borderWidth = 1
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
