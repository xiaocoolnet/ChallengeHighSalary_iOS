//
//  CHSMiHomeTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/19.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiHomeTableViewCell: UITableViewCell {
    
    let titImage = UIButton()
    let titLab = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        titImage.frame = CGRectMake(10, 10, 30, 30)
        titImage.backgroundColor = UIColor.grayColor()
        titLab.frame = CGRectMake(57, 10, screenSize.width-60, 30)
        titLab.font = UIFont.systemFontOfSize(18)
        
        self.addSubview(titImage)
        self.addSubview(titLab)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
