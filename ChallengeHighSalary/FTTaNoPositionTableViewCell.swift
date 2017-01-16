//
//  FTTaNoPositionTableViewCell.swift
//  ChallengeHighSalary
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
        
        self.contentView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-64-37-49)
        
        // 图
        let imgV = UIImageView(frame: CGRect(x: 0, y: screenSize.height*0.1, width: screenSize.width*0.4, height: screenSize.height*0.4))
//        imgV.backgroundColor = UIColor.cyan
        imgV.contentMode = .scaleAspectFit
        imgV.image = #imageLiteral(resourceName: "ic_FT_无职位背景图")
        imgV.center.x = self.contentView.center.x
        self.contentView.addSubview(imgV)
        
        // 无职位 文字 label
        let nothingTextImg = UIImageView(frame: CGRect(x: 0, y: imgV.frame.maxY, width: screenSize.width*0.4, height: 30))
        //        imgV.backgroundColor = UIColor.cyan
        nothingTextImg.contentMode = .scaleAspectFit
        nothingTextImg.image = #imageLiteral(resourceName: "ic_FT_无职位文字")
        nothingTextImg.center.x = self.contentView.center.x
        self.contentView.addSubview(nothingTextImg)
        // 空空如也 label
//        let nothingLab = UILabel(frame: CGRect(x: 0, y: imgV.frame.maxY+kHeightScale*10, width: 30, height: 35))
//        nothingLab.font = UIFont.systemFont(ofSize: 20)
//        nothingLab.textColor = UIColor.gray
//        nothingLab.text = "sorry!还没有人才~"
//        nothingLab.sizeToFit()
//        nothingLab.center.x = self.contentView.center.x
//        nothingLab.frame.origin.y = imgV.frame.maxY+kHeightScale*25
//        self.contentView.addSubview(nothingLab)
        
        // 发布职位 Button
        publishJobBtn.frame = CGRect(x: (screenSize.width-kWidthScale*270)/2.0, y: nothingTextImg.frame.maxY+kHeightScale*20, width: kWidthScale*270, height: kHeightScale*40)
        publishJobBtn.backgroundColor = baseColor
        publishJobBtn.layer.cornerRadius = 6
        publishJobBtn.setTitle("发布职位", for: UIControlState())
        self.contentView.addSubview(publishJobBtn)
        
        // 提示 label
        let tipLabel = UILabel(frame: CGRect(x: 0, y: publishJobBtn.frame.maxY+5, width: 20, height: 25))
        tipLabel.textColor = UIColor(red: 136/255.0, green: 136/255.0, blue: 136/255.0, alpha: 1)
        tipLabel.font = UIFont.systemFont(ofSize: 13)
        tipLabel.text = "发布职位后 会为您推荐最合适的人才"
        tipLabel.sizeToFit()
        tipLabel.center.x = self.contentView.center.x
        self.contentView.addSubview(tipLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
