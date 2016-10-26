//
//  FTPersonalViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/18.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTPersonalViewController: UIViewController {
    
    var resumeData = MyResumeData()
    
    let collectionBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setSubviews()
        self.loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = true
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: 加载数据
    func loadData() {
        
        PublicNetUtil().CheckHadFavorite(
            CHSUserInfo.currentUserInfo.userid,
            object_id: (self.resumeData.resumes_id ?? "")!,
            type: "2") { (success, response) in
                if success {
                    self.collectionBtn.selected = true
                }else{
                    self.collectionBtn.selected = false
                }
        }
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))
        
        self.title = self.resumeData.realname
        
        // rightBarButtonItems
        let shareBtn = UIButton(frame: CGRectMake(0, 0, 24, 24))
        shareBtn.setImage(UIImage(named: "ic_分享"), forState: .Normal)
        shareBtn.addTarget(self, action: #selector(shareBtnClick), forControlEvents: .TouchUpInside)
        let shareItem = UIBarButtonItem(customView: shareBtn)
        
        collectionBtn.frame = CGRectMake(0, 0, 24, 24)
        collectionBtn.setImage(UIImage(named: "ic_收藏"), forState: .Normal)
        collectionBtn.setImage(UIImage(named: "ic_收藏_sel"), forState: .Selected)
        collectionBtn.addTarget(self, action: #selector(collectionBtnClick), forControlEvents: .TouchUpInside)
        
        let collectionItem = UIBarButtonItem(customView: collectionBtn)
        
        self.navigationItem.rightBarButtonItems = [collectionItem,shareItem]
        
        // MARK: rootScrollView
        let rootScrollView = UIScrollView(frame: CGRectMake(0, 64, screenSize.width, screenSize.height-64-49))
        rootScrollView.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        self.view.addSubview(rootScrollView)
        
        // MARK: 获取联系方式
        let getContectView = UIView(frame: CGRectMake(0, screenSize.height-49, screenSize.width, 49))
        getContectView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(getContectView)
        
        drawLine(getContectView, color: UIColor.lightGrayColor(), fromPoint: CGPointMake(0, 0), toPoint: CGPointMake(screenSize.width, 0), lineWidth: 1/UIScreen.mainScreen().scale, pattern: [10,0])
        
        let getContectBtn = UIButton(frame: CGRectMake(0, (getContectView.frame.size.height-(49-16))/2.0, screenSize.width/2.0, 49-16))
        getContectBtn.backgroundColor = baseColor
        getContectBtn.layer.cornerRadius = getContectBtn.frame.size.height/2.0
        getContectBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        getContectBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        getContectBtn.setTitle("获取联系方式", forState: .Normal)
        getContectBtn.center.x = getContectView.center.x
        getContectView.addSubview(getContectBtn)
        
        // MARK: 概况
        let summaryView = UIView(frame: CGRectMake(10, 8, screenSize.width-20, kHeightScale*174))
        summaryView.layer.cornerRadius = 8
        summaryView.backgroundColor = UIColor.whiteColor()
        rootScrollView.addSubview(summaryView)
        
        let nameLab = UILabel(frame: CGRectMake(8, 10, summaryView.frame.size.width-8-8-50-8, kHeightScale*15))
        nameLab.textColor = baseColor
        nameLab.font = UIFont.boldSystemFontOfSize(16)
        nameLab.text = self.resumeData.realname
        nameLab.sizeToFit()
        summaryView.addSubview(nameLab)
        
        let jobStateLab = UILabel(frame: CGRectMake(CGRectGetMaxX(nameLab.frame)+8, 0, 0, 0))
        jobStateLab.font = UIFont.systemFontOfSize(15)
        jobStateLab.textColor = UIColor.lightGrayColor()
        jobStateLab.text = self.resumeData.jobstate
        jobStateLab.sizeToFit()
        jobStateLab.center.y = nameLab.center.y
        summaryView.addSubview(jobStateLab)
        
        let margin:CGFloat = 5
        
        let addressBtn = UIButton(frame: CGRectMake(8, CGRectGetMaxY(nameLab.frame)+10, screenSize.width, kHeightScale*60))
        addressBtn.setImage(UIImage(named: "ic_地点"), forState: .Normal)
        addressBtn.setTitleColor(UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1), forState: .Normal)
        addressBtn.titleLabel!.font = UIFont.systemFontOfSize(14)
        addressBtn.titleLabel?.numberOfLines = 0
        addressBtn.contentHorizontalAlignment = .Left
        addressBtn.setTitle(self.resumeData.city, forState: .Normal)
        addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        addressBtn.sizeToFit()
        summaryView.addSubview(addressBtn)
        
        let expBtn = UIButton(frame: CGRectMake(CGRectGetMaxX(addressBtn.frame)+8, CGRectGetMaxY(nameLab.frame)+10, screenSize.width, kHeightScale*60))
        expBtn.setImage(UIImage(named: "ic_工作经验"), forState: .Normal)
        expBtn.setTitleColor(UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1), forState: .Normal)
        expBtn.titleLabel!.font = UIFont.systemFontOfSize(14)
        expBtn.titleLabel?.numberOfLines = 0
        expBtn.contentHorizontalAlignment = .Left
        expBtn.setTitle(self.resumeData.work_life, forState: .Normal)
        expBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        expBtn.sizeToFit()
        summaryView.addSubview(expBtn)
        
        let eduBtn = UIButton(frame: CGRectMake(CGRectGetMaxX(expBtn.frame)+8, CGRectGetMaxY(nameLab.frame)+10, screenSize.width, kHeightScale*60))
        eduBtn.setImage(UIImage(named: "ic_学历"), forState: .Normal)
        eduBtn.setTitleColor(UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1), forState: .Normal)
        eduBtn.titleLabel!.font = UIFont.systemFontOfSize(14)
        eduBtn.titleLabel?.numberOfLines = 0
        eduBtn.contentHorizontalAlignment = .Left
        eduBtn.setTitle(self.resumeData.education?.first?.degree, forState: .Normal)
        eduBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        eduBtn.sizeToFit()
        summaryView.addSubview(eduBtn)
        
        let propertyBtn = UIButton(frame: CGRectMake(CGRectGetMaxX(eduBtn.frame)+8, CGRectGetMaxY(nameLab.frame)+10, screenSize.width, kHeightScale*60))
        propertyBtn.setImage(UIImage(named: "ic_全职"), forState: .Normal)
        propertyBtn.setTitleColor(UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1), forState: .Normal)
        propertyBtn.titleLabel!.font = UIFont.systemFontOfSize(14)
        propertyBtn.titleLabel?.numberOfLines = 0
        propertyBtn.contentHorizontalAlignment = .Left
        propertyBtn.setTitle(self.resumeData.work_property, forState: .Normal)
        propertyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        propertyBtn.sizeToFit()
        summaryView.addSubview(propertyBtn)
        
        let headerImg = UIImageView(frame: CGRectMake(summaryView.frame.size.width-8-kHeightScale*50, 10, kHeightScale*50, kHeightScale*50))
        headerImg.layer.cornerRadius = kHeightScale*25
        headerImg.clipsToBounds = true
        headerImg.sd_setImageWithURL(NSURL(string: kImagePrefix+self.resumeData.photo), placeholderImage: nil)
        summaryView.addSubview(headerImg)
        
        let sexImg = UIImageView(frame: CGRectMake(summaryView.frame.size.width-8-kHeightScale*15, CGRectGetMaxY(headerImg.frame)-kHeightScale*10, kHeightScale*15, kHeightScale*15))
        sexImg.image = UIImage(named: self.resumeData.sex == "0" ? "ic_女士":"ic_男士")
        summaryView.addSubview(sexImg)
        
        drawLine(
            summaryView,
            color: UIColor.lightGrayColor(),
            fromPoint: CGPointMake(0, max(CGRectGetMaxY(addressBtn.frame)+10, CGRectGetMaxY(headerImg.frame)+10)),
            toPoint: CGPointMake(summaryView.frame.size.width, max(CGRectGetMaxY(addressBtn.frame)+10, CGRectGetMaxY(headerImg.frame)+10)),
            lineWidth: 1/UIScreen.mainScreen().scale*2,
            pattern: [5,5])
        
        let intentionTagLab_1 = UILabel(frame: CGRectMake(8, max(CGRectGetMaxY(addressBtn.frame)+10, CGRectGetMaxY(headerImg.frame)+10)+1+10, summaryView.frame.size.width, kHeightScale*15))
        intentionTagLab_1.textColor = baseColor
        intentionTagLab_1.font = UIFont.systemFontOfSize(16)
        intentionTagLab_1.text = "求职意向"
        intentionTagLab_1.sizeToFit()
        summaryView.addSubview(intentionTagLab_1)
        
        let intentionLab_1 = UILabel(frame: CGRectMake(CGRectGetMaxX(intentionTagLab_1.frame)+8, max(CGRectGetMaxY(addressBtn.frame)+10, CGRectGetMaxY(headerImg.frame)+10)+1+10, summaryView.frame.size.width, kHeightScale*15))
        intentionLab_1.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        intentionLab_1.font = UIFont.systemFontOfSize(15)
        intentionLab_1.text = self.resumeData.position_type
        intentionLab_1.sizeToFit()
        intentionLab_1.center.y = intentionTagLab_1.center.y
        summaryView.addSubview(intentionLab_1)
        
        let salaryLab = UILabel()
        
        let salaryAttrStr = NSMutableAttributedString(string: "￥ \(self.resumeData.wantsalary)K", attributes: [NSForegroundColorAttributeName:UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1),NSFontAttributeName:UIFont.systemFontOfSize(15)])
        salaryAttrStr.addAttributes([NSForegroundColorAttributeName:baseColor], range: NSMakeRange(0, 1))
        
        salaryLab.attributedText = salaryAttrStr
        salaryLab.sizeToFit()
        salaryLab.center.y = intentionLab_1.center.y
        salaryLab.frame.origin.x = summaryView.frame.size.width-8-salaryLab.frame.size.width
        summaryView.addSubview(salaryLab)
        
        let intentionTagLab_2 = UILabel(frame: CGRectMake(8, CGRectGetMaxY(intentionTagLab_1.frame)+8, summaryView.frame.size.width, kHeightScale*15))
        intentionTagLab_2.textColor = baseColor
        intentionTagLab_2.font = UIFont.systemFontOfSize(16)
        intentionTagLab_2.text = "期望行业"
        intentionTagLab_2.sizeToFit()
        summaryView.addSubview(intentionTagLab_2)
        
        let intentionLab_2 = UILabel(frame: CGRectMake(CGRectGetMaxX(intentionTagLab_2.frame)+8, max(CGRectGetMaxY(addressBtn.frame)+10, CGRectGetMaxY(headerImg.frame)+10)+1+10, summaryView.frame.size.width, kHeightScale*15))
        intentionLab_2.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        intentionLab_2.font = UIFont.systemFontOfSize(15)
        intentionLab_2.text = self.resumeData.categories
        intentionLab_2.sizeToFit()
        intentionLab_2.center.y = intentionTagLab_2.center.y
        summaryView.addSubview(intentionLab_2)
        
//        let intentionTagLab_3 = UILabel(frame: CGRectMake(8, CGRectGetMaxY(intentionTagLab_2.frame)+8, summaryView.frame.size.width, kHeightScale*15))
//        intentionTagLab_3.textColor = baseColor
//        intentionTagLab_3.font = UIFont.systemFontOfSize(16)
//        intentionTagLab_3.text = "求职意向"
//        intentionTagLab_3.sizeToFit()
//        summaryView.addSubview(intentionTagLab_3)
//        
//        let intentionLab_3 = UILabel(frame: CGRectMake(CGRectGetMaxX(intentionTagLab_3.frame)+8, max(CGRectGetMaxY(addressBtn.frame)+10, CGRectGetMaxY(headerImg.frame)+10)+1+10, summaryView.frame.size.width, kHeightScale*15))
//        intentionLab_3.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
//        intentionLab_3.font = UIFont.systemFontOfSize(15)
//        intentionLab_3.text = self.resumeData.jobstate
//        intentionLab_3.sizeToFit()
//        intentionLab_3.center.y = intentionTagLab_3.center.y
//        summaryView.addSubview(intentionLab_3)
        
        summaryView.frame.size.height = CGRectGetMaxY(intentionTagLab_2.frame)+10
        
        // MARK: 教育经历
        let eduView = UIView(frame: CGRectMake(10, CGRectGetMaxY(summaryView.frame)+10, screenSize.width-20, kHeightScale*174))
        eduView.layer.cornerRadius = 8
        eduView.backgroundColor = UIColor.whiteColor()
        rootScrollView.addSubview(eduView)
        
        let eduLab = UILabel(frame: CGRectMake(8, 10, eduView.frame.size.width, kHeightScale*15))
        eduLab.textColor = baseColor
        eduLab.font = UIFont.boldSystemFontOfSize(16)
        eduLab.text = "教育经历"
        eduLab.sizeToFit()
        eduView.addSubview(eduLab)
        
        drawLine(
            eduView,
            color: UIColor.lightGrayColor(),
            fromPoint: CGPointMake(0, CGRectGetMaxY(eduLab.frame)+10),
            toPoint: CGPointMake(eduView.frame.size.width, CGRectGetMaxY(eduLab.frame)+10),
            lineWidth: 1/UIScreen.mainScreen().scale*2,
            pattern: [5,5])
        
        var schoolTagLab_y = CGRectGetMaxY(eduLab.frame)+10+1
        
        for (i,eduModel) in self.resumeData.education!.enumerate() {
            
            let schoolTagLab = UILabel(frame: CGRectMake(8, schoolTagLab_y+10, eduView.frame.size.width, kHeightScale*15))
            schoolTagLab.textColor = UIColor.blackColor()
            schoolTagLab.font = UIFont.systemFontOfSize(16)
            schoolTagLab.text = "就读学校"
            schoolTagLab.sizeToFit()
            eduView.addSubview(schoolTagLab)
            
            let schoolLab = UILabel(frame: CGRectMake(CGRectGetMaxX(schoolTagLab.frame)+8, CGRectGetMaxY(eduLab.frame)+10+1+10, eduView.frame.size.width, kHeightScale*15))
            schoolLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
            schoolLab.font = UIFont.systemFontOfSize(15)
            schoolLab.text = eduModel.school
            schoolLab.sizeToFit()
            schoolLab.center.y = schoolTagLab.center.y
            eduView.addSubview(schoolLab)
            
            let schoolTimeLab = UILabel()
            schoolTimeLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
            schoolTimeLab.font = UIFont.systemFontOfSize(15)
            schoolTimeLab.text = eduModel.time
            schoolTimeLab.sizeToFit()
            schoolTimeLab.center.y = schoolLab.center.y
            schoolTimeLab.frame.origin.x = eduView.frame.size.width-8-schoolTimeLab.frame.size.width
            eduView.addSubview(schoolTimeLab)
            
            let majorTagLab = UILabel(frame: CGRectMake(8, CGRectGetMaxY(schoolTagLab.frame)+8, eduView.frame.size.width, kHeightScale*15))
            majorTagLab.textColor = UIColor.blackColor()
            majorTagLab.font = UIFont.systemFontOfSize(16)
            majorTagLab.text = "所学专业"
            majorTagLab.sizeToFit()
            eduView.addSubview(majorTagLab)
            
            let majorLab = UILabel(frame: CGRectMake(CGRectGetMaxX(majorTagLab.frame)+8, CGRectGetMaxY(eduLab.frame)+10+1+10, eduView.frame.size.width, kHeightScale*15))
            majorLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
            majorLab.font = UIFont.systemFontOfSize(15)
            majorLab.text = eduModel.major
            majorLab.sizeToFit()
            majorLab.center.y = majorTagLab.center.y
            eduView.addSubview(majorLab)
            
            let degreeLab = UILabel()
            degreeLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
            degreeLab.font = UIFont.systemFontOfSize(16)
            degreeLab.text = eduModel.degree
            degreeLab.sizeToFit()
            degreeLab.center.y = majorLab.center.y
            degreeLab.frame.origin.x = eduView.frame.size.width-8-degreeLab.frame.size.width
            eduView.addSubview(degreeLab)
            
            schoolTagLab_y = CGRectGetMaxY(majorTagLab.frame)
            
            if i < self.resumeData.education!.count-1 {
                drawLine(
                    eduView,
                    color: UIColor.lightGrayColor(),
                    fromPoint: CGPointMake(8, CGRectGetMaxY(majorTagLab.frame)+5),
                    toPoint: CGPointMake(eduView.frame.size.width-16, CGRectGetMaxY(majorTagLab.frame)+5),
                    lineWidth: 1/UIScreen.mainScreen().scale,
                    pattern: [10,0])
            }
            
        }
        eduView.frame.size.height = schoolTagLab_y+10
        
        // MARK: 工作经历
        let jobView = UIView(frame: CGRectMake(10, CGRectGetMaxY(eduView.frame)+10, screenSize.width-20, kHeightScale*174))
        jobView.layer.cornerRadius = 8
        jobView.backgroundColor = UIColor.whiteColor()
        rootScrollView.addSubview(jobView)
        
        let jobLab = UILabel(frame: CGRectMake(8, 10, jobView.frame.size.width, kHeightScale*15))
        jobLab.textColor = baseColor
        jobLab.font = UIFont.boldSystemFontOfSize(16)
        jobLab.text = "工作经历"
        jobLab.sizeToFit()
        jobView.addSubview(jobLab)
        
        drawLine(
            jobView,
            color: UIColor.lightGrayColor(),
            fromPoint: CGPointMake(0, CGRectGetMaxY(jobLab.frame)+10),
            toPoint: CGPointMake(jobView.frame.size.width, CGRectGetMaxY(jobLab.frame)+10),
            lineWidth: 1/UIScreen.mainScreen().scale*2,
            pattern: [5,5])
        
        let companyNameLab = UILabel(frame: CGRectMake(8, CGRectGetMaxY(jobLab.frame)+10+1+10, jobView.frame.size.width, kHeightScale*15))
        companyNameLab.textColor = UIColor.blackColor()
        companyNameLab.font = UIFont.systemFontOfSize(16)
        companyNameLab.text = self.resumeData.work?.first?.company_name
        companyNameLab.sizeToFit()
        jobView.addSubview(companyNameLab)
        
        let jobTimeLab = UILabel(frame: CGRectMake(CGRectGetMaxX(companyNameLab.frame)+8, CGRectGetMaxY(jobLab.frame)+10+1+10, jobView.frame.size.width, kHeightScale*15))
        jobTimeLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        jobTimeLab.font = UIFont.systemFontOfSize(15)
        jobTimeLab.text = self.resumeData.work?.first?.work_period
        jobTimeLab.sizeToFit()
        jobTimeLab.center.y = companyNameLab.center.y
        jobTimeLab.frame.origin.x = jobView.frame.size.width-8-jobTimeLab.frame.size.width
        jobView.addSubview(jobTimeLab)
        
        let positionTagLab = UILabel(frame: CGRectMake(8, CGRectGetMaxY(companyNameLab.frame)+8, jobView.frame.size.width, kHeightScale*15))
        positionTagLab.textColor = UIColor.blackColor()
        positionTagLab.font = UIFont.systemFontOfSize(16)
        positionTagLab.text = "工作职位"
        positionTagLab.sizeToFit()
        jobView.addSubview(positionTagLab)
        
        let positionLab = UILabel(frame: CGRectMake(CGRectGetMaxX(positionTagLab.frame)+8, 0, 0, 0))
        positionLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        positionLab.font = UIFont.systemFontOfSize(15)
        positionLab.text = self.resumeData.work?.first?.jobtype
        positionLab.sizeToFit()
        positionLab.center.y = positionTagLab.center.y
        jobView.addSubview(positionLab)
        
        let skillTagLab = UILabel(frame: CGRectMake(8, CGRectGetMaxY(positionTagLab.frame)+8, 0, 0))
        skillTagLab.textColor = UIColor.blackColor()
        skillTagLab.font = UIFont.systemFontOfSize(16)
        skillTagLab.text = "专业技能"
        skillTagLab.sizeToFit()
        jobView.addSubview(skillTagLab)
        
        let cityBtnMargin:CGFloat = 10
        var cityBtnX:CGFloat = CGRectGetMaxX(skillTagLab.frame)+8
        var cityBtnY:CGFloat = skillTagLab.frame.origin.y
        var cityBtnWidth:CGFloat = 0
        let cityBtnHeight:CGFloat = skillTagLab.frame.size.height
        
        for (i,city) in ((self.resumeData.work?.first?.skill.componentsSeparatedByString("-"))! ?? [String]()).enumerate() {
            cityBtnWidth = calculateWidth(city, size: 15, height: cityBtnHeight)+cityBtnMargin
            
            let skillLab = UILabel(frame: CGRectMake(cityBtnX, cityBtnY, cityBtnWidth, cityBtnHeight))
            skillLab.layer.cornerRadius = 6
            skillLab.layer.borderWidth = 1
            skillLab.layer.borderColor = baseColor.CGColor
            skillLab.textColor = baseColor
            skillLab.textAlignment = .Center
            skillLab.font = UIFont.systemFontOfSize(15)
            skillLab.text = city
            //            skillLab.sizeToFit()
            //            skillLab.center.y = skillTagLab.center.y
            //            skillLab.frame.origin.x = jobView.frame.size.width-8-skillLab.frame.size.width
            jobView.addSubview(skillLab)
            
            if i+1 < ((self.resumeData.work?.first?.skill.componentsSeparatedByString("-"))! ?? [String]()).count {
                
                let nextBtnWidth = calculateWidth(((self.resumeData.work?.first?.skill.componentsSeparatedByString("-"))! ?? [String]())[i+1], size: 15, height: cityBtnHeight)+cityBtnMargin
                
                if cityBtnWidth + cityBtnX + cityBtnMargin + nextBtnWidth >= screenSize.width - 20 {
                    cityBtnX = cityBtnMargin
                    cityBtnY = cityBtnHeight + cityBtnY + cityBtnMargin
                }else{
                    
                    cityBtnX = cityBtnWidth + cityBtnX + cityBtnMargin
                }
            }
            
        }
        
        jobView.frame.size.height = cityBtnY+cityBtnHeight+cityBtnMargin+10
        
        // MARK: 项目经验
        let projectView = UIView(frame: CGRectMake(10, CGRectGetMaxY(jobView.frame)+10, screenSize.width-20, kHeightScale*174))
        projectView.layer.cornerRadius = 8
        projectView.backgroundColor = UIColor.whiteColor()
        rootScrollView.addSubview(projectView)
        
        let projectLab = UILabel(frame: CGRectMake(8, 10, 0, 0))
        projectLab.textColor = baseColor
        projectLab.font = UIFont.boldSystemFontOfSize(16)
        projectLab.text = "项目经验"
        projectLab.sizeToFit()
        projectView.addSubview(projectLab)
        
        let projectNameLab = UILabel(frame: CGRectMake(CGRectGetMaxX(projectLab.frame)+8, 0, 0, 0))
        projectNameLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        projectNameLab.font = UIFont.systemFontOfSize(15)
        projectNameLab.text = self.resumeData.project?.first?.project_name
        projectNameLab.sizeToFit()
        projectNameLab.center.y = projectLab.center.y
        projectNameLab.frame.origin.x = projectView.frame.size.width-8-projectNameLab.frame.size.width
        projectView.addSubview(projectNameLab)
        
        drawLine(
            projectView,
            color: UIColor.lightGrayColor(),
            fromPoint: CGPointMake(0, CGRectGetMaxY(projectLab.frame)+10),
            toPoint: CGPointMake(projectView.frame.size.width, CGRectGetMaxY(projectLab.frame)+10),
            lineWidth: 1/UIScreen.mainScreen().scale*2,
            pattern: [5,5])
        
        let projectDescriptionTagLab = UILabel(frame: CGRectMake(8, CGRectGetMaxY(projectLab.frame)+10+1+10, 0, 0))
        projectDescriptionTagLab.textColor = baseColor
        projectDescriptionTagLab.font = UIFont.systemFontOfSize(16)
        projectDescriptionTagLab.text = "项目描述"
        projectDescriptionTagLab.sizeToFit()
        projectView.addSubview(projectDescriptionTagLab)
        
        let projectDescriptionLab = UILabel(frame: CGRectMake(8, CGRectGetMaxY(projectDescriptionTagLab.frame)+8, 0, 0))
        projectDescriptionLab.numberOfLines = 0
        projectDescriptionLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        projectDescriptionLab.font = UIFont.systemFontOfSize(15)
        projectDescriptionLab.text = self.resumeData.project?.first?.description_project
        projectDescriptionLab.sizeToFit()
        projectView.addSubview(projectDescriptionLab)
        
        projectView.frame.size.height = CGRectGetMaxY(projectDescriptionLab.frame)+10
        
        // MARK: 我的优势
        let advantageView = UIView(frame: CGRectMake(10, CGRectGetMaxY(projectView.frame)+10, screenSize.width-20, 0))
        advantageView.layer.cornerRadius = 8
        advantageView.backgroundColor = UIColor.whiteColor()
        rootScrollView.addSubview(advantageView)
        
        let advantageLab = UILabel(frame: CGRectMake(8, 10, 0, 0))
        advantageLab.textColor = baseColor
        advantageLab.font = UIFont.boldSystemFontOfSize(16)
        advantageLab.text = "我的优势"
        advantageLab.sizeToFit()
        advantageView.addSubview(advantageLab)
        
        drawLine(
            advantageView,
            color: UIColor.lightGrayColor(),
            fromPoint: CGPointMake(0, CGRectGetMaxY(advantageLab.frame)+10),
            toPoint: CGPointMake(advantageView.frame.size.width, CGRectGetMaxY(advantageLab.frame)+10),
            lineWidth: 1/UIScreen.mainScreen().scale*2,
            pattern: [5,5])
        
        let advantageDescriptionLab = UILabel(frame: CGRectMake(8, CGRectGetMaxY(advantageLab.frame)+10+1+10, 0, 0))
        advantageDescriptionLab.numberOfLines = 0
        advantageDescriptionLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        advantageDescriptionLab.font = UIFont.systemFontOfSize(15)
        advantageDescriptionLab.text = self.resumeData.advantage
        advantageDescriptionLab.sizeToFit()
        advantageView.addSubview(advantageDescriptionLab)
        
        advantageView.frame.size.height = CGRectGetMaxY(advantageDescriptionLab.frame)+10
        
        rootScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(advantageView.frame)+10)
        
    }
    
    // MARK:- 收藏按钮点击事件
    func collectionBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if collectionBtn.selected {
            // MARK: 取消收藏
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "功能未实现"
            checkCodeHud.hide(true, afterDelay: 1)
        }else{
            
            checkCodeHud.labelText = "正在加入收藏"
            
            PublicNetUtil().addfavorite(
                CHSUserInfo.currentUserInfo.userid,
                object_id: (self.resumeData.resumes_id ?? "")!,
                type: "2",
                title: (self.resumeData.realname ?? "")!,
                description: "") { (success, response) in
                    if success {
                        
                        self.collectionBtn.selected = true
                        
                        checkCodeHud.mode = .Text
                        checkCodeHud.labelText = "已加入收藏列表"
                        checkCodeHud.hide(true, afterDelay: 1)
                    }else{
                        checkCodeHud.mode = .Text
                        checkCodeHud.labelText = "加入收藏列表失败"
                        checkCodeHud.hide(true, afterDelay: 1)
                    }
            }
        }
    }
    
    // MARK:- 分享视图
    func shareBtnClick() {
        let imageArray = ["ic_share_qq","ic_share_wechat","ic_share_friendzone"]
        let imageNameArray = ["QQ","微信","朋友圈"]
        
        let bgView = UIButton(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
        bgView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        bgView.tag = 101
        bgView.addTarget(self, action: #selector(shareViewHide(_:)), forControlEvents: .TouchUpInside)
        UIApplication.sharedApplication().keyWindow!.addSubview(bgView)
        
        let bottomView = UIView(frame: CGRectMake(0, CGRectGetMaxY(bgView.frame), screenSize.width, screenSize.height*0.4))
        bottomView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
        bgView.addSubview(bottomView)
        
        let shareBtnWidth:CGFloat = kWidthScale*70
        //        let maxMargin:CGFloat = shareBtnWidth/3.0
        let shareBtnCount:Int = 3 // 每行的按钮数
        let margin = (screenSize.width-CGFloat(shareBtnCount)*shareBtnWidth)/CGFloat(shareBtnCount+1)
        let margin_y:CGFloat = 20
        
        let labelHeight = shareBtnWidth/3.0
        
        var labelMaxY:CGFloat = 0
        
        for (i,_) in imageArray.enumerate() {
            
            let shareBtn_1 = UIButton(frame: CGRectMake(
                margin*(CGFloat(i%shareBtnCount)+1)+shareBtnWidth*CGFloat(i%shareBtnCount),
                margin_y*(CGFloat(i/shareBtnCount)+1)+(shareBtnWidth+margin_y+labelHeight)*CGFloat(i/shareBtnCount),
                shareBtnWidth,
                shareBtnWidth))
            shareBtn_1.layer.cornerRadius = shareBtnWidth/2.0
            shareBtn_1.backgroundColor = UIColor.blueColor()
            shareBtn_1.setImage(UIImage(named: imageArray[i]), forState: .Normal)
            shareBtn_1.tag = 1000+i
            //            shareBtn_1.addTarget(self, action: #selector(shareBtnClick(_:)), forControlEvents: .TouchUpInside)
            bottomView.addSubview(shareBtn_1)
            print("挑战高薪-机会-个人信息页-分享视图-按钮 \(i) frame == \(shareBtn_1.frame)")
            
            let shareLab_1 = UILabel(frame: CGRectMake(
                CGRectGetMinX(shareBtn_1.frame)-margin/2.0,
                CGRectGetMaxY(shareBtn_1.frame)+margin_y/2.0,
                shareBtnWidth+margin,
                labelHeight))
            shareLab_1.textColor = UIColor.grayColor()
            shareLab_1.font = UIFont.systemFontOfSize(14)
            shareLab_1.textAlignment = .Center
            shareLab_1.text = imageNameArray[i]
            bottomView.addSubview(shareLab_1)
            
            labelMaxY = CGRectGetMaxY(shareLab_1.frame)
        }
        
        let line = UIView(frame: CGRectMake(0, labelMaxY+margin_y/2.0, screenSize.width, 1))
        line.backgroundColor = UIColor.lightGrayColor()
        bottomView.addSubview(line)
        
        let cancelBtnHeight = shareBtnWidth*0.8
        
        let cancelBtn = UIButton(frame: CGRectMake(0, CGRectGetMaxY(line.frame), screenSize.width, cancelBtnHeight))
        cancelBtn.backgroundColor = UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1)
        cancelBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        cancelBtn.setTitle("取消", forState: .Normal)
        cancelBtn.tag = 102
        cancelBtn.addTarget(self, action: #selector(shareViewHide(_:)), forControlEvents: .TouchUpInside)
        bottomView.addSubview(cancelBtn)
        
        bottomView.frame.size.height = CGRectGetMaxY(cancelBtn.frame)
        
        UIView.animateWithDuration(0.5) {
            bottomView.frame.origin.y = screenSize.height - CGRectGetMaxY(cancelBtn.frame)
        }
    }
    
    // 分享视图取消事件
    func shareViewHide(shareView:UIButton) {
        if shareView.tag == 102 {
            shareView.superview!.superview!.removeFromSuperview()
        }else{
            shareView.removeFromSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
