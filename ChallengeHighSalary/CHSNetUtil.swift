//
//  CHSNetUtil.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/12.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import HandyJSON

class CHSNetUtil: NSObject {
    
    // MARK: 获取招聘列表
    // userid
    func getjoblist(
        _ userid:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"getjoblist"
        let param = [
            "userid":userid
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error?.description as AnyObject?)
            }else{
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

//                let checkCode:StatusModel = StatusModel.jsonToModel(json)
                if checkCode.status == "success" {
                    let jobInfoModel = JSONDeserializer<JobInfoModel>.deserializeFrom(dict: json as! NSDictionary?)!

//                    let jobInfoModel:JobInfoModel = JobInfoModel.jsonToModel(json)
                    handle(true, jobInfoModel.data as AnyObject?)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK: 获取获取企业信息列表
    // userid
    func getCompanyList(_ handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"getCompanyList"
        
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: nil) { (json, error) in
            
            if(error != nil){
                handle(false, error?.description as AnyObject?)
            }else{
                
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if checkCode.status == "success" {
                    
                    let jobInfoModel = JSONDeserializer<CompanyListModel>.deserializeFrom(dict: json as! NSDictionary?)!

                    handle(true, jobInfoModel.data as AnyObject?)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK: 获取我的简历
    // userid
    func getMyResume(
        _ userid:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"getMyResume"
        let param = [
            "userid":userid
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error?.description as AnyObject?)
            }else{
                
                let statusModel = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

                
                if statusModel.status == "success" {
                    
                    let myResume = JSONDeserializer<MyResumeModel>.deserializeFrom(dict: json as! NSDictionary?)!
                    
                    CHSUserInfo.currentUserInfo.userid = (myResume.data?.userid)!
                    CHSUserInfo.currentUserInfo.realName = (myResume.data?.realname)!
                    CHSUserInfo.currentUserInfo.usertype = (myResume.data?.usertype)!
                    CHSUserInfo.currentUserInfo.phoneNumber = (myResume.data?.phone)!
                    CHSUserInfo.currentUserInfo.sex = (myResume.data?.sex)!
                    CHSUserInfo.currentUserInfo.email = (myResume.data?.email)!
                    CHSUserInfo.currentUserInfo.qqNumber = (myResume.data?.qq)!
                    CHSUserInfo.currentUserInfo.weixinNumber = (myResume.data?.weixin)!
                    CHSUserInfo.currentUserInfo.avatar = (myResume.data?.photo)!
                    CHSUserInfo.currentUserInfo.devicestate = (myResume.data?.devicestate)!
                    CHSUserInfo.currentUserInfo.city = (myResume.data?.city)!
                    CHSUserInfo.currentUserInfo.weiboNumber = (myResume.data?.weibo)!
                    CHSUserInfo.currentUserInfo.work_life = (myResume.data?.work_life)!
                    CHSUserInfo.currentUserInfo.company = (myResume.data?.company)!
                    CHSUserInfo.currentUserInfo.myjob = (myResume.data?.myjob)!
                    CHSUserInfo.currentUserInfo.work_property = (myResume.data?.work_property)!
                    CHSUserInfo.currentUserInfo.address = (myResume.data?.address)!
                    CHSUserInfo.currentUserInfo.position_type = (myResume.data?.position_type)!
                    CHSUserInfo.currentUserInfo.categories = (myResume.data?.categories)!
                    CHSUserInfo.currentUserInfo.wantsalary = (myResume.data?.wantsalary)!
                    CHSUserInfo.currentUserInfo.jobstate = (myResume.data?.jobstate)!
                    CHSUserInfo.currentUserInfo.advantage = (myResume.data?.advantage)!
                    
                    CHSUserInfo.currentUserInfo.education = myResume.data?.education
                    CHSUserInfo.currentUserInfo.work = myResume.data?.work
                    CHSUserInfo.currentUserInfo.project = myResume.data?.project
                    
                    handle(true, nil)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK: 发布 求职意向
    // userid,work_property,address,position_type,categories,wantsalary,jobstate
    func PublishIntension(
        _ userid:String,
        work_property:String,
        address:String,
        position_type:String,
        categories:String,
        wantsalary:String,
        jobstate:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"PublishIntension"
        let param = [
            "userid":userid,
            "work_property":work_property,
            "address":address,
            "position_type":position_type,
            "categories":categories,
            "wantsalary":wantsalary,
            "jobstate":jobstate
            ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error?.description as AnyObject?)
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

    // MARK: 发布 教育经历
    // userid,school,major,degree,time,experience
    func PublishEducation(
        _ userid:String,
        school:String,
        major:String,
        degree:String,
        time:String,
        experience:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"PublishEducation"
        let param = [
            "userid":userid,
            "school":school,
            "major":major,
            "degree":degree,
            "time":time,
            "experience":experience
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error?.description as AnyObject?)
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
    
    // MARK: 发布 工作经历
    // userid,company_name,company_industry,jobtype,skill,work_period,content
    func PublishWork(
        _ userid:String,
        company_name:String,
        company_industry:String,
        jobtype:String,
        skill:String,
        work_period:String,
        content:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"PublishWork"
        let param = [
            "userid":userid,
            "company_name":company_name,
            "company_industry":company_industry,
            "jobtype":jobtype,
            "skill":skill,
            "work_period":work_period,
            "content":content
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error?.description as AnyObject?)
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
    
    // MARK: 发布 项目经验
    // userid,project_name,start_time,end_time,description
    func PublishProject(
        _ userid:String,
        project_name:String,
        start_time:String,
        end_time:String,
        description_project:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"PublishProject"
        let param = [
            "userid":userid,
            "project_name":project_name,
            "start_time":start_time,
            "end_time":end_time,
            "description_project":description_project
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error?.description as AnyObject?)
            }else{
                
                let checkCode = JSONDeserializer<CheckphoneModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if checkCode.status == "success" {
                    
                    CHSUserInfo.currentUserInfo.project?.first?.project_name =  project_name
                    CHSUserInfo.currentUserInfo.project?.first?.start_time =  start_time
                    CHSUserInfo.currentUserInfo.project?.first?.end_time =  end_time
                    CHSUserInfo.currentUserInfo.project?.first?.description_project =  description_project
                    
                    handle(true, nil)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK: 发布 我的优势
    // userid,advantage
    func PublishAdvantage(
        _ userid:String,
        advantage:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"PublishAdvantage"
        let param = [
            "userid":userid,
            "advantage":advantage
        ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error?.description as AnyObject?)
            }else{
                
                let checkCode = JSONDeserializer<CheckphoneModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if checkCode.status == "success" {
                    
                    CHSUserInfo.currentUserInfo.advantage =  advantage
                    
                    handle(true, nil)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
}
