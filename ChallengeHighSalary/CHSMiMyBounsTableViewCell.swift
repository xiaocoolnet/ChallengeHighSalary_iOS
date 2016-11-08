//
//  CHSMiMyBounsTableViewCell.swift
//  ChallengeHighSalary
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
        
        self.backgroundColor = UIColor.clear
        self.drawDashed(LineView, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPoint(x: 10, y: 0), toPoint: CGPoint(x: screenSize.width-8-8-10-10, y: 0), lineWidth: 1)
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
