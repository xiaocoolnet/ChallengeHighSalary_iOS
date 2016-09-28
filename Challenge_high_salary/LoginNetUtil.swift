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
    
    // MARK:- 待检查 注册
    func AppRegister(phone:String, handle:ResponseClosures) {
        
        let url = kPortPrefix+"AppRegister"
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

                    CHSUserInfo.currentUserInfo.phoneNumber = (login.data?.phone)!
                    CHSUserInfo.currentUserInfo.userid = (login.data?.userid)!

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
