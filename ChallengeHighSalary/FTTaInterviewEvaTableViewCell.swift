//
//  FTTaInterviewEvaTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2017/1/3.
//  Copyright © 2017年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaInterviewEvaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerImg: UIImageView!
    
    let evaTagArray = ["面试官很nice","面试效率高","聊得很开心"]
    let evaContent = "公司人员配置目测完善，希望能获得这份工作"
    var usefulBtn : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setEvaTagLabs()
    }
    
    func setEvaTagLabs() {
        
        for view in self.contentView.subviews {
            if view.isKind(of: UIButton.self) {
                view.removeFromSuperview()
            }
        }
        
        let evaTagLabMargin:CGFloat = 10
        let evaTagLabX:CGFloat = evaTagLabMargin
        let evaTagLabY:CGFloat = headerImg.frame.maxY+8
        //        var evaTagLabWidth:CGFloat = 0
        //        let evaTagLabHeight:CGFloat = 20
        
        //        for (i,evaTag) in evaTagArray.enumerated() {
        //            evaTagLabWidth = calculateWidth(evaTag, size: 14, height: evaTagLabHeight)+evaTagLabMargin*4
        //            let evaTagLab = UILabel(frame: CGRect(x: evaTagLabX, y: evaTagLabY, width: evaTagLabWidth, height: evaTagLabHeight))
        //            evaTagLab.layer.cornerRadius = evaTagLabHeight/2.0
        //            evaTagLab.layer.borderWidth = 1
        //            evaTagLab.layer.borderColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1).cgColor
        //            evaTagLab.font = UIFont.systemFont(ofSize: 13)
        //            evaTagLab.textColor = UIColor.lightGray
        //            evaTagLab.textAlignment = .center
        //            evaTagLab.text = evaTag
        //            self.contentView.addSubview(evaTagLab)
        //
        //            if i+1 < evaTagArray.count {
        //
        //                let nextLabWidth = calculateWidth(evaTagArray[i+1], size: 14, height: evaTagLabHeight)+evaTagLabMargin*4
        //
        //                if evaTagLabWidth + evaTagLabX + evaTagLabMargin + nextLabWidth >= screenSize.width - 20 {
        //                    evaTagLabX = evaTagLabMargin
        //                    evaTagLabY = evaTagLabHeight + evaTagLabY + evaTagLabMargin
        //                }else{
        //
        //                    evaTagLabX = evaTagLabWidth + evaTagLabX + evaTagLabMargin
        //                }
        //            }
        //
        //        }
        let evaContentHeight = calculateHeight(evaContent, size: 13, width: screenSize.width-evaTagLabX)
        
        let evaLab = UILabel(frame: CGRect(x: 10, y: evaTagLabY, width: screenSize.width-10, height: 20))
        evaLab.font = UIFont.systemFont(ofSize: 14)
        evaLab.textColor = baseColor
        evaLab.text = "面试评价:"
        self.contentView.addSubview(evaLab)
        
        let evaContentLab = UILabel(frame: CGRect(x: 10, y: evaLab.frame.maxY + 10, width: screenSize.width-10, height: evaContentHeight))
        evaContentLab.font = UIFont.systemFont(ofSize: 13)
        evaContentLab.textColor = UIColor.black
        evaContentLab.text = evaContent
        self.contentView.addSubview(evaContentLab)
        
        let usefulBtnWidth = calculateWidth("有用(0)", size: 15, height: 30)+30+20
        usefulBtn = UIButton(frame: CGRect(x: screenSize.width-usefulBtnWidth-8, y: evaContentLab.frame.maxY+10, width: usefulBtnWidth, height: 30))
        usefulBtn.contentHorizontalAlignment = .right
        usefulBtn.setImage(UIImage(named: "1"), for: UIControlState())
        usefulBtn.imageView?.contentMode = .scaleAspectFit
        usefulBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        usefulBtn.setTitleColor(UIColor(red: 75/255.0, green: 182/255.0, blue: 146/255.0, alpha: 1), for: UIControlState())
        usefulBtn.setTitle("有用(0)", for: UIControlState())
        self.contentView.addSubview(usefulBtn)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
