//
//  CHSMiNetUtil.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/28.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import Alamofire

class CHSMiNetUtil: NSObject {
    
    // MARK: 更换手机号
    func updateUserPhone(phone:String, code:String, handle:ResponseClosures) {
        
        let url = kPortPrefix+"UpdateUserPhone"
        let param = [
            "userid":CHSUserInfo.currentUserInfo.userid,
            "phone":phone,
            "code":code
        ];
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let status:StatusModel = StatusModel.jsonToModelWithData(json)
                if status.status == "success" {
                    handle(success: true, response: "")
                }else{
                    handle(success: false, response: "更换手机号失败")
                }
            }
        }
    }
    
    // MARK: 输入旧密码
    func oldpassword(password:String, handle:ResponseClosures) {
        
        let url = kPortPrefix+"applogin"
        let param = [
            "phone":CHSUserInfo.currentUserInfo.phoneNumber,
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
                    handle(success: false, response: "密码错误")
                }
            }
        }
    }
    
    // MARK: 修改密码
    func changePassword(password:String, handle:ResponseClosures) {
        
        let url = kPortPrefix+"changePassword"
        let param = [
            "phone":CHSUserInfo.currentUserInfo.phoneNumber,
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
                    handle(success: false, response: "密码修改失败")
                }
            }
        }
    }
}
