//
//  CHSUserInfo.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/28.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSUserInfo {
    
    var userid = ""
    var usertype = ""
    var phoneNumber = ""
    var realName = ""
    var sex = ""
    var email = ""
    var qqNumber = ""
    var weixinNumber = ""
    var avatar = ""
    var devicestate = ""
    var city = ""
    var weiboNumber = ""
    var work_life = ""
    var company = ""
    var myjob = ""
    var advantage = ""
    var work_property = ""//工作性质
    var address = ""//工作地点
    var position_type = ""//职位类型
    var categories = ""//行业类别
    var wantsalary = ""//期望薪资
    var jobstate = ""//工作状态
    
//    var school = ""//学校
//    var major = ""//专业
//    var degree = ""//学历
//    var time = ""//时间段
//    var experience = ""//在校经历
    
    
    var work: [WorkModel]?

    var education: [EducationModel]?
    
    var project : [ProjectModel]?
    
    
    
//    userid,work_property,address,position_type,categories,wantsalary,jobstate
    var userName = ""
//    var address = ""
    var time = ""
    var level = ""
    var attentionCount = ""
    var fansCount = ""
    var money = ""
    var birthday = ""
    var school = ""
    var major = ""
//    var education = ""
    var score = ""
    var all_information = ""
    
    
    static let currentUserInfo = CHSUserInfo()
    fileprivate init() {
        
    }
    
    class func initUserInfo() {
        CHSUserInfo.currentUserInfo.userid = ""
        CHSUserInfo.currentUserInfo.usertype = ""
        CHSUserInfo.currentUserInfo.phoneNumber = ""
        CHSUserInfo.currentUserInfo.realName = ""
        CHSUserInfo.currentUserInfo.sex = ""
        CHSUserInfo.currentUserInfo.email = ""
        CHSUserInfo.currentUserInfo.qqNumber = ""
        CHSUserInfo.currentUserInfo.weixinNumber = ""
        CHSUserInfo.currentUserInfo.avatar = ""
        CHSUserInfo.currentUserInfo.devicestate = ""
        CHSUserInfo.currentUserInfo.city = ""
        CHSUserInfo.currentUserInfo.weiboNumber = ""
        CHSUserInfo.currentUserInfo.work_life = ""
        CHSUserInfo.currentUserInfo.company = ""
        CHSUserInfo.currentUserInfo.myjob = ""
        CHSUserInfo.currentUserInfo.advantage = ""
        CHSUserInfo.currentUserInfo.work_property = ""//工作性质
        CHSUserInfo.currentUserInfo.address = ""//工作地点
        CHSUserInfo.currentUserInfo.position_type = ""//职位类型
        CHSUserInfo.currentUserInfo.categories = ""//行业类别
        CHSUserInfo.currentUserInfo.wantsalary = ""//期望薪资
        CHSUserInfo.currentUserInfo.jobstate = ""//工作状态
       
        CHSUserInfo.currentUserInfo.work = [WorkModel]()
        
        CHSUserInfo.currentUserInfo.education = [EducationModel]()
        
        CHSUserInfo.currentUserInfo.project = [ProjectModel]()
        
        CHSUserInfo.currentUserInfo.userName = ""
        CHSUserInfo.currentUserInfo.time = ""
        CHSUserInfo.currentUserInfo.level = ""
        CHSUserInfo.currentUserInfo.attentionCount = ""
        CHSUserInfo.currentUserInfo.fansCount = ""
        CHSUserInfo.currentUserInfo.money = ""
        CHSUserInfo.currentUserInfo.birthday = ""
        CHSUserInfo.currentUserInfo.school = ""
        CHSUserInfo.currentUserInfo.major = ""
        CHSUserInfo.currentUserInfo.score = ""
        CHSUserInfo.currentUserInfo.all_information = ""
    }
    
}

class CHSCompanyInfo {
    
    
    static let currentCompanyInfo = Company_infoDataModel()
    fileprivate init() {
        
    }
    
}

class UserInfoWork {

    var userid = ""

    var company_name = ""

    var jobtype = ""

    var skill = ""

    var content = ""

    var work_period = ""

    var create_time = ""

    var company_industry = ""

}

class UserInfoEducation {

    var userid = ""

    var school = ""

    var major = ""

    var degree = ""

    var time = ""

    var experience = ""

    var create_time = ""

}

