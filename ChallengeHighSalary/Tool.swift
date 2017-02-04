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
import HandyJSON

//MARK:- 基础数据
let screenSize = UIScreen.main.bounds.size
let kWidthScale = screenSize.width/375
let kHeightScale = screenSize.height/667

let defaultLocationTimeout = 6
let defaultReGeocodeTimeout = 3

var displayLabel: UILabel!

var typeNum = 1

let baseColor = UIColor(red: 105/255.0, green: 216/255.0, blue: 147/255.0, alpha: 1)

//MARK:- 网络数据
//let kDomainName = "http://app.nzrc.cn/"
let kDomainName = "http://nyjob.xiaocool.net/"

let kPortPrefix = "\(kDomainName)index.php?g=apps&m=index&a="
let kImagePrefix = "\(kDomainName)/uploads/microblog/"

//MARK:- APP数据
// MARK: Key
//var myCity = NSUserDefaults.standardUserDefaults().stringForKey("myCity")
var myCity = "城市"
let myCity_key = "myCity"
let positioningCity_key = "positioningCity"
let isLogin_key = "isLogin"
let logInfo_key = "login_info"
let userName_key = "login_name"
let userPwd_key = "login_password"
// 挑战高薪-我的-设置-消息提醒设置 key 前缀
let CHSMiMessageRemindSetting_key_pre = "CHSMiMessageRemindSetting"
let FTPublishJobSelectedNameArray_key = "publishJobSelectedNameArray"

var isLogin = UserDefaults.standard.bool(forKey: isLogin_key)
var positioningCity = "未知"

var ftSortType = 0

var ftPostPosition = ""
var ftPostPositionLocation = AMapGeoPoint()

//MARK:- 公用方法
typealias ResponseClosures = (_ success:Bool,_ response:AnyObject?)->Void

class StatusModel: HandyJSON {
    
    var status: String = ""
    
    required init() {}

}

class errorModel: HandyJSON {
    
    
    var status: String = ""
    
    var data: String = ""
    
    required init() {}

}

class DicModel: HandyJSON {
    
    var status: String?
    
    var data: [DicDataModel]?
    
    required init() {}
    
}

class DicDataModel: HandyJSON {
    
    var term_id: String?

    var name: String?

    var description: String?

    required init() {}

}

enum MyInvitedType: Int{
    case waitInterview = 0// 待面试
    case completed// 已结束
    case pending// 待确认
    case denied// 已拒绝
    case canceled// 已取消
    case all// 全部
}

typealias TimerHandle = (_ timeInterVal:Int)->Void

//MARK: 计时器类
class TimeManager{
    var taskDic = Dictionary<String,TimeTask>()
    
    //两行代码创建一个单例
    static let shareManager = TimeManager()
    fileprivate init() {
    }
    func begainTimerWithKey(_ key:String,timeInterval:Float,process:@escaping TimerHandle,finish:@escaping TimerHandle){
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
    var timer:Timer?
    
    func configureWithTime(_ myKey:String,time:Float,processHandle:@escaping TimerHandle,finishHandle:@escaping TimerHandle) -> TimeTask {
        backgroundID = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
        key = myKey
        totolTime = time
        leftTime = totolTime
        FHandle = finishHandle
        PHandle = processHandle
        timer = Timer(timeInterval: 1.0, target: self, selector:#selector(sendHandle), userInfo: nil, repeats: true)
        
        //将timer源写入runloop中被监听，commonMode-滑动不停止
        RunLoop.current.add(self.timer!, forMode: RunLoopMode.commonModes)
        return self
    }
    
    func sendHandle(){
        leftTime -= 1
        if leftTime > 0 {
            if PHandle != nil {
                PHandle!(Int(leftTime))
            }
        }else{
            timer?.invalidate()
            TimeManager.shareManager.taskDic.removeValue(forKey: key!)
            if FHandle != nil {
                FHandle!(0)
            }
        }
    }
}

//MARK: 验证手机号是否正确
func isPhoneNumber(_ phoneNumber:String) -> Bool {
    if phoneNumber.characters.count == 0 {
        return false
    }
    let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
    let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    if regexMobile.evaluate(with: phoneNumber) == true {
        return true
    }else
    {
        return false
    }
}

//MARK: 画虚线
func drawDashed(_ onView:UIView, color:UIColor, fromPoint:CGPoint, toPoint:CGPoint, lineWidth:CGFloat) {
    
    let dotteShapLayer = CAShapeLayer()
    let mdotteShapePath = CGMutablePath()
    dotteShapLayer.fillColor = UIColor.clear.cgColor
    dotteShapLayer.strokeColor = color.cgColor
    dotteShapLayer.lineWidth = lineWidth
    mdotteShapePath.move(to: fromPoint)
    mdotteShapePath.addLine(to: toPoint)
//    CGPathMoveToPoint(mdotteShapePath, nil, fromPoint.x, fromPoint.y)
//    CGPathAddLineToPoint(mdotteShapePath, nil, toPoint.x, toPoint.y)
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

//MARK: 画直线
func drawLine(_ onView:UIView, color:UIColor, fromPoint:CGPoint, toPoint:CGPoint, lineWidth:CGFloat, pattern:[NSNumber] = [10,5]) {
    
    let dotteShapLayer = CAShapeLayer()
    let mdotteShapePath = CGMutablePath()
    dotteShapLayer.fillColor = color.cgColor
    dotteShapLayer.strokeColor = color.cgColor
    dotteShapLayer.lineWidth = lineWidth
    mdotteShapePath.move(to: fromPoint)
    mdotteShapePath.addLine(to: toPoint)
//    CGPathMoveToPoint(mdotteShapePath, nil, fromPoint.x, fromPoint.y)
//    CGPathAddLineToPoint(mdotteShapePath, nil, toPoint.x, toPoint.y)
    //        CGPathAddLineToPoint(mdotteShapePath, nil, 200, 200)
    dotteShapLayer.path = mdotteShapePath
//    let arr :NSArray = NSArray(array: [1,0])
    dotteShapLayer.lineDashPhase = 1
    dotteShapLayer.lineDashPattern = pattern
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
func calculateHeight(_ string:String,size:CGFloat,width:  CGFloat) -> CGFloat {
    let options : NSStringDrawingOptions = NSStringDrawingOptions.usesLineFragmentOrigin
    //let screenBounds:CGRect = UIScreen.mainScreen().bounds
    let boundingRect = String(string).boundingRect(with: CGSize(width: width, height: 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: size)], context: nil)
    return boundingRect.height
}

//MARK: 计算文本最佳宽度
func calculateWidth(_ string:String,size:CGFloat,height:  CGFloat) -> CGFloat {
    let options : NSStringDrawingOptions = NSStringDrawingOptions.usesLineFragmentOrigin
    //let screenBounds:CGRect = UIScreen.mainScreen().bounds
    let boundingRect = String(string).boundingRect(with: CGSize(width: 0, height: height), options: options, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: size)], context: nil)
    
    return boundingRect.width
}

//MARK: 交换 button 位置 （图片靠右）
var exchangedBtnArray = [UIButton]()
func exchangeBtnImageAndTitle(_ button: UIButton, margin: CGFloat) {
    
    // 防止重复交换
    for exchangedBtn in exchangedBtnArray {
        if exchangedBtn == button {
            return
        }
    }
    
    if (button.currentImage != nil) {
        
        button.titleLabel?.sizeToFit()
        
        if button.bounds.size.width >= button.titleLabel!.bounds.size.width+(button.currentImage?.size.width)!+margin || button.bounds.size.width == 0 {
            
            if button.contentHorizontalAlignment == .right {
                
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

//func adjustBtnsTitleLabelAndImgaeView(_ button:UIButton, adjustWidth: Bool=false ) {
//    if (button.titleLabel != nil) && (button.imageView != nil) && (button.currentImage != nil) {
//        
//        let margin:CGFloat = 5
//        button.titleLabel?.sizeThatFits(CGSize(width: button.frame.width-(button.currentImage?.size.width)!-margin, height: button.frame.height))
////        button.image(for: UIControlState())
//        button.imageView?.frame.origin.x = (button.titleLabel?.frame)!.maxX+margin
//        
//        if adjustWidth {
//            
//            button.frame.size.width = (button.imageView?.frame)!.maxX+margin
//        }
//    }
//}

func changeCityName(cityName:String) -> String {
    
    //如果需要去掉“市”和“省”字眼
    var newCityName = cityName
    newCityName = newCityName.replacingOccurrences(of: "省", with: "")
    newCityName = newCityName.replacingOccurrences(of: "市", with: "")
    newCityName = newCityName.replacingOccurrences(of: "自治州", with: "")
    newCityName = newCityName.replacingOccurrences(of: "地区", with: "")
    newCityName = newCityName.replacingOccurrences(of: "自治县", with: "")
    newCityName = newCityName.replacingOccurrences(of: "特别行政区", with: "")
    
    newCityName = newCityName.replacingOccurrences(of: "地區", with: "")
    newCityName = newCityName.replacingOccurrences(of: "自治縣", with: "")
    newCityName = newCityName.replacingOccurrences(of: "特別行政區", with: "")

    
    if newCityName.contains("中沙群岛") {
        return "中沙群岛"
    }else if newCityName.contains("中沙群島") {
        return "中沙群島"
    }
    
    return newCityName
}
