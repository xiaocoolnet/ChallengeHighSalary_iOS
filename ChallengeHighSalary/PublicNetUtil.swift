//
//  PublicNetUtil.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/20.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import HandyJSON

class PublicNetUtil: NSObject {
    // MARK: 检测是否收藏
    // userid,object_id,type:1、招聘、2、简历
    func CheckHadFavorite(
        _ userid:String,
        object_id:String,
        type:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"CheckHadFavorite"
        let param = [
            "userid":userid,
            "object_id":object_id,
            "type":type
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!
                if checkCode.status == "success" {
                    handle(true, nil)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK: 收藏
    // userid,object_id,type:1、招聘、2、简历, title,description
    func addfavorite(
        _ userid:String,
        object_id:String,
        type:String,
        title:String,
        description:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"addfavorite"
        let param = [
            "userid":userid,
            "object_id":object_id,
            "type":type,
            "title":title,
            "description":description
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if checkCode.status == "success" {
                    handle(true, nil)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK: 取消收藏
    // userid,object_id(招聘或简历的id),type:(1、招聘、2、简历)
    func cancelfavorite(
        _ userid:String,
        object_id:String,
        type:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"cancelfavorite"
        let param = [
            "userid":userid,
            "object_id":object_id,
            "type":type
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if checkCode.status == "success" {
                    handle(true, nil)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK: 获取收藏列表
    // userid,type(1、招聘、2、简历)
    func getfavoritelist(
        _ userid:String,
        type:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"getfavoritelist"
        let param = [
            "userid":userid,
            "type":type
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if checkCode.status == "success" {
                    if type == "1" {
                        
                        let jobInfoModel = JSONDeserializer<JobInfoModel>.deserializeFrom(dict: json as! NSDictionary?)!


                        handle(true, jobInfoModel.data as AnyObject?)

                    }else{
                        
                        let myResume = JSONDeserializer<ResumeListModel>.deserializeFrom(dict: json as! NSDictionary?)!


                        handle(true, myResume.data as AnyObject?)

                    }
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK: 判断简历是否投递
    // companyid,jobid,userid  
    // 出参：list （data：1已投递，0未投递）
    func ApplyJob_judge(
        _ userid:String,
        companyid:String,
        jobid:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"ApplyJob_judge"
        let param = [
            "userid":userid,
            "companyid":companyid,
            "jobid":jobid
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if checkCode.status == "success" {
                    
                    let checkCode = JSONDeserializer<errorModel>.deserializeFrom(dict: json as! NSDictionary?)!

                    handle(true, checkCode.data as AnyObject?)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK: 获取我的黑名单
    // userid,type=1个人获取被拉黑的企业列表，type=2企业获取被拉黑的个人列表
    func getBlackList(
        _ userid:String,
        type:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"getBlackList"
        let param = [
            "userid":userid,
            "type":type
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!
                
                if checkCode.status == "success" {
                    
                    if type == "1" {
                        
                        let jobInfoModel = JSONDeserializer<BlackList>.deserializeFrom(dict: json as! NSDictionary?)!
                        
                        handle(true, jobInfoModel.data as AnyObject?)
                    }else{
                        
                        let jobInfoModel = JSONDeserializer<BlackList_company>.deserializeFrom(dict: json as! NSDictionary?)!
                        
                        handle(true, jobInfoModel.data as AnyObject?)
                    }
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK: 取消拉黑
    // userid,type(1个人拉黑企业，2企业拉黑个人),blackid(被拉黑用户id,不写则删除全部)
    func delBlackList(
        _ userid:String,
        type:String,
        blackid:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"delBlackList"
        let param = [
            "userid":userid,
            "type":type,
            "blackid":blackid
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!
                
                if checkCode.status == "success" {
                    
                    handle(true, nil)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }

    // MARK: 获取字典列表
    // type
    func getDictionaryList(
        type:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"getDictionaryList"
        let param = [
            "type":type
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!
                
                if checkCode.status == "success" {
                    if type == "1" {
                        
                        let jobInfoModel = JSONDeserializer<JobInfoModel>.deserializeFrom(dict: json as! NSDictionary?)!
                        
                        
                        handle(true, jobInfoModel.data as AnyObject?)
                        
                    }else{
                        
                        let myResume = JSONDeserializer<ResumeListModel>.deserializeFrom(dict: json as! NSDictionary?)!
                        
                        
                        handle(true, myResume.data as AnyObject?)
                        
                    }
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
}
