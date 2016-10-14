//
//  CHSModel.swift
//  ChallengeHighSalary
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

    var project: [ProjectModel]?

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

@objc(ProjectModel)
class ProjectModel: D3Model {

    var project_description = ""

    var create_time = ""

    var userid = ""

    var start_time = ""

    var project_name = ""

    var end_time = ""

}

