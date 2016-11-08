//
//  FTMeHomeTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/8.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMeHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var descriptionLab: UILabel!
    
    @IBOutlet weak var timeLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
