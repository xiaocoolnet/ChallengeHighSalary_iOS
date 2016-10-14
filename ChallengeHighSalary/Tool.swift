//
//  Tool.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/8/31.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

//MARK:- 基础数据
let screenSize = UIScreen.mainScreen().bounds.size
let kWidthScale = screenSize.width/375
let kHeightScale = screenSize.height/667


let baseColor = UIColor(red: 105/255.0, green: 216/255.0, blue: 147/255.0, alpha: 1)

//MARK:- 网络数据
let kDomainName = "http://122.114.156.127/"
let kPortPrefix = "\(kDomainName)index.php?g=apps&m=index&a="
let kImagePrefix = "\(kDomainName)/uploads/microblog/"

//MARK:- APP数据
// MARK: Key
var myCity = NSUserDefaults.standardUserDefaults().stringForKey("myCity")
let isLogin_key = "isLogin"
let logInfo_key = "login_info"
let userName_key = "login_name"
let userPwd_key = "login_password"
// 挑战高薪-我的-设置-消息提醒设置 key 前缀
let CHSMiMessageRemindSetting_key_pre = "CHSMiMessageRemindSetting"
let FTPublishJobSelectedNameArray_key = "publishJobSelectedNameArray"

var isLogin = NSUserDefaults.standardUserDefaults().boolForKey(isLogin_key)
var positioningCity = "未知"

//MARK:- 公用方法
typealias ResponseClosures = (success:Bool,response:AnyObject?)->Void

@objc(StatusModel)
class StatusModel: D3Model {
    
    var status: String = ""
    
}

@objc(errorModel)
class errorModel: D3Model {
    
    
    var status: String = ""
    
    var data: String = ""
    
    
}

typealias TimerHandle = (timeInterVal:Int)->Void

//MARK: 计时器类
class TimeManager{
    var taskDic = Dictionary<String,TimeTask>()
    
    //两行代码创建一个单例
    static let shareManager = TimeManager()
    private init() {
    }
    func begainTimerWithKey(key:String,timeInterval:Float,process:TimerHandle,finish:TimerHandle){
        if taskDic.count > 20 {
            print("任务太多")
            return
        }
        if timeInterval>120 {
            print("不支持120秒以上后台操作")
            return
        }
        if taskDic[key] != nil{
            print("存在这个任务")
            return
        }
        let task = TimeTask().configureWithTime(key,time:timeInterval, processHandle: process, finishHandle:finish)
        taskDic[key] = task
    }
}
class TimeTask :NSObject{
    var key:String?
    var FHandle:TimerHandle?
    var PHandle:TimerHandle?
    var leftTime:Float = 0
    var totolTime:Float = 0
    var backgroundID:UIBackgroundTaskIdentifier?
    var timer:NSTimer?
    
    func configureWithTime(myKey:String,time:Float,processHandle:TimerHandle,finishHandle:TimerHandle) -> TimeTask {
        backgroundID = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler(nil)
        key = myKey
        totolTime = time
        leftTime = totolTime
        FHandle = finishHandle
        PHandle = processHandle
        timer = NSTimer(timeInterval: 1.0, target: self, selector:#selector(sendHandle), userInfo: nil, repeats: true)
        
        //将timer源写入runloop中被监听，commonMode-滑动不停止
        NSRunLoop.currentRunLoop().addTimer(self.timer!, forMode: NSRunLoopCommonModes)
        return self
    }
    
    func sendHandle(){
        leftTime -= 1
        if leftTime > 0 {
            if PHandle != nil {
                PHandle!(timeInterVal:Int(leftTime))
            }
        }else{
            timer?.invalidate()
            TimeManager.shareManager.taskDic.removeValueForKey(key!)
            if FHandle != nil {
                FHandle!(timeInterVal: 0)
            }
        }
    }
}

//MARK: 验证手机号是否正确
func isPhoneNumber(phoneNumber:String) -> Bool {
    if phoneNumber.characters.count == 0 {
        return false
    }
    let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
    let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    if regexMobile.evaluateWithObject(phoneNumber) == true {
        return true
    }else
    {
        return false
    }
}

//MARK: 画虚线
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

//MARK: 计算文本最佳高度
func calculateHeight(string:String,size:CGFloat,width:  CGFloat) -> CGFloat {
    let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
    //let screenBounds:CGRect = UIScreen.mainScreen().bounds
    let boundingRect = String(string).boundingRectWithSize(CGSizeMake(width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(size)], context: nil)
    return boundingRect.height
}

//MARK: 计算文本最佳宽度
func calculateWidth(string:String,size:CGFloat,height:  CGFloat) -> CGFloat {
    let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
    //let screenBounds:CGRect = UIScreen.mainScreen().bounds
    let boundingRect = String(string).boundingRectWithSize(CGSizeMake(0, height), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(size)], context: nil)
    
    return boundingRect.width
}

//MARK: 交换 button 位置 （图片靠右）
var exchangedBtnArray = [UIButton]()
func exchangeBtnImageAndTitle(button: UIButton, margin: CGFloat) {
    
    // 防止重复交换
    for exchangedBtn in exchangedBtnArray {
        if exchangedBtn == button {
            return
        }
    }
    
    if (button.currentImage != nil) {
        
        button.titleLabel?.sizeToFit()

        
        if button.bounds.size.width >= button.titleLabel!.bounds.size.width+(button.currentImage?.size.width)!+margin || button.bounds.size.width == 0 {
            
            if button.contentHorizontalAlignment == .Right {
                
                button.imageEdgeInsets = UIEdgeInsetsMake(0, button.titleLabel!.bounds.size.width, 0, -button.titleLabel!.bounds.size.width)
                button.titleEdgeInsets = UIEdgeInsetsMake(0, -(button.currentImage?.size.width)!-margin, 0, (button.currentImage?.size.width)!+margin)
            }else{
                
                button.imageEdgeInsets = UIEdgeInsetsMake(0, button.titleLabel!.bounds.size.width+margin, 0, -button.titleLabel!.bounds.size.width-margin)
                button.titleEdgeInsets = UIEdgeInsetsMake(0, -(button.currentImage?.size.width)!, 0, (button.currentImage?.size.width)!)
            }
        }else{ // 针对 button.title 过长的解决办法
            
            button.imageEdgeInsets = UIEdgeInsetsMake(0, button.bounds.size.width-(button.currentImage?.size.width)!, 0, -button.bounds.size.width-(button.currentImage?.size.width)!)
            button.titleLabel?.bounds.size.width = button.bounds.size.width-(button.currentImage?.size.width)!-margin
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -(button.currentImage?.size.width)!, 0, (button.currentImage?.size.width)!)
        }
        exchangedBtnArray.append(button)
    }
    
//    }
}