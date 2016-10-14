//
//  FTNetUtil.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/9.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import Alamofire

class FTNetUtil: NSObject {
    // MARK: 发布招聘岗位
    // userid,jobtype,title(职位名称),skill,salary,experience,education,city,address,description
    func publishjob(
        userid:String,
        jobtype:String,
        title:String,
        skill:String,
        salary:String,
        experience:String,
        education:String,
        city:String,
        address:String,
        description:String, handle:ResponseClosures) {

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
            "description":description,
        ];
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let checkCode:StatusModel = StatusModel.jsonToModelWithData(json)
                if checkCode.status == "success" {
                    handle(success: true, response: nil)
                }else{
                    
                    handle(success: false, response: nil)
                }
            }
        }
    }
    
    // MARK: 添加公司信息
    // userid,logo,company_name,company_web,industry,count,financing
    func company_info(
        userid:String,
        logo:String,
        company_name:String,
        company_web:String,
        industry:String,
        count:String,
        financing:String,
        handle:ResponseClosures) {
        
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
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let checkCode:StatusModel = StatusModel.jsonToModelWithData(json)
                if checkCode.status == "success" {
                    handle(success: true, response: nil)
                }else{
                    
                    handle(success: false, response: nil)
                }
            }
        }
    }
}
