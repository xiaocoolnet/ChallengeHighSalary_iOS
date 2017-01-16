//
//  FTMeSysMessageTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/8.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMeSysMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var readAllLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        self.bounds.size.height = CGRectGetMaxY(readAllLab.frame)+8
    }
    
//    func getCellHeight() -> CGFloat {
//        
//        return CGRectGetMaxY(readAllLab.frame)+8
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
