//
//  LoginNetUtil.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/14.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import HandyJSON

class LoginNetUtil: NSObject {
    
    // MARK: 验证手机是否已经注册
    func checkphone(_ phone:String, handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"checkphone"
        let param = [
            "phone":phone
        ];
        
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{

                let checkCode = JSONDeserializer<CheckphoneModel>.deserializeFrom(dict: json as! NSDictionary?)!
                if checkCode.status == "success" {
                    handle(true, checkCode.data as AnyObject?)
                }else{
                    
                    handle(false, checkCode.data as AnyObject?)
                }
            }
        }

    }
    
    // MARK: 发送验证码
    func SendMobileCode(_ phone:String, handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"SendMobileCode"
        let param = [
            "phone":phone
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in

            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                
                let checkCode = JSONDeserializer<CheckCodeModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if checkCode.status == "success" {
                    print(checkCode.data?.code ?? "")
                    handle(true, checkCode.data)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK:- 注册
    // phone,password,code,devicestate(1=>iOS 2=>android)
    func AppRegister(_ phone:String, password:String, code:String, handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"AppRegister"
        let param = [
            "phone":phone,
            "password":password,
            "code":code,
            "devicestate":"1"
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                let checkCode = JSONDeserializer<CheckphoneModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if checkCode.status == "success" {
                    
                    CHSUserInfo.initUserInfo()
                    
                    CHSUserInfo.currentUserInfo.userid = checkCode.data
                    handle(true, checkCode.data as AnyObject?)
                }else{
                    
                    handle(false, checkCode.data as AnyObject?)
                }
            }
        }
    }
    
    // MARK: 登录
    func applogin(_ phone:String, password:String, handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"applogin"
        let param = [
            "phone":phone,
            "password":password
        ];
 
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
    
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                
                let status = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

//                let status = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

//                let status:StatusModel = StatusModel.jsonToModel(json)
                if status.status == "success" {
                    let login = JSONDeserializer<LoginModel>.deserializeFrom(dict: json as! NSDictionary?)!
                    
                    JPUSHService.setAlias(login.data?.userid, callbackSelector: nil, object: nil)
//                    JPUSHService.setTags(<#T##tags: Set<AnyHashable>!##Set<AnyHashable>!#>, alias: <#T##String!#>, fetchCompletionHandle: { (<#Int32#>, <#Set<AnyHashable>?#>, <#String?#>) in
//                        <#code#>
//                    })


//                    let login:LoginModel = LoginModel.jsonToModel(json)
                    
                    UserDefaults.standard.set(true, forKey: isLogin_key)

                    CHSUserInfo.currentUserInfo.phoneNumber = (login.data?.phone)! == "" ? "":(login.data?.phone)!
                    CHSUserInfo.currentUserInfo.userid = (login.data?.userid)! == "" ? "":(login.data?.userid)!
                    CHSUserInfo.currentUserInfo.usertype = (login.data?.usertype)! == "" ? "":(login.data?.usertype)!
                    CHSUserInfo.currentUserInfo.realName = (login.data?.realname)! == "" ? "":(login.data?.realname)!
                    CHSUserInfo.currentUserInfo.sex = (login.data?.sex)! == "" ? "":(login.data?.sex)!
                    CHSUserInfo.currentUserInfo.email = (login.data?.email)! == "" ? "":(login.data?.email)!
                    CHSUserInfo.currentUserInfo.qqNumber = (login.data?.qq)! == "" ? "":(login.data?.qq)!
                    CHSUserInfo.currentUserInfo.weixinNumber = (login.data?.weixin)! == "" ? "":(login.data?.weixin)!
                    CHSUserInfo.currentUserInfo.avatar = (login.data?.photo)! == "" ? "":(login.data?.photo)!
                    CHSUserInfo.currentUserInfo.devicestate = (login.data?.devicestate)! == "" ? "":(login.data?.devicestate)!
                    CHSUserInfo.currentUserInfo.city = (login.data?.city)! == "" ? "":(login.data?.city)!
                    CHSUserInfo.currentUserInfo.weiboNumber = (login.data?.weibo)! == "" ? "":(login.data?.weibo)!
                    CHSUserInfo.currentUserInfo.work_life = (login.data?.work_life)! == "" ? "":(login.data?.work_life)!
                    CHSUserInfo.currentUserInfo.company = (login.data?.company)! == "" ? "":(login.data?.company)!
                    CHSUserInfo.currentUserInfo.myjob = (login.data?.myjob)! == "" ? "":(login.data?.myjob)!

                    handle(true, login.data)
                }else{
//                    let error:errorModel = errorModel.jsonToModel(json)
                    let error = JSONDeserializer<errorModel>.deserializeFrom(dict: json as! NSDictionary?)!

                    handle(false, error.data as AnyObject?)
                }
            }
        }
    }
    
    // MARK: 修改密码
    func forgetpwd(_ phone:String, code:String, password:String, handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"forgetpwd"
        let param = [
            "phone":phone,
            "code":code,
            "password":password
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                let status = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if status.status == "success" {
                    handle(true, "" as AnyObject?)
                }else{
                    
                    let error = JSONDeserializer<errorModel>.deserializeFrom(dict: json as! NSDictionary?)!

                    handle(false, error.data as AnyObject?)
                }
            }
        }
    }
    
    // MARK: 修改个人用户资料
    // userid,avatar,realname,sex(0=>女 1=>男),city,work_life,qq,weixin,weibo
    func savepersonalinfo(
        _ userid:String,
        avatar:String,
        realname:String,
        sex:String,
        city:String,
        work_life:String,
        qq:String,
        weixin:String,
        weibo:String, handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"savepersonalinfo"
        let param = [
            "userid":userid,
            "avatar":avatar,
            "realname":realname,
            "sex":sex,
            "city":city,
            "work_life":work_life,
            "qq":qq,
            "weixin":weixin,
            "weibo":weibo
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                
                let status = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if status.status == "success" {
                    
                    CHSUserInfo.currentUserInfo.avatar = avatar
                    CHSUserInfo.currentUserInfo.realName = realname
                    CHSUserInfo.currentUserInfo.sex = sex
                    CHSUserInfo.currentUserInfo.city = city
                    CHSUserInfo.currentUserInfo.work_life = work_life
                    CHSUserInfo.currentUserInfo.qqNumber = qq
                    CHSUserInfo.currentUserInfo.weixinNumber = weixin
                    CHSUserInfo.currentUserInfo.weiboNumber = weibo
                    
                    handle(true, "" as AnyObject?)
                }else{
                    
                    let error = JSONDeserializer<errorModel>.deserializeFrom(dict: json as! NSDictionary?)!

                    handle(false, error.data as AnyObject?)
                }
            }
        }
    }
    
    // MARK: 修改企业用户资料
    // userid,avatar,realname,myjob,email,company,qq,weixin,weibo
    func savecompanyinfo(
        _ userid:String,
        avatar:String,
        realname:String,
        myjob:String,
        email:String,
        company:String,
        qq:String,
        weixin:String,
        weibo:String, handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"savecompanyinfo"
        let param = [
            "userid":userid,
            "avatar":avatar,
            "realname":realname,
            "myjob":myjob,
            "email":email,
            "company":company,
            "qq":qq,
            "weixin":weixin,
            "weibo":weibo
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                
                let status = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if status.status == "success" {
                    handle(true, "" as AnyObject?)
                }else{
                    
                    let error = JSONDeserializer<errorModel>.deserializeFrom(dict: json as! NSDictionary?)!

//                    let error:errorModel = errorModel.jsonToModel(json)
                    handle(false, error.data as AnyObject?)
                }
            }
        }
    }
    
    // MARK: 上传图片
    func uploadImage(_ imageName:String, image:UIImage, handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"uploadavatar"
        
        //修正图片的位置
        let newImage = self.fixOrientation(image)
        //先把图片压缩并转成NSData
        let data = newImage.compressImage(newImage, maxLength: 2048000)

        NetUtil.net.uploadWithPOST(url, data: data!, name: "upfile", fileName: imageName, mimeType: "image/png") { (resultType) in
            switch resultType {
            case .success:
                
                handle(true, UIImage(data: data!))
                
            case .failure:
                handle(false, nil)
            }
        }

    }
    
    // MARK: 修正图片的位置
    func fixOrientation(_ aImage: UIImage) -> UIImage {
        // No-op if the orientation is already correct
        if aImage.imageOrientation == .up {
            return aImage
        }
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform: CGAffineTransform = CGAffineTransform.identity
        switch aImage.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: aImage.size.height)
            transform = transform.rotated(by: CGFloat(M_PI))
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(M_PI_2))
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: aImage.size.height)
            transform = transform.rotated(by: CGFloat(-M_PI_2))
        default:
            break
        }
        
        switch aImage.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: aImage.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        
        
        //这里需要注意下CGImageGetBitmapInfo，它的类型是Int32的，CGImageGetBitmapInfo(aImage.CGImage).rawValue，这样写才不会报错
        let ctx: CGContext = CGContext(data: nil, width: Int(aImage.size.width), height: Int(aImage.size.height), bitsPerComponent: aImage.cgImage!.bitsPerComponent, bytesPerRow: 0, space: aImage.cgImage!.colorSpace!, bitmapInfo: aImage.cgImage!.bitmapInfo.rawValue)!
        ctx.concatenate(transform)
        switch aImage.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            // Grr...
            ctx.draw(aImage.cgImage!, in: CGRect(x: 0, y: 0, width: aImage.size.height, height: aImage.size.width))
        default:
            ctx.draw(aImage.cgImage!, in: CGRect(x: 0, y: 0, width: aImage.size.width, height: aImage.size.height))
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg: CGImage = ctx.makeImage()!
        let img: UIImage = UIImage(cgImage: cgimg)
        return img
    }
    
//    // MARK: 修改手机号
//    func updateUserPhone(phone:String, handle:ResponseClosures) {
//        
//        let url = kPortPrefix+"updateUserPhone"
//        let param = [
//            "userid":CHSUserInfo.currentUserInfo.userid,
//            "phone":phone
//        ];
//        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
//            
//            if(error != nil){
//                handle(success: false, response: error?.description)
//            }else{
//                let status:StatusModel = StatusModel.jsonToModelWithData(json)
//                if status.status == "success" {
//                    handle(success: true, response: "")
//                }else{
//                    let error:errorModel = errorModel.jsonToModelWithData(json)
//                    handle(success: false, response: error.data)
//                }
//            }
//        }
//    }
}
