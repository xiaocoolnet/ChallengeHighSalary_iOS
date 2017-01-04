//
//  EvaluateView.swift
//  ChallengeHighSalary
//
//  Created by 沈晓龙 on 2017/1/4.
//  Copyright © 2017年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class EvaluateView: UIView {

    let nameLab = UILabel()
    var num = Int()
    var dataArray = NSMutableArray()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nameLab.frame = CGRect(x: 10, y: 10, width: 150, height: 20)
        nameLab.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(nameLab)
        
        for i in 0...4 {
            let width : CGFloat = CGFloat(30*i)
            let btn = UIButton.init(frame: CGRect(x: self.frame.size.width-155 + width, y: 10, width: 20, height: 20))
            btn.setImage(UIImage.init(named: "ic-stargray"), for: .normal)
            btn.setImage(UIImage.init(named: "ic-star"), for: .selected)
            btn.isSelected = false;
            self.addSubview(btn)
            btn.tag = 1000 + i
            btn.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
            dataArray.add(btn)
        }
    }
    
    
    func clickButton(sender:UIButton){
        switch sender.tag {
        case 1000:
            num = 1
            (dataArray[0] as! UIButton).isSelected = true
            (dataArray[1] as! UIButton).isSelected = false
            (dataArray[2] as! UIButton).isSelected = false
            (dataArray[3] as! UIButton).isSelected = false
            (dataArray[4] as! UIButton).isSelected = false
        case 1001:
            num = 2
            (dataArray[0] as! UIButton).isSelected = true
            (dataArray[1] as! UIButton).isSelected = true
            (dataArray[2] as! UIButton).isSelected = false
            (dataArray[3] as! UIButton).isSelected = false
            (dataArray[4] as! UIButton).isSelected = false
        case 1002:
            num = 3
            (dataArray[0] as! UIButton).isSelected = true
            (dataArray[1] as! UIButton).isSelected = true
            (dataArray[2] as! UIButton).isSelected = true
            (dataArray[3] as! UIButton).isSelected = false
            (dataArray[4] as! UIButton).isSelected = false
        case 1003:
            num = 4
            (dataArray[0] as! UIButton).isSelected = true
            (dataArray[1] as! UIButton).isSelected = true
            (dataArray[2] as! UIButton).isSelected = true
            (dataArray[3] as! UIButton).isSelected = true
            (dataArray[4] as! UIButton).isSelected = false
        case 1004:
            num = 5
            (dataArray[0] as! UIButton).isSelected = true
            (dataArray[1] as! UIButton).isSelected = true
            (dataArray[2] as! UIButton).isSelected = true
            (dataArray[3] as! UIButton).isSelected = true
            (dataArray[4] as! UIButton).isSelected = true
        default:
            print("挑战高薪-我的-didSelectRowAtIndexPath  default")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
