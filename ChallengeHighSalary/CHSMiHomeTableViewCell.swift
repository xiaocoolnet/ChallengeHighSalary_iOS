//
//  CHSMiHomeTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/19.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiHomeTableViewCell: UITableViewCell {
    
    let titImage = UIImageView()
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
        titImage.frame = CGRect(x: 10, y: 15, width: 20, height: 20)
        titImage.contentMode = .scaleAspectFit
//        titImage.backgroundColor = UIColor.grayColor()
        titLab.frame = CGRect(x: 48, y: 10, width: screenSize.width-60, height: 30)
        titLab.font = UIFont.systemFont(ofSize: 18)
        
        self.addSubview(titImage)
        self.addSubview(titLab)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
