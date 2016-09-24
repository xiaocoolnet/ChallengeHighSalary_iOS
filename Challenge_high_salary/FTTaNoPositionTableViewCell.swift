//
//  FTTaNoPositionTableViewCell.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/8.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaNoPositionTableViewCell: UITableViewCell {

    let publishJobBtn = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubviews() {
        
        self.contentView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height-64-37-49)
        
        // 图
        let imgV = UIImageView(frame: CGRectMake(0, screenSize.height*0.15, screenSize.width*0.267, screenSize.width*0.267*1.4))
        imgV.backgroundColor = UIColor.cyanColor()
        imgV.center.x = self.contentView.center.x
        self.contentView.addSubview(imgV)
        
        // 空空如也 label
        let nothingLab = UILabel(frame: CGRectMake(0, CGRectGetMaxY(imgV.frame)+kHeightScale*25, 30, 35))
        nothingLab.font = UIFont.systemFontOfSize(16)
        nothingLab.text = "空空如也~"
        nothingLab.sizeToFit()
        nothingLab.center.x = self.contentView.center.x
        nothingLab.frame.origin.y = CGRectGetMaxY(imgV.frame)+kHeightScale*25
        self.contentView.addSubview(nothingLab)
        
        // 发布职位 Button
        publishJobBtn.frame = CGRectMake((screenSize.width-kWidthScale*270)/2.0, CGRectGetMaxY(nothingLab.frame)+kHeightScale*100, kWidthScale*270, kHeightScale*40)
        publishJobBtn.backgroundColor = baseColor
        publishJobBtn.layer.cornerRadius = 6
        publishJobBtn.setTitle("发布职位", forState: .Normal)
        self.contentView.addSubview(publishJobBtn)
        
        // 提示 label
        let tipLabel = UILabel(frame: CGRectMake(0, 0, 20, 25))
        tipLabel.textColor = UIColor(red: 136/255.0, green: 136/255.0, blue: 136/255.0, alpha: 1)
        tipLabel.font = UIFont.systemFontOfSize(13)
        tipLabel.text = "发布职位后 会为您推荐最合适的人才"
        tipLabel.sizeToFit()
        tipLabel.center.x = self.contentView.center.x
        tipLabel.frame.origin.y = CGRectGetMaxY(publishJobBtn.frame)+5
        self.contentView.addSubview(tipLabel)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
