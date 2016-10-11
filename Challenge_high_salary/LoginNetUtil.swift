//
//  LoginNetUtil.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/14.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import Alamofire

class LoginNetUtil: NSObject {
    
    // MARK: 验证手机是否已经注册
    func checkphone(phone:String, handle:ResponseClosures) {
        
        let url = kPortPrefix+"checkphone"
        let param = [
            "phone":phone
        ];
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let checkCode:CheckphoneModel = CheckphoneModel.jsonToModelWithData(json)
                if checkCode.status == "success" {
                    handle(success: true, response: checkCode.data)
                }else{
                    
                    handle(success: false, response: checkCode.data)
                }
            }
        }
    }
    
    // MARK: 发送验证码
    func SendMobileCode(phone:String, handle:ResponseClosures) {
        
        let url = kPortPrefix+"SendMobileCode"
        let param = [
            "phone":phone
        ];
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in

            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let checkCode:CheckCodeModel = CheckCodeModel.jsonToModelWithData(json)
                if checkCode.status == "success" {
                    print(checkCode.data?.code)
                    handle(success: true, response: checkCode.data)
                }else{
                    
                    handle(success: false, response: nil)
                }
            }
        }
    }
    
    // MARK:- 注册
    // phone,password,code,devicestate(1=>iOS 2=>android)
    func AppRegister(phone:String, password:String, code:String, handle:ResponseClosures) {
        
        let url = kPortPrefix+"AppRegister"
        let param = [
            "phone":phone,
            "password":password,
            "code":code,
            "devicestate":"1"
        ];
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let checkCode:CheckphoneModel = CheckphoneModel.jsonToModelWithData(json)
                if checkCode.status == "success" {
                    CHSUserInfo.currentUserInfo.userid = checkCode.data
                    handle(success: true, response: checkCode.data)
                }else{
                    
                    handle(success: false, response: checkCode.data)
                }
            }
        }
    }
    
    // MARK: 登录
    func applogin(phone:String, password:String, handle:ResponseClosures) {
        
        let url = kPortPrefix+"applogin"
        let param = [
            "phone":phone,
            "password":password
        ];
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let status:StatusModel = StatusModel.jsonToModelWithData(json)
                if status.status == "success" {
                    let login:LoginModel = LoginModel.jsonToModelWithData(json)
                    
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: isLogin_key)

                    CHSUserInfo.currentUserInfo.phoneNumber = (login.data?.phone)! == "<null>" ? "":(login.data?.phone)!
                    CHSUserInfo.currentUserInfo.userid = (login.data?.userid)! == "<null>" ? "":(login.data?.userid)!
                    CHSUserInfo.currentUserInfo.usertype = (login.data?.usertype)! == "<null>" ? "":(login.data?.usertype)!
                    CHSUserInfo.currentUserInfo.realName = (login.data?.realname)! == "<null>" ? "":(login.data?.realname)!
                    CHSUserInfo.currentUserInfo.sex = (login.data?.sex)! == "<null>" ? "":(login.data?.sex)!
                    CHSUserInfo.currentUserInfo.email = (login.data?.email)! == "<null>" ? "":(login.data?.email)!
                    CHSUserInfo.currentUserInfo.qqNumber = (login.data?.qq)! == "<null>" ? "":(login.data?.qq)!
                    CHSUserInfo.currentUserInfo.weixinNumber = (login.data?.weixin)! == "<null>" ? "":(login.data?.weixin)!
                    CHSUserInfo.currentUserInfo.avatar = (login.data?.photo)! == "<null>" ? "":(login.data?.photo)!
                    CHSUserInfo.currentUserInfo.devicestate = (login.data?.devicestate)! == "<null>" ? "":(login.data?.devicestate)!
                    CHSUserInfo.currentUserInfo.city = (login.data?.city)! == "<null>" ? "":(login.data?.city)!
                    CHSUserInfo.currentUserInfo.weiboNumber = (login.data?.weibo)! == "<null>" ? "":(login.data?.weibo)!
                    CHSUserInfo.currentUserInfo.work_life = (login.data?.work_life)! == "<null>" ? "":(login.data?.work_life)!
                    CHSUserInfo.currentUserInfo.company = (login.data?.company)! == "<null>" ? "":(login.data?.company)!
                    CHSUserInfo.currentUserInfo.myjob = (login.data?.myjob)! == "<null>" ? "":(login.data?.myjob)!

                    handle(success: true, response: login.data)
                }else{
                    let error:errorModel = errorModel.jsonToModelWithData(json)
                    handle(success: false, response: error.data)
                }
            }
        }
    }
    
    // MARK: 修改密码
    func forgetpwd(phone:String, code:String, password:String, handle:ResponseClosures) {
        
        let url = kPortPrefix+"forgetpwd"
        let param = [
            "phone":phone,
            "code":code,
            "password":password
        ];
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let status:StatusModel = StatusModel.jsonToModelWithData(json)
                if status.status == "success" {
                    handle(success: true, response: "")
                }else{
                    let error:errorModel = errorModel.jsonToModelWithData(json)
                    handle(success: false, response: error.data)
                }
            }
        }
    }
    
    // MARK: 修改个人用户资料
    // userid,avatar,realname,sex(0=>女 1=>男),city,work_life,qq,weixin,weibo
    func savepersonalinfo(
        userid:String,
        avatar:String,
        realname:String,
        sex:String,
        city:String,
        work_life:String,
        qq:String,
        weixin:String,
        weibo:String, handle:ResponseClosures) {
        
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
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let status:StatusModel = StatusModel.jsonToModelWithData(json)
                if status.status == "success" {
                    handle(success: true, response: "")
                }else{
                    let error:errorModel = errorModel.jsonToModelWithData(json)
                    handle(success: false, response: error.data)
                }
            }
        }
    }
    
    // MARK: 修改企业用户资料
    // userid,avatar,realname,myjob,email,company,qq,weixin,weibo
    func savecompanyinfo(
        userid:String,
        avatar:String,
        realname:String,
        myjob:String,
        email:String,
        company:String,
        qq:String,
        weixin:String,
        weibo:String, handle:ResponseClosures) {
        
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
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let status:StatusModel = StatusModel.jsonToModelWithData(json)
                if status.status == "success" {
                    handle(success: true, response: "")
                }else{
                    let error:errorModel = errorModel.jsonToModelWithData(json)
                    handle(success: false, response: error.data)
                }
            }
        }
    }
    
    // MARK: 上传图片
    func uploadImage(imageName:String, image:UIImage, handle:ResponseClosures) {
        
        let url = kPortPrefix+"uploadavatar"
        
        //修正图片的位置
        let newImage = self.fixOrientation(image)
        //先把图片压缩并转成NSData
        let data = newImage.compressImage(newImage, maxLength: 2048000)

    
        Alamofire.upload(.POST, url, multipartFormData: { multipartFormData in
            
            multipartFormData.appendBodyPart(data: data!, name: "upfile", fileName: imageName, mimeType: "image/png")
            
            }, encodingCompletion: { response in

                switch response {
                case .Success(let request, _, _):
                    request.response(completionHandler: { (request, response, json, error) in
                        print(response)
                        
                        handle(success: true, response: UIImage(data: data!))
                    })
                    
                case .Failure(let encodingError):
                    print(encodingError)
                    handle(success: false, response: nil)
                }
                
        })
    }
    
    // MARK: 修正图片的位置
    func fixOrientation(aImage: UIImage) -> UIImage {
        // No-op if the orientation is already correct
        if aImage.imageOrientation == .Up {
            return aImage
        }
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform: CGAffineTransform = CGAffineTransformIdentity
        switch aImage.imageOrientation {
        case .Down, .DownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
        case .Left, .LeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
        case .Right, .RightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
        default:
            break
        }
        
        switch aImage.imageOrientation {
        case .UpMirrored, .DownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0)
            transform = CGAffineTransformScale(transform, -1, 1)
        case .LeftMirrored, .RightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0)
            transform = CGAffineTransformScale(transform, -1, 1)
        default:
            break
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        
        
        //这里需要注意下CGImageGetBitmapInfo，它的类型是Int32的，CGImageGetBitmapInfo(aImage.CGImage).rawValue，这样写才不会报错
        let ctx: CGContextRef = CGBitmapContextCreate(nil, Int(aImage.size.width), Int(aImage.size.height), CGImageGetBitsPerComponent(aImage.CGImage), 0, CGImageGetColorSpace(aImage.CGImage), CGImageGetBitmapInfo(aImage.CGImage).rawValue)!
        CGContextConcatCTM(ctx, transform)
        switch aImage.imageOrientation {
        case .Left, .LeftMirrored, .Right, .RightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.height, aImage.size.width), aImage.CGImage)
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.width, aImage.size.height), aImage.CGImage)
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg: CGImageRef = CGBitmapContextCreateImage(ctx)!
        let img: UIImage = UIImage(CGImage: cgimg)
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
