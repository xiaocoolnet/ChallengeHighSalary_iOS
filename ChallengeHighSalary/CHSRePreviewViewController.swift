//
//  CHSRePreviewViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/25.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSRePreviewViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.title = "简历预览"
        
        let rootScrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64))
        rootScrollView.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        self.view.addSubview(rootScrollView)
        
        let titleLab = UILabel(frame: CGRect(x: 8, y: 0, width: screenSize.width, height: kHeightScale*35))
        titleLab.font = UIFont.systemFont(ofSize: 15)
        titleLab.textColor = UIColor(red: 149/255.0, green: 149/255.0, blue: 149/255.0, alpha: 1)
        titleLab.text = "我的简历"
        rootScrollView.addSubview(titleLab)
        
        // MARK: 概况
        let summaryView = UIView(frame: CGRect(x: 10, y: titleLab.frame.maxY, width: screenSize.width-20, height: kHeightScale*174))
        summaryView.layer.cornerRadius = 8
        summaryView.backgroundColor = UIColor.white
        rootScrollView.addSubview(summaryView)
        
        let nameLab = UILabel(frame: CGRect(x: 8, y: 10, width: summaryView.frame.size.width-8-8-50-8, height: kHeightScale*15))
        nameLab.textColor = baseColor
        nameLab.font = UIFont.boldSystemFont(ofSize: 16)
        nameLab.text = CHSUserInfo.currentUserInfo.realName
        summaryView.addSubview(nameLab)
        
        let margin:CGFloat = 5
        
        let addressBtn = UIButton(frame: CGRect(x: 8, y: nameLab.frame.maxY+10, width: screenSize.width, height: kHeightScale*60))
        addressBtn.setImage(UIImage(named: "ic_地点"), for: UIControlState())
        addressBtn.setTitleColor(UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1), for: UIControlState())
        addressBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        addressBtn.titleLabel?.numberOfLines = 0
        addressBtn.contentHorizontalAlignment = .left
        addressBtn.setTitle(CHSUserInfo.currentUserInfo.city, for: UIControlState())
        addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        addressBtn.sizeToFit()
        summaryView.addSubview(addressBtn)
        
        let expBtn = UIButton(frame: CGRect(x: addressBtn.frame.maxX+8, y: nameLab.frame.maxY+10, width: screenSize.width, height: kHeightScale*60))
        expBtn.setImage(UIImage(named: "ic_工作经验"), for: UIControlState())
        expBtn.setTitleColor(UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1), for: UIControlState())
        expBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        expBtn.titleLabel?.numberOfLines = 0
        expBtn.contentHorizontalAlignment = .left
        expBtn.setTitle(CHSUserInfo.currentUserInfo.work_life, for: UIControlState())
        expBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        expBtn.sizeToFit()
        summaryView.addSubview(expBtn)
        
        let eduBtn = UIButton(frame: CGRect(x: expBtn.frame.maxX+8, y: nameLab.frame.maxY+10, width: screenSize.width, height: kHeightScale*60))
        eduBtn.setImage(UIImage(named: "ic_学历"), for: UIControlState())
        eduBtn.setTitleColor(UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1), for: UIControlState())
        eduBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        eduBtn.titleLabel?.numberOfLines = 0
        eduBtn.contentHorizontalAlignment = .left
        eduBtn.setTitle(CHSUserInfo.currentUserInfo.education?.first?.degree, for: UIControlState())
        eduBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        eduBtn.sizeToFit()
        summaryView.addSubview(eduBtn)
        
        let propertyBtn = UIButton(frame: CGRect(x: eduBtn.frame.maxX+8, y: nameLab.frame.maxY+10, width: screenSize.width, height: kHeightScale*60))
        propertyBtn.setImage(UIImage(named: "ic_全职"), for: UIControlState())
        propertyBtn.setTitleColor(UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1), for: UIControlState())
        propertyBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        propertyBtn.titleLabel?.numberOfLines = 0
        propertyBtn.contentHorizontalAlignment = .left
        propertyBtn.setTitle(CHSUserInfo.currentUserInfo.work_property, for: UIControlState())
        propertyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        propertyBtn.sizeToFit()
        summaryView.addSubview(propertyBtn)
        
        let headerImg = UIImageView(frame: CGRect(x: summaryView.frame.size.width-8-kHeightScale*50, y: 10, width: kHeightScale*50, height: kHeightScale*50))
        headerImg.layer.cornerRadius = kHeightScale*25
        headerImg.clipsToBounds = true
        headerImg.sd_setImage(with: URL(string: kImagePrefix+CHSUserInfo.currentUserInfo.avatar), placeholderImage: nil)
        summaryView.addSubview(headerImg)
        
        let sexImg = UIImageView(frame: CGRect(x: summaryView.frame.size.width-8-kHeightScale*15, y: headerImg.frame.maxY-kHeightScale*10, width: kHeightScale*15, height: kHeightScale*15))
        sexImg.image = UIImage(named: CHSUserInfo.currentUserInfo.sex == "0" ? "ic_女士":"ic_男士")
        summaryView.addSubview(sexImg)
        
        drawLine(
            summaryView,
            color: UIColor.lightGray,
            fromPoint: CGPoint(x: 0, y: max(addressBtn.frame.maxY+10, headerImg.frame.maxY+10)),
            toPoint: CGPoint(x: summaryView.frame.size.width, y: max(addressBtn.frame.maxY+10, headerImg.frame.maxY+10)),
            lineWidth: 1/UIScreen.main.scale*2,
            pattern: [5,5])
        
        let intentionTagLab_1 = UILabel(frame: CGRect(x: 8, y: max(addressBtn.frame.maxY+10, headerImg.frame.maxY+10)+1+10, width: summaryView.frame.size.width, height: kHeightScale*15))
        intentionTagLab_1.textColor = baseColor
        intentionTagLab_1.font = UIFont.systemFont(ofSize: 16)
        intentionTagLab_1.text = "求职意向"
        intentionTagLab_1.sizeToFit()
        summaryView.addSubview(intentionTagLab_1)
        
        let intentionLab_1 = UILabel(frame: CGRect(x: intentionTagLab_1.frame.maxX+8, y: max(addressBtn.frame.maxY+10, headerImg.frame.maxY+10)+1+10, width: summaryView.frame.size.width, height: kHeightScale*15))
        intentionLab_1.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        intentionLab_1.font = UIFont.systemFont(ofSize: 15)
        intentionLab_1.text = CHSUserInfo.currentUserInfo.position_type
        intentionLab_1.sizeToFit()
        intentionLab_1.center.y = intentionTagLab_1.center.y
        summaryView.addSubview(intentionLab_1)
        
        let salaryLab = UILabel()
        
        let salaryAttrStr = NSMutableAttributedString(string: "￥ \(CHSUserInfo.currentUserInfo.wantsalary)", attributes: [NSForegroundColorAttributeName:UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1),NSFontAttributeName:UIFont.systemFont(ofSize: 15)])
        salaryAttrStr.addAttributes([NSForegroundColorAttributeName:baseColor], range: NSMakeRange(0, 1))
        
        salaryLab.attributedText = salaryAttrStr
        salaryLab.sizeToFit()
        salaryLab.center.y = intentionLab_1.center.y
        salaryLab.frame.origin.x = summaryView.frame.size.width-8-salaryLab.frame.size.width
        summaryView.addSubview(salaryLab)
        
        let intentionTagLab_2 = UILabel(frame: CGRect(x: 8, y: intentionTagLab_1.frame.maxY+8, width: summaryView.frame.size.width, height: kHeightScale*15))
        intentionTagLab_2.textColor = baseColor
        intentionTagLab_2.font = UIFont.systemFont(ofSize: 16)
        intentionTagLab_2.text = "求职意向"
        intentionTagLab_2.sizeToFit()
        summaryView.addSubview(intentionTagLab_2)
        
        let intentionLab_2 = UILabel(frame: CGRect(x: intentionTagLab_2.frame.maxX+8, y: max(addressBtn.frame.maxY+10, headerImg.frame.maxY+10)+1+10, width: summaryView.frame.size.width, height: kHeightScale*15))
        intentionLab_2.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        intentionLab_2.font = UIFont.systemFont(ofSize: 15)
        intentionLab_2.text = CHSUserInfo.currentUserInfo.categories
        intentionLab_2.sizeToFit()
        intentionLab_2.center.y = intentionTagLab_2.center.y
        summaryView.addSubview(intentionLab_2)
        
        let intentionTagLab_3 = UILabel(frame: CGRect(x: 8, y: intentionTagLab_2.frame.maxY+8, width: summaryView.frame.size.width, height: kHeightScale*15))
        intentionTagLab_3.textColor = baseColor
        intentionTagLab_3.font = UIFont.systemFont(ofSize: 16)
        intentionTagLab_3.text = "求职意向"
        intentionTagLab_3.sizeToFit()
        summaryView.addSubview(intentionTagLab_3)
        
        let intentionLab_3 = UILabel(frame: CGRect(x: intentionTagLab_3.frame.maxX+8, y: max(addressBtn.frame.maxY+10, headerImg.frame.maxY+10)+1+10, width: summaryView.frame.size.width, height: kHeightScale*15))
        intentionLab_3.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        intentionLab_3.font = UIFont.systemFont(ofSize: 15)
        intentionLab_3.text = CHSUserInfo.currentUserInfo.jobstate
        intentionLab_3.sizeToFit()
        intentionLab_3.center.y = intentionTagLab_3.center.y
        summaryView.addSubview(intentionLab_3)
        
        summaryView.frame.size.height = intentionTagLab_3.frame.maxY+10
        
        // MARK: 教育经历
        let eduView = UIView(frame: CGRect(x: 10, y: summaryView.frame.maxY+10, width: screenSize.width-20, height: kHeightScale*174))
        eduView.layer.cornerRadius = 8
        eduView.backgroundColor = UIColor.white
        rootScrollView.addSubview(eduView)
        
        let eduLab = UILabel(frame: CGRect(x: 8, y: 10, width: eduView.frame.size.width, height: kHeightScale*15))
        eduLab.textColor = baseColor
        eduLab.font = UIFont.boldSystemFont(ofSize: 16)
        eduLab.text = "教育经历"
        eduLab.sizeToFit()
        eduView.addSubview(eduLab)
        
        drawLine(
            eduView,
            color: UIColor.lightGray,
            fromPoint: CGPoint(x: 0, y: eduLab.frame.maxY+10),
            toPoint: CGPoint(x: eduView.frame.size.width, y: eduLab.frame.maxY+10),
            lineWidth: 1/UIScreen.main.scale*2,
            pattern: [5,5])
        
        var schoolTagLab_y = eduLab.frame.maxY+10+1
        
        for (i,eduModel) in CHSUserInfo.currentUserInfo.education!.enumerated() {
            
            let schoolTagLab = UILabel(frame: CGRect(x: 8, y: schoolTagLab_y+10, width: eduView.frame.size.width, height: kHeightScale*15))
            schoolTagLab.textColor = UIColor.black
            schoolTagLab.font = UIFont.systemFont(ofSize: 16)
            schoolTagLab.text = "就读学校"
            schoolTagLab.sizeToFit()
            eduView.addSubview(schoolTagLab)
            
            let schoolLab = UILabel(frame: CGRect(x: schoolTagLab.frame.maxX+8, y: eduLab.frame.maxY+10+1+10, width: eduView.frame.size.width, height: kHeightScale*15))
            schoolLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
            schoolLab.font = UIFont.systemFont(ofSize: 15)
            schoolLab.text = eduModel.school
            schoolLab.sizeToFit()
            schoolLab.center.y = schoolTagLab.center.y
            eduView.addSubview(schoolLab)
            
            let schoolTimeLab = UILabel()
            schoolTimeLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
            schoolTimeLab.font = UIFont.systemFont(ofSize: 15)
            schoolTimeLab.text = eduModel.time
            schoolTimeLab.sizeToFit()
            schoolTimeLab.center.y = schoolLab.center.y
            schoolTimeLab.frame.origin.x = eduView.frame.size.width-8-schoolTimeLab.frame.size.width
            eduView.addSubview(schoolTimeLab)
            
            let majorTagLab = UILabel(frame: CGRect(x: 8, y: schoolTagLab.frame.maxY+8, width: eduView.frame.size.width, height: kHeightScale*15))
            majorTagLab.textColor = UIColor.black
            majorTagLab.font = UIFont.systemFont(ofSize: 16)
            majorTagLab.text = "所学专业"
            majorTagLab.sizeToFit()
            eduView.addSubview(majorTagLab)
            
            let majorLab = UILabel(frame: CGRect(x: majorTagLab.frame.maxX+8, y: eduLab.frame.maxY+10+1+10, width: eduView.frame.size.width, height: kHeightScale*15))
            majorLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
            majorLab.font = UIFont.systemFont(ofSize: 15)
            majorLab.text = eduModel.major
            majorLab.sizeToFit()
            majorLab.center.y = majorTagLab.center.y
            eduView.addSubview(majorLab)
            
            let degreeLab = UILabel()
            degreeLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
            degreeLab.font = UIFont.systemFont(ofSize: 16)
            degreeLab.text = eduModel.degree
            degreeLab.sizeToFit()
            degreeLab.center.y = majorLab.center.y
            degreeLab.frame.origin.x = eduView.frame.size.width-8-degreeLab.frame.size.width
            eduView.addSubview(degreeLab)
            
            schoolTagLab_y = majorTagLab.frame.maxY
            
            if i < CHSUserInfo.currentUserInfo.education!.count-1 {
                drawLine(
                    eduView,
                    color: UIColor.lightGray,
                    fromPoint: CGPoint(x: 8, y: majorTagLab.frame.maxY+5),
                    toPoint: CGPoint(x: eduView.frame.size.width-16, y: majorTagLab.frame.maxY+5),
                    lineWidth: 1/UIScreen.main.scale,
                    pattern: [10,0])
            }
            
        }
        eduView.frame.size.height = schoolTagLab_y+10
        
        // MARK: 工作经历
        let jobView = UIView(frame: CGRect(x: 10, y: eduView.frame.maxY+10, width: screenSize.width-20, height: kHeightScale*174))
        jobView.layer.cornerRadius = 8
        jobView.backgroundColor = UIColor.white
        rootScrollView.addSubview(jobView)
        
        let jobLab = UILabel(frame: CGRect(x: 8, y: 10, width: jobView.frame.size.width, height: kHeightScale*15))
        jobLab.textColor = baseColor
        jobLab.font = UIFont.boldSystemFont(ofSize: 16)
        jobLab.text = "工作经历"
        jobLab.sizeToFit()
        jobView.addSubview(jobLab)
        
        drawLine(
            jobView,
            color: UIColor.lightGray,
            fromPoint: CGPoint(x: 0, y: jobLab.frame.maxY+10),
            toPoint: CGPoint(x: jobView.frame.size.width, y: jobLab.frame.maxY+10),
            lineWidth: 1/UIScreen.main.scale*2,
            pattern: [5,5])
        
        let companyNameLab = UILabel(frame: CGRect(x: 8, y: jobLab.frame.maxY+10+1+10, width: jobView.frame.size.width, height: kHeightScale*15))
        companyNameLab.textColor = UIColor.black
        companyNameLab.font = UIFont.systemFont(ofSize: 16)
        companyNameLab.text = CHSUserInfo.currentUserInfo.work?.first?.company_name
        companyNameLab.sizeToFit()
        jobView.addSubview(companyNameLab)
        
        let jobTimeLab = UILabel(frame: CGRect(x: companyNameLab.frame.maxX+8, y: jobLab.frame.maxY+10+1+10, width: jobView.frame.size.width, height: kHeightScale*15))
        jobTimeLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        jobTimeLab.font = UIFont.systemFont(ofSize: 15)
        jobTimeLab.text = CHSUserInfo.currentUserInfo.work?.first?.work_period
        jobTimeLab.sizeToFit()
        jobTimeLab.center.y = companyNameLab.center.y
        jobTimeLab.frame.origin.x = jobView.frame.size.width-8-jobTimeLab.frame.size.width
        jobView.addSubview(jobTimeLab)
        
        let positionTagLab = UILabel(frame: CGRect(x: 8, y: companyNameLab.frame.maxY+8, width: jobView.frame.size.width, height: kHeightScale*15))
        positionTagLab.textColor = UIColor.black
        positionTagLab.font = UIFont.systemFont(ofSize: 16)
        positionTagLab.text = "工作职位"
        positionTagLab.sizeToFit()
        jobView.addSubview(positionTagLab)
        
        let positionLab = UILabel(frame: CGRect(x: positionTagLab.frame.maxX+8, y: 0, width: 0, height: 0))
        positionLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        positionLab.font = UIFont.systemFont(ofSize: 15)
        positionLab.text = CHSUserInfo.currentUserInfo.work?.first?.jobtype
        positionLab.sizeToFit()
        positionLab.center.y = positionTagLab.center.y
        jobView.addSubview(positionLab)
        
        let skillTagLab = UILabel(frame: CGRect(x: 8, y: positionTagLab.frame.maxY+8, width: 0, height: 0))
        skillTagLab.textColor = UIColor.black
        skillTagLab.font = UIFont.systemFont(ofSize: 16)
        skillTagLab.text = "专业技能"
        skillTagLab.sizeToFit()
        jobView.addSubview(skillTagLab)
        
        let cityBtnMargin:CGFloat = 10
        var cityBtnX:CGFloat = skillTagLab.frame.maxX+8
        var cityBtnY:CGFloat = skillTagLab.frame.origin.y
        var cityBtnWidth:CGFloat = 0
        let cityBtnHeight:CGFloat = skillTagLab.frame.size.height
        
        for (i,city) in ((CHSUserInfo.currentUserInfo.work?.first?.skill.components(separatedBy: "-"))!).enumerated() {
            cityBtnWidth = calculateWidth(city, size: 15, height: cityBtnHeight)+cityBtnMargin

            let skillLab = UILabel(frame: CGRect(x: cityBtnX, y: cityBtnY, width: cityBtnWidth, height: cityBtnHeight))
            skillLab.layer.cornerRadius = 6
            skillLab.layer.borderWidth = 1
            skillLab.layer.borderColor = baseColor.cgColor
            skillLab.textColor = baseColor
            skillLab.textAlignment = .center
            skillLab.font = UIFont.systemFont(ofSize: 15)
            skillLab.text = city
//            skillLab.sizeToFit()
//            skillLab.center.y = skillTagLab.center.y
//            skillLab.frame.origin.x = jobView.frame.size.width-8-skillLab.frame.size.width
            jobView.addSubview(skillLab)
            
            if i+1 < (CHSUserInfo.currentUserInfo.work?.first?.skill.components(separatedBy: "-"))?.count {
                
                let nextBtnWidth = calculateWidth(((CHSUserInfo.currentUserInfo.work?.first?.skill.components(separatedBy: "-"))!)[i+1], size: 15, height: cityBtnHeight)+cityBtnMargin
                
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
        let projectView = UIView(frame: CGRect(x: 10, y: jobView.frame.maxY+10, width: screenSize.width-20, height: kHeightScale*174))
        projectView.layer.cornerRadius = 8
        projectView.backgroundColor = UIColor.white
        rootScrollView.addSubview(projectView)
        
        let projectLab = UILabel(frame: CGRect(x: 8, y: 10, width: 0, height: 0))
        projectLab.textColor = baseColor
        projectLab.font = UIFont.boldSystemFont(ofSize: 16)
        projectLab.text = "项目经验"
        projectLab.sizeToFit()
        projectView.addSubview(projectLab)
        
        let projectNameLab = UILabel(frame: CGRect(x: projectLab.frame.maxX+8, y: 0, width: 0, height: 0))
        projectNameLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        projectNameLab.font = UIFont.systemFont(ofSize: 15)
        projectNameLab.text = CHSUserInfo.currentUserInfo.project?.first?.project_name
        projectNameLab.sizeToFit()
        projectNameLab.center.y = projectLab.center.y
        projectNameLab.frame.origin.x = projectView.frame.size.width-8-projectNameLab.frame.size.width
        projectView.addSubview(projectNameLab)
        
        drawLine(
            projectView,
            color: UIColor.lightGray,
            fromPoint: CGPoint(x: 0, y: projectLab.frame.maxY+10),
            toPoint: CGPoint(x: projectView.frame.size.width, y: projectLab.frame.maxY+10),
            lineWidth: 1/UIScreen.main.scale*2,
            pattern: [5,5])
        
        let projectDescriptionTagLab = UILabel(frame: CGRect(x: 8, y: projectLab.frame.maxY+10+1+10, width: 0, height: 0))
        projectDescriptionTagLab.textColor = baseColor
        projectDescriptionTagLab.font = UIFont.systemFont(ofSize: 16)
        projectDescriptionTagLab.text = "项目描述"
        projectDescriptionTagLab.sizeToFit()
        projectView.addSubview(projectDescriptionTagLab)
        
        let projectDescriptionLab = UILabel(frame: CGRect(x: 8, y: projectDescriptionTagLab.frame.maxY+8, width: 0, height: 0))
        projectDescriptionLab.numberOfLines = 0
        projectDescriptionLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        projectDescriptionLab.font = UIFont.systemFont(ofSize: 15)
        projectDescriptionLab.text = CHSUserInfo.currentUserInfo.project?.first?.description_project
        projectDescriptionLab.sizeToFit()
        projectView.addSubview(projectDescriptionLab)
        
        projectView.frame.size.height = projectDescriptionLab.frame.maxY+10

        // MARK: 我的优势
        let advantageView = UIView(frame: CGRect(x: 10, y: projectView.frame.maxY+10, width: screenSize.width-20, height: 0))
        advantageView.layer.cornerRadius = 8
        advantageView.backgroundColor = UIColor.white
        rootScrollView.addSubview(advantageView)
        
        let advantageLab = UILabel(frame: CGRect(x: 8, y: 10, width: 0, height: 0))
        advantageLab.textColor = baseColor
        advantageLab.font = UIFont.boldSystemFont(ofSize: 16)
        advantageLab.text = "我的优势"
        advantageLab.sizeToFit()
        advantageView.addSubview(advantageLab)
        
        drawLine(
            advantageView,
            color: UIColor.lightGray,
            fromPoint: CGPoint(x: 0, y: advantageLab.frame.maxY+10),
            toPoint: CGPoint(x: advantageView.frame.size.width, y: advantageLab.frame.maxY+10),
            lineWidth: 1/UIScreen.main.scale*2,
            pattern: [5,5])
        
        let advantageDescriptionLab = UILabel(frame: CGRect(x: 8, y: advantageLab.frame.maxY+10+1+10, width: 0, height: 0))
        advantageDescriptionLab.numberOfLines = 0
        advantageDescriptionLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        advantageDescriptionLab.font = UIFont.systemFont(ofSize: 15)
        advantageDescriptionLab.text = CHSUserInfo.currentUserInfo.advantage
        advantageDescriptionLab.sizeToFit()
        advantageView.addSubview(advantageDescriptionLab)
        
        advantageView.frame.size.height = advantageDescriptionLab.frame.maxY+10
        
        rootScrollView.contentSize = CGSize(width: 0, height: advantageView.frame.maxY+10)

    }
    
    func temp() {
        
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
