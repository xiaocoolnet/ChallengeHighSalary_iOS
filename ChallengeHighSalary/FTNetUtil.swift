//
//  FTNetUtil.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/9.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import HandyJSON

class FTNetUtil: NSObject {
    
    // MARK: 获取简历列表
    // userid,logo,company_name,company_web,industry,count,financing
    func getResumeList(
        _ userid:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"getResumeList"
        let param = [
            "userid":userid
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!
//                let checkCode:StatusModel = StatusModel.jsonToModel(json)
                if checkCode.status == "success" {
                    let resumeListModel = JSONDeserializer<ResumeListModel>.deserializeFrom(dict: json as! NSDictionary?)!

//                    let resumeListModel:ResumeListModel = ResumeListModel.jsonToModel(json)
                    
                    handle(true, resumeListModel.data as AnyObject?)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK: 获取我的企业信息
    // userid,logo,company_name,company_web,industry,count,financing
    func getMyCompany_info(
        _ userid:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"getMyCompany_info"
        let param = [
            "userid":userid
            ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if checkCode.status == "success" {
//                    let company_infoModel:Company_infoModel = Company_infoModel.jsonToModel(json)
                    
                    let company_infoModel = JSONDeserializer<Company_infoModel>.deserializeFrom(dict: json as! NSDictionary?)!

                    handle(true, company_infoModel.data)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK: 添加公司信息
    // userid,logo,company_name,company_web,industry,count,financing
    func company_info(
        _ userid:String,
        logo:String,
        company_name:String,
        company_web:String,
        industry:String,
        count:String,
        financing:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"company_info"
        let param = [
            "userid":userid,
            "logo":logo,
            "company_name":company_name,
            "company_web":company_web,
            "industry":industry,
            "count":count,
            "financing":financing,
            ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

//                let checkCode:StatusModel = StatusModel.jsonToModel(json)
                if checkCode.status == "success" {
                    handle(true, nil)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK: 发布招聘岗位
    // userid,jobtype,title(职位名称),skill,salary,experience,education,city,address,description
    func publishjob(
        _ userid:String,
        jobtype:String,
        title:String,
        skill:String,
        salary:String,
        experience:String,
        education:String,
        city:String,
        address:String,
        description_job:String, handle:@escaping ResponseClosures) {

        let url = kPortPrefix+"publishjob"
        let param = [
            "userid":userid,
            "jobtype":jobtype,
            "title":title,
            "skill":skill,
            "salary":salary,
            "experience":experience,
            "education":education,
            "city":city,
            "address":address,
            "description_job":description_job,
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
    
    // MARK: 获取我的面试邀请列表
    // userid,type(不填为全部,0待面试,1已结束),pager分页
    func getMyInvited(
        _ userid:String,
        type:String,
        pager:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"getMyInvited"
        let param = [
            "userid":userid,
            "type":type,
            "pager":pager
        ]
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!
                //                let checkCode:StatusModel = StatusModel.jsonToModel(json)
                if checkCode.status == "success" {
                    let myInvitedList = JSONDeserializer<MyInvitedListModel>.deserializeFrom(dict: json as! NSDictionary?)!
                    
                    //                    let resumeListModel:ResumeListModel = ResumeListModel.jsonToModel(json)
                    
                    handle(true, myInvitedList.data as AnyObject?)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }

}
