//
//  ChChFindJobTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/5.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChChFindJobTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var company_nameLab: UILabel!
    
    @IBOutlet weak var logoImg: UIImageView!
    
    
    @IBOutlet weak var countLab: UILabel!
    
    @IBOutlet weak var salaryLab: UILabel!
    
    @IBOutlet weak var cityLab: UILabel!
    
    @IBOutlet weak var experienceLab: UILabel!
    
    @IBOutlet weak var educationLab: UILabel!
    
    
    
    
    
    @IBOutlet weak var topLine: UIImageView!
    
    @IBOutlet weak var bottomLine: UIView!
    
    @IBOutlet weak var companyBtn: UIButton!
    
    
    var jobInfo:JobInfoDataModel? {
        didSet {
            self.titleLab.text = jobInfo?.title
            self.company_nameLab.text = jobInfo?.company_name
            self.logoImg.sd_setImageWithURL(NSURL(string: kImagePrefix+(jobInfo?.logo)!), placeholderImage: nil)
            self.countLab.text = jobInfo?.count
            self.salaryLab.text = jobInfo?.salary
            self.cityLab.text = jobInfo?.city?.componentsSeparatedByString("-").last
            self.experienceLab.text = jobInfo?.experience
            self.educationLab.text = jobInfo?.education
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.drawDashed(topLine, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(0, 0), toPoint: CGPointMake(screenSize.width, 0), lineWidth: 1)
        
        self.drawDashed(bottomLine, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(0, 0), toPoint: CGPointMake(screenSize.width, 0), lineWidth: 1)
    }
    
    
    func drawDashed(onView:UIView, color:UIColor, fromPoint:CGPoint, toPoint:CGPoint, lineWidth:CGFloat) {
        
        let dotteShapLayer = CAShapeLayer()
        let mdotteShapePath = CGPathCreateMutable()
        dotteShapLayer.fillColor = UIColor.clearColor().CGColor
        dotteShapLayer.strokeColor = color.CGColor
        dotteShapLayer.lineWidth = lineWidth
        CGPathMoveToPoint(mdotteShapePath, nil, fromPoint.x, fromPoint.y)
        CGPathAddLineToPoint(mdotteShapePath, nil, toPoint.x, toPoint.y)
        //        CGPathAddLineToPoint(mdotteShapePath, nil, 200, 200)
        dotteShapLayer.path = mdotteShapePath
        let arr :NSArray = NSArray(array: [10,5])
        dotteShapLayer.lineDashPhase = 1.0
        dotteShapLayer.lineDashPattern = arr as? [NSNumber]
        onView.layer.addSublayer(dotteShapLayer)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
