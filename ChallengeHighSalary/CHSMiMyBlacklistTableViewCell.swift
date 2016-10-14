//
//  CHSMiMyBlacklistTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/28.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiMyBlacklistTableViewCell: UITableViewCell {

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
