//
//  CHSMiNetUtil.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/28.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import HandyJSON

class CHSMiNetUtil: NSObject {
    
    // MARK: 更换手机号
    func updateUserPhone(_ phone:String, code:String, handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"UpdateUserPhone"
        let param = [
            "userid":CHSUserInfo.currentUserInfo.userid,
            "phone":phone,
            "code":code
        ]
        
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                let status = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if status.status == "success" {
                    handle(true, "" as AnyObject?)
                }else{
                    handle(false, "更换手机号失败" as AnyObject?)
                }
            }
        }
    }
    
    // MARK: 输入旧密码
    func oldpassword(_ password:String, handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"applogin"
        let param = [
            "phone":CHSUserInfo.currentUserInfo.phoneNumber,
            "password":password
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                let status = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

//                let status:StatusModel = StatusModel.jsonToModel(json)
                if status.status == "success" {
                    handle(true, "" as AnyObject?)
                }else{
                    handle(false, "密码错误" as AnyObject?)
                }
            }
        }
    }
    
    // MARK: 修改密码
    func changePassword(_ password:String, handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"Modify_password"
        let param = [
            "phone":CHSUserInfo.currentUserInfo.phoneNumber,
            "password":password
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                let status = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

//                let status:StatusModel = StatusModel.jsonToModel(json)
                if status.status == "success" {
                    handle(true, "" as AnyObject?)
                }else{
                    
                    let error = JSONDeserializer<errorModel>.deserializeFrom(dict: json as! NSDictionary?)!
                    if error.data == "password repeat" {
                        handle(false, "新密码与旧密码相同" as AnyObject?)

                    }else{
                        
                        handle(false, "密码修改失败" as AnyObject?)
                    }
                    
                }
            }
        }
    }
}
