//
//  CHSModel.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/10/12.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

@objc(MyResumeModel)
class MyResumeModel: D3Model {
    
    var status = ""
    
    var data: MyResumeData?
    
    
}

@objc(MyResumeData)
class MyResumeData: D3Model {
    
    var education: [EducationModel]?
    
    var userid = ""
    
    var work: [WorkModel]?

    var weixin = ""

    var jobstate = ""
    
    var company = ""
    
    var advantage = ""

    var project: [WorkModel]?

    var sex = ""
    
    var city = ""
    
    var realname = ""
    
    var position_type = ""
    
    var work_property = ""
    
    var myjob = ""
    
    var wantsalary = ""
    
    var usertype = ""
    
    var work_life = ""
    
    var email = ""
    
    var phone = ""
    
    var devicestate = ""
    
    var weibo = ""
    
    var photo = ""
    
    var password = ""
    
    var qq = ""
    
    var address = ""
    
    var categories = ""
    
}

@objc(WorkModel)
class WorkModel: D3Model {
    
    var userid = ""
    
    var company_name = ""
    
    var jobtype = ""
    
    var skill = ""
    
    var content = ""
    
    var work_period = ""
    
    var create_time = ""
    
    var company_industry = ""
    
}

@objc(EducationModel)
class EducationModel: D3Model {
    
    var userid = ""
    
    var school = ""
    
    var major = ""
    
    var degree = ""
    
    var time = ""
    
    var experience = ""
    
    var create_time = ""
    
}


