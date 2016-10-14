//
//  CHSChInterviewEvaTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/21.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSChInterviewEvaTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImg: UIImageView!
    
    let evaTagArray = ["面试官很nice","面试效率高","聊得很开心"]
    let evaContent = "面试过程：公司人员配置目测完善，希望能获得这份工作"

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setEvaTagLabs()
    }
    
    func setEvaTagLabs() {
        
        for view in self.contentView.subviews {
            if view.isKindOfClass(UIButton) {
                view.removeFromSuperview()
            }
        }
        
        let evaTagLabMargin:CGFloat = 10
        var evaTagLabX:CGFloat = evaTagLabMargin
        var evaTagLabY:CGFloat = CGRectGetMaxY(headerImg.frame)+8
        var evaTagLabWidth:CGFloat = 0
        let evaTagLabHeight:CGFloat = 20
        
        for (i,evaTag) in evaTagArray.enumerate() {
            evaTagLabWidth = calculateWidth(evaTag, size: 14, height: evaTagLabHeight)+evaTagLabMargin*4
            let evaTagLab = UILabel(frame: CGRectMake(evaTagLabX, evaTagLabY, evaTagLabWidth, evaTagLabHeight))
            evaTagLab.layer.cornerRadius = evaTagLabHeight/2.0
            evaTagLab.layer.borderWidth = 1
            evaTagLab.layer.borderColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1).CGColor
            evaTagLab.font = UIFont.systemFontOfSize(13)
            evaTagLab.textColor = UIColor.lightGrayColor()
            evaTagLab.textAlignment = .Center
            evaTagLab.text = evaTag
            self.contentView.addSubview(evaTagLab)
            
            if i+1 < evaTagArray.count {
                
                let nextLabWidth = calculateWidth(evaTagArray[i+1], size: 14, height: evaTagLabHeight)+evaTagLabMargin*4
                
                if evaTagLabWidth + evaTagLabX + evaTagLabMargin + nextLabWidth >= screenSize.width - 20 {
                    evaTagLabX = evaTagLabMargin
                    evaTagLabY = evaTagLabHeight + evaTagLabY + evaTagLabMargin
                }else{
                    
                    evaTagLabX = evaTagLabWidth + evaTagLabX + evaTagLabMargin
                }
            }
            
        }
        
        let evaContentHeight = calculateHeight(evaContent, size: 13, width: screenSize.width-evaTagLabX)
        let evaContentLab = UILabel(frame: CGRectMake(10, evaTagLabY+evaTagLabMargin, screenSize.width-10, evaContentHeight))
        evaContentLab.font = UIFont.systemFontOfSize(13)
        evaContentLab.textColor = UIColor.blackColor()
        evaContentLab.text = evaContent
        self.contentView.addSubview(evaContentLab)
        
        let usefulBtnWidth = calculateWidth("有用(0)", size: 15, height: 30)+30+20
        let usefulBtn = UIButton(frame: CGRectMake(screenSize.width-usefulBtnWidth-8, CGRectGetMaxY(evaContentLab.frame)+10, usefulBtnWidth, 30))
        usefulBtn.contentHorizontalAlignment = .Right
        usefulBtn.setImage(UIImage(named: "1"), forState: .Normal)
        usefulBtn.imageView?.contentMode = .ScaleAspectFit
        usefulBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        usefulBtn.setTitleColor(UIColor(red: 75/255.0, green: 182/255.0, blue: 146/255.0, alpha: 1), forState: .Normal)
        usefulBtn.setTitle("有用(0)", forState: .Normal)
        self.contentView.addSubview(usefulBtn)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
