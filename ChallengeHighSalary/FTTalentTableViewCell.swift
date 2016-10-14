//
//  FTTalentTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/24.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTalentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noteLab: UILabel!
    @IBOutlet weak var topLine: UIImageView!
    
    @IBOutlet weak var bottomLine: UIView!
    
    let str = "现任 网页设计 | 北京互联有限公司"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.drawDashed(topLine, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(0, 0), toPoint: CGPointMake(screenSize.width, 0), lineWidth: 1)
        
        self.drawDashed(bottomLine, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(0, 0), toPoint: CGPointMake(screenSize.width, 0), lineWidth: 1)

        let nsStr = NSString(string: str)
        let attStr = NSMutableAttributedString(string: str)

        attStr.addAttributes([NSForegroundColorAttributeName: UIColor.blackColor()], range: NSMakeRange(0, nsStr.length))
        attStr.addAttributes([NSForegroundColorAttributeName: baseColor], range: NSMakeRange(nsStr.rangeOfString("现任 ").length, nsStr.rangeOfString(" | ").location-nsStr.rangeOfString("现任 ").length))
        attStr.addAttributes([NSForegroundColorAttributeName: UIColor.lightGrayColor()], range: nsStr.rangeOfString(" | "))
        
        self.noteLab.attributedText = attStr

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
