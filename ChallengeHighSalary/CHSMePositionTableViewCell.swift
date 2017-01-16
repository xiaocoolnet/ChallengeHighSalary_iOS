//
//  CHSMePositionTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by 沈晓龙 on 2017/1/3.
//  Copyright © 2017年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMePositionTableViewCell: UITableViewCell {
    
    let backView = UIView()
    let titLab = UILabel()
    let conLab = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backView.frame = CGRect(x: 13, y: 0, width: screenSize.width - 26, height: 49.5)
        backView.backgroundColor = UIColor.white
        self.contentView.addSubview(backView)
        
        titLab.frame = CGRect(x: 10, y: 0, width: 80, height: 40)
        titLab.font = UIFont.systemFont(ofSize: 16)
        
        backView.addSubview(titLab)
        
        conLab.frame = CGRect(x: 100, y: 0, width: screenSize.width-136, height: 49)
        conLab.textAlignment = .right
        conLab.textColor = UIColor.lightGray
        conLab.font = UIFont.systemFont(ofSize: 15)
        backView.addSubview(conLab)
     
        let line = UILabel.init(frame: CGRect(x: 0, y: 49, width: screenSize.width - 26, height: 1))
        line.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        backView.addSubview(line)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
