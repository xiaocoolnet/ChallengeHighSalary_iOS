//
//  FTMyInterviewInvitationTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMyInterviewInvitationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLab: UILabel!
    
    @IBOutlet weak var headerImg: UIImageView!
    
    @IBOutlet weak var vImg: UIImageView!
    
    @IBOutlet weak var jobTypeLab: UILabel!
    
    @IBOutlet weak var timeLab: UILabel!
    
    @IBOutlet weak var addressLab: UILabel!
    
    var myInvitedData: MyInvitedDataModel? {
        didSet {
            self.nameLab.text = "\(myInvitedData?.realname) \(myInvitedData?.sex == "0" ? "♀":"♂")"
            
            self.headerImg.sd_setImage(with: URL(string: (myInvitedData?.photo ?? "")!), placeholderImage: nil)
            // self.vImg = myInvitedData
            self.jobTypeLab.text = myInvitedData?.jobtype
            self.timeLab.text = myInvitedData?.create_time
            self.addressLab.text = myInvitedData?.address
        }
    }    
    
    @IBOutlet weak var topLine: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.drawDashed(topLine, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: screenSize.width, y: 0), lineWidth: 1)
    }
    
    
    func drawDashed(_ onView:UIView, color:UIColor, fromPoint:CGPoint, toPoint:CGPoint, lineWidth:CGFloat) {
        
        let dotteShapLayer = CAShapeLayer()
        let mdotteShapePath = CGMutablePath()
        dotteShapLayer.fillColor = UIColor.clear.cgColor
        dotteShapLayer.strokeColor = color.cgColor
        dotteShapLayer.lineWidth = lineWidth
        mdotteShapePath.move(to: fromPoint)
        mdotteShapePath.addLine(to: toPoint)
//        CGPathMoveToPoint(mdotteShapePath, nil, fromPoint.x, fromPoint.y)
//        CGPathAddLineToPoint(mdotteShapePath, nil, toPoint.x, toPoint.y)
        //        CGPathAddLineToPoint(mdotteShapePath, nil, 200, 200)
        dotteShapLayer.path = mdotteShapePath
        let arr :NSArray = NSArray(array: [10,5])
        dotteShapLayer.lineDashPhase = 1.0
        dotteShapLayer.lineDashPattern = arr as? [NSNumber]
        onView.layer.addSublayer(dotteShapLayer)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
