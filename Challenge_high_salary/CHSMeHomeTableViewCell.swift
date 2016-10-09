//
//  CHSMeHomeTableViewCell.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/10/9.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMeHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImg: UIImageView!
    
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var descriptionLab: UILabel!
    
    @IBOutlet weak var timeLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
