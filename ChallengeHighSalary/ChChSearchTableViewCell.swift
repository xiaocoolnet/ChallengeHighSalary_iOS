//
//  ChChSearchTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/7.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChChSearchTableViewCell: UITableViewCell {

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
        titImage.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
        titImage.backgroundColor = UIColor.gray
        titLab.frame = CGRect(x: 50, y: 10, width: screenSize.width/2, height: 35)
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
