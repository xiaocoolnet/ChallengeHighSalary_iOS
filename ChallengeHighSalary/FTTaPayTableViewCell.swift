//
//  FTTaPayTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2017/1/17.
//  Copyright © 2017年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaPayTableViewCell: UITableViewCell {

    let iconImg = UIImageView()
    
    let textLab = UILabel()
    
    let dotIconImg = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dotIconImg.frame = CGRect(x: screenSize.width-20-15, y: 14, width: 16, height: 16)
        dotIconImg.setImage(#imageLiteral(resourceName: "ic_点_sel"), for: .selected)
        dotIconImg.setImage(#imageLiteral(resourceName: "ic_点_nor"), for: .normal)
        
        textLab.font = UIFont.systemFont(ofSize: 15)
        
        self.contentView.addSubview(iconImg)
        self.contentView.addSubview(textLab)
        self.contentView.addSubview(dotIconImg)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInfo(with icon:UIImage?, text:NSAttributedString, selectedDot:Bool) {
        if icon == nil {
            iconImg.isHidden = true
            
            textLab.frame = CGRect(x: 20, y: 0, width: 0, height: 0)
            textLab.attributedText = text
            textLab.sizeToFit()
            textLab.frame.origin = CGPoint(x: 20, y: 22-textLab.frame.size.height/2.0)
            
        }else{
            iconImg.isHidden = false
            iconImg.frame = CGRect(x: 20, y: 8, width: 28, height: 28)
            iconImg.image = icon
            
            textLab.frame = CGRect(x: iconImg.frame.maxX+8, y: 0, width: 0, height: 0)
            textLab.attributedText = text
            textLab.sizeToFit()
            textLab.frame.origin = CGPoint(x: iconImg.frame.maxX+8, y: 22-textLab.frame.size.height/2.0)
        }
        
        dotIconImg.isSelected = selectedDot

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
