//
//  CHSMiMyBounsTableViewCell.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/9/28.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiMyBounsTableViewCell: UITableViewCell {

    @IBOutlet weak var LineView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.drawDashed(LineView, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(0, 0), toPoint: CGPointMake(screenSize.width, 0), lineWidth: 1)
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
