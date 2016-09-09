//
//  ChChCityTableViewCell.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/7.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChChCityTableViewCell: UITableViewCell {
    
    var cityBtnsTitleArray = Array<String>() {
        didSet {
            setBtns()
        }
    }
    
    func setBtns() {
        
        for view in self.contentView.subviews {
            if view.isKindOfClass(UIButton) {
                view.removeFromSuperview()
            }
        }
        
        let cityBtnMargin:CGFloat = 10
        var cityBtnX:CGFloat = cityBtnMargin
        var cityBtnY:CGFloat = cityBtnMargin
        var cityBtnWidth:CGFloat = 0
        let cityBtnHeight:CGFloat = 25
        
        for (i,city) in cityBtnsTitleArray.enumerate() {
            cityBtnWidth = calculateWidth(city, size: 14, height: cityBtnHeight)+cityBtnMargin*4
            let cityBtn = UIButton(frame: CGRectMake(cityBtnX, cityBtnY, cityBtnWidth, cityBtnHeight))
            cityBtn.layer.cornerRadius = cityBtnHeight/2.0
            cityBtn.layer.borderWidth = 1
            cityBtn.layer.borderColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1).CGColor
            cityBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
            cityBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            cityBtn.setTitle(city, forState: .Normal)
            self.contentView.addSubview(cityBtn)
            
            if i+1 < cityBtnsTitleArray.count {
                
                let nextBtnWidth = calculateWidth(cityBtnsTitleArray[i+1], size: 14, height: cityBtnHeight)+cityBtnMargin*4
                
                if cityBtnWidth + cityBtnX + cityBtnMargin + nextBtnWidth >= screenSize.width - 20 {
                    cityBtnX = cityBtnMargin
                    cityBtnY = cityBtnHeight + cityBtnY + cityBtnMargin
                }else{
                    
                    cityBtnX = cityBtnWidth + cityBtnX + cityBtnMargin
                }
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
