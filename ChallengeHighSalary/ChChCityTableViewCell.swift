//
//  ChChCityTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/7.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

protocol ChChCityTableViewCellDelegate {
    func cityTableViewCellCityBtnClick(_ cityBtn:UIButton, indexPath:IndexPath, index:Int)
}

class ChChCityTableViewCell: UITableViewCell {
    
    var delegate:ChChCityTableViewCellDelegate?
    
    fileprivate var indexPath:IndexPath = IndexPath(row: 0, section: 0)
    
//    var cityBtnsTitleArray = Array<String>()
    
    func setBtns(_ cityBtnsTitleArray:[String], indexPath:IndexPath) {
        self.indexPath = indexPath
        setBtns(cityBtnsTitleArray)
    }
    
    func setBtns(_ cityBtnsTitleArray:[String]) {
        
        for view in self.contentView.subviews {
            if view.isKind(of: UIButton.self) {
                view.removeFromSuperview()
            }
        }
        
        let cityBtnMargin:CGFloat = 10
        var cityBtnX:CGFloat = cityBtnMargin
        var cityBtnY:CGFloat = cityBtnMargin
        var cityBtnWidth:CGFloat = 0
        let cityBtnHeight:CGFloat = 25
        
        for (i,city) in cityBtnsTitleArray.enumerated() {
            cityBtnWidth = calculateWidth(city, size: 14, height: cityBtnHeight)+cityBtnMargin*4
            let cityBtn = UIButton(frame: CGRect(x: cityBtnX, y: cityBtnY, width: cityBtnWidth, height: cityBtnHeight))
            cityBtn.layer.cornerRadius = cityBtnHeight/2.0
            cityBtn.layer.borderWidth = 1
            cityBtn.layer.borderColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1).cgColor
            cityBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            cityBtn.setTitleColor(UIColor.black, for: UIControlState())
            cityBtn.setTitle(city, for: UIControlState())
            cityBtn.tag = 1000+i
            cityBtn.addTarget(self, action: #selector(cityBtnClick(_:)), for: .touchUpInside)
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
    
    func cityBtnClick(_ cityBtn:UIButton) {
//        print(cityBtn.currentTitle)
        self.delegate?.cityTableViewCellCityBtnClick(cityBtn, indexPath: self.indexPath, index: cityBtn.tag-1000)
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
