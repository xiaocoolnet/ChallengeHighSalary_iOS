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
    
    // MARK: 获取企业认证状态
    // list (status：1认证成功，0未认证，-1认证失败，-2正在审核中)
    func getCompanyCertify(
        _ userid:String,
        handle:@escaping ResponseClosures) {
        
        let url = kPortPrefix+"getCompanyCertify"
        let param = [
            "userid":userid
            ];
        NetUtil.net.request(.requestTypeGet, URLString: url, Parameter: param as [String : AnyObject]?) { (json, error) in
            
            if(error != nil){
                handle(false, error.debugDescription as AnyObject?)
            }else{
                let checkCode = JSONDeserializer<StatusModel>.deserializeFrom(dict: json as! NSDictionary?)!

                if checkCode.status == "success" {
                    
                    let companyCertifyModel = JSONDeserializer<CompanyCertifyModel>.deserializeFrom(dict: json as! NSDictionary?)!
                    
                    handle(true, companyCertifyModel.data)
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
                    
                    CHSCompanyInfo.currentCompanyInfo.company_name = (company_infoModel.data?.company_name ?? "")!
                    
                    CHSCompanyInfo.currentCompanyInfo.financing = (company_infoModel.data?.financing ?? "")!
                    
                    CHSCompanyInfo.currentCompanyInfo.jobs = company_infoModel.data?.jobs
                    
                    CHSCompanyInfo.currentCompanyInfo.count = (company_infoModel.data?.count ?? "")!
                    
                    CHSCompanyInfo.currentCompanyInfo.companyid = (company_infoModel.data?.companyid)!
                    
                    CHSCompanyInfo.currentCompanyInfo.industry = (company_infoModel.data?.industry ?? "")!
                    
                    CHSCompanyInfo.currentCompanyInfo.logo = (company_infoModel.data?.logo ?? "")!
                    
                    CHSCompanyInfo.currentCompanyInfo.company_web = (company_infoModel.data?.company_web ?? "")!
                    
                    
                    CHSCompanyInfo.currentCompanyInfo.company_score = (company_infoModel.data?.company_score ?? "")!
                    
                    CHSCompanyInfo.currentCompanyInfo.authentication = (company_infoModel.data?.authentication ?? "")!
                    
                    CHSCompanyInfo.currentCompanyInfo.distance = (company_infoModel.data?.distance ?? "")!
                    
                    CHSCompanyInfo.currentCompanyInfo.creat_time = (company_infoModel.data?.creat_time ?? "")!
                    
                    CHSCompanyInfo.currentCompanyInfo.com_introduce = (company_infoModel.data?.com_introduce ?? "")!
                    
                    CHSCompanyInfo.currentCompanyInfo.produte_info = (company_infoModel.data?.produte_info ?? "")!
                    
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
                    
                    CHSCompanyInfo.currentCompanyInfo.logo = logo
                    CHSCompanyInfo.currentCompanyInfo.company_name = company_name
                    CHSCompanyInfo.currentCompanyInfo.company_web = company_web
                    CHSCompanyInfo.currentCompanyInfo.industry = industry
                    CHSCompanyInfo.currentCompanyInfo.count = count
                    CHSCompanyInfo.currentCompanyInfo.financing = financing
                    
                    handle(true, nil)
                }else{
                    
                    handle(false, nil)
                }
            }
        }
    }
    
    // MARK: 发布招聘岗位
    // userid,jobtype,title(职位名称),skill,salary,experience,education,city,address,description
    // userid,jobtype职位类型,title(职位名称),skill技能要求,salary薪资范围,work_property工作性质,experience经验要求,education学历要求,city工作城市,address工作地点,description_job职位描述,welfare(福利待遇)
    func publishjob(
        _ userid:String,
        jobtype:String,
        title:String,
        skill:String,
        salary:String,
        work_property:String,
        experience:String,
        education:String,
        city:String,
        address:String,
        description_job:String,
        welfare:String,
        handle:@escaping ResponseClosures) {

        let url = kPortPrefix+"publishjob"
        let param = [
            "userid":userid,
            "jobtype":jobtype,
            "title":title,
            "skill":skill,
            "salary":salary,
            "work_property":work_property,
            "experience":experience,
            "education":education,
            "city":city,
            "address":address,
            "description_job":description_job,
            "welfare":welfare
        ]
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
