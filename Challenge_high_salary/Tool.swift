//
//  Tool.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/8/31.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

let screenSize = UIScreen.mainScreen().bounds.size
let kWidthScale = screenSize.width/375
let kHeightScale = screenSize.height/667


let baseColor = UIColor(red: 105/255.0, green: 216/255.0, blue: 147/255.0, alpha: 1)

var positioningCity = "未知"
var myCity = NSUserDefaults.standardUserDefaults().stringForKey("myCity")

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
    
    //        let dotteShapLayer = CAShapeLayer()
    //        let mdotteShapePath = CGPathCreateMutable()
    //        dotteShapLayer.fillColor = UIColor.clearColor().CGColor
    //        dotteShapLayer.strokeColor = UIColor.orangeColor().CGColor
    //        dotteShapLayer.lineWidth = 2.0
    //        CGPathAddEllipseInRect(mdotteShapePath, nil, CGRectMake(100.0, 150.0, 200.0, 200.0))
    //        dotteShapLayer.path = mdotteShapePath
    //        let arr :NSArray = NSArray(array: [10,5])
    //        dotteShapLayer.lineDashPhase = 1.0
    //        dotteShapLayer.lineDashPattern = arr as? [NSNumber]
    //        view.layer.addSublayer(dotteShapLayer)
}

func calculateHeight(string:String,size:CGFloat,width:  CGFloat) -> CGFloat {
    let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
    //let screenBounds:CGRect = UIScreen.mainScreen().bounds
    let boundingRect = String(string).boundingRectWithSize(CGSizeMake(width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(size)], context: nil)
    print(boundingRect.height)
    return boundingRect.height
}

func calculateWidth(string:String,size:CGFloat,height:  CGFloat) -> CGFloat {
    let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
    //let screenBounds:CGRect = UIScreen.mainScreen().bounds
    let boundingRect = String(string).boundingRectWithSize(CGSizeMake(0, height), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(size)], context: nil)
    
    return boundingRect.width
}