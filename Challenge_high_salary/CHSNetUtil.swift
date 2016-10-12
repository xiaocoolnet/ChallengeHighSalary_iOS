//
//  CHSNetUtil.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/10/12.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import Alamofire

class CHSNetUtil: NSObject {
    // MARK: 发布 求职意向
    // userid,work_property,address,position_type,categories,wantsalary,jobstate
    func PublishIntension(
        userid:String,
        work_property:String,
        address:String,
        position_type:String,
        categories:String,
        wantsalary:String,
        jobstate:String,
        handle:ResponseClosures) {
        
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

    // MARK: 发布 教育经历
    // userid,school,major,degree,time,experience
    func PublishEducation(
        userid:String,
        school:String,
        major:String,
        degree:String,
        time:String,
        experience:String,
        handle:ResponseClosures) {
        
        let url = kPortPrefix+"PublishEducation"
        let param = [
            "userid":userid,
            "school":school,
            "major":major,
            "degree":degree,
            "time":time,
            "experience":experience
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
