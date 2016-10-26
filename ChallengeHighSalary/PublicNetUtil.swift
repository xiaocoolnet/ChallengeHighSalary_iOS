//
//  PublicNetUtil.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/20.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import Alamofire

class PublicNetUtil: NSObject {
    // MARK: 检测是否收藏
    // userid,object_id,type:1、招聘、2、简历
    func CheckHadFavorite(
        userid:String,
        object_id:String,
        type:String,
        handle:ResponseClosures) {
        
        let url = kPortPrefix+"CheckHadFavorite"
        let param = [
            "userid":userid,
            "object_id":object_id,
            "type":type
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
    
    // MARK: 收藏
    // userid,object_id,type:1、招聘、2、简历, title,description
    func addfavorite(
        userid:String,
        object_id:String,
        type:String,
        title:String,
        description:String,
        handle:ResponseClosures) {
        
        let url = kPortPrefix+"addfavorite"
        let param = [
            "userid":userid,
            "object_id":object_id,
            "type":type,
            "title":title,
            "description":description
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
    
    // MARK: 取消收藏
    // userid,object_id(招聘或简历的id),type:(1、招聘、2、简历)
    func cancelfavorite(
        userid:String,
        object_id:String,
        type:String,
        handle:ResponseClosures) {
        
        let url = kPortPrefix+"cancelfavorite"
        let param = [
            "userid":userid,
            "object_id":object_id,
            "type":type
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
    
    // MARK: 获取收藏列表
    // userid,type(1、招聘、2、简历)
    func getfavoritelist(
        userid:String,
        type:String,
        handle:ResponseClosures) {
        
        let url = kPortPrefix+"getfavoritelist"
        let param = [
            "userid":userid,
            "type":type
        ];
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let checkCode:StatusModel = StatusModel.jsonToModelWithData(json)
                if checkCode.status == "success" {
                    if type == "1" {
                        
                        let jobInfoModel:JobInfoModel = JobInfoModel.jsonToModelWithData(json)

                        handle(success: true, response: jobInfoModel.data)

                    }else{
                        let myResume:MyResumeModel = MyResumeModel.jsonToModelWithData(json)
                        handle(success: true, response: myResume.data)

                    }
                }else{
                    
                    handle(success: false, response: nil)
                }
            }
        }
    }
    
    // MARK: 判断简历是否投递
    // companyid,jobid,userid  
    // 出参：list （data：1已投递，0未投递）
    func ApplyJob_judge(
        userid:String,
        companyid:String,
        jobid:String,
        handle:ResponseClosures) {
        
        let url = kPortPrefix+"ApplyJob_judge"
        let param = [
            "userid":userid,
            "companyid":companyid,
            "jobid":jobid
        ];
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            
            if(error != nil){
                handle(success: false, response: error?.description)
            }else{
                let checkCode:StatusModel = StatusModel.jsonToModelWithData(json)
                if checkCode.status == "success" {
                    let checkCode:errorModel = errorModel.jsonToModelWithData(json)
                    handle(success: true, response: checkCode.data)
                }else{
                    
                    handle(success: false, response: nil)
                }
            }
        }
    }
}
