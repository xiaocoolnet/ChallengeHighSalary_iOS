//
//  FTTalentTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/24.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTalentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLab: UILabel!
    
    @IBOutlet weak var position_typelab: UILabel!
    
    @IBOutlet weak var photoImg: UIImageView!
    
    @IBOutlet weak var advantageLab: UILabel!
    
    @IBOutlet weak var wantSalaryLab: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var work_lifeLab: UILabel!
    
    @IBOutlet weak var degreeLab: UILabel!
    
    @IBOutlet weak var work_propertyLab: UILabel!
    
    @IBOutlet weak var noteLab: UILabel!
    @IBOutlet weak var topLine: UIImageView!
    
    @IBOutlet weak var bottomLine: UIView!
    
    
    
    var resumeData = MyResumeData() {
        didSet {
            self.nameLab.text = resumeData.realname
            self.position_typelab.text = resumeData.position_type
            self.photoImg.sd_setImage(with: URL(string: kImagePrefix+resumeData.photo), placeholderImage: nil)
            self.advantageLab.text = resumeData.advantage
            self.wantSalaryLab.text = "￥"+resumeData.wantsalary+"K"
            self.address.text = resumeData.address.components(separatedBy: "-").last
            self.work_lifeLab.text = resumeData.work_life
            self.degreeLab.text = resumeData.education?.first?.degree
            self.work_propertyLab.text = resumeData.work_property
            
            let str = "现任 \(resumeData.myjob) | \(resumeData.company)"
            
            self.drawDashed(topLine, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: screenSize.width, y: 0), lineWidth: 1)
            
            self.drawDashed(bottomLine, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: screenSize.width, y: 0), lineWidth: 1)
            
            let nsStr = NSString(string: str)
            let attStr = NSMutableAttributedString(string: str)
            
            attStr.addAttributes([NSForegroundColorAttributeName: UIColor.black], range: NSMakeRange(0, nsStr.length))
            attStr.addAttributes([NSForegroundColorAttributeName: baseColor], range: NSMakeRange(nsStr.range(of: "现任 ").length, nsStr.range(of: " | ").location-nsStr.range(of: "现任 ").length))
            attStr.addAttributes([NSForegroundColorAttributeName: UIColor.lightGray], range: nsStr.range(of: " | "))
            
            self.noteLab.attributedText = attStr
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        self.drawDashed(topLine, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(0, 0), toPoint: CGPointMake(screenSize.width, 0), lineWidth: 1)
//        
//        self.drawDashed(bottomLine, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(0, 0), toPoint: CGPointMake(screenSize.width, 0), lineWidth: 1)
//
//        let nsStr = NSString(string: str)
//        let attStr = NSMutableAttributedString(string: str)
//
//        attStr.addAttributes([NSForegroundColorAttributeName: UIColor.blackColor()], range: NSMakeRange(0, nsStr.length))
//        attStr.addAttributes([NSForegroundColorAttributeName: baseColor], range: NSMakeRange(nsStr.rangeOfString("现任 ").length, nsStr.rangeOfString(" | ").location-nsStr.rangeOfString("现任 ").length))
//        attStr.addAttributes([NSForegroundColorAttributeName: UIColor.lightGrayColor()], range: nsStr.rangeOfString(" | "))
//        
//        self.noteLab.attributedText = attStr

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
