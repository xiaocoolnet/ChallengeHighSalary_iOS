//
//  FTPersonalViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/18.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTPersonalViewController: UIViewController {
    
    let rootScrollView = UIScrollView()
    
    let getContectView = UIView()
    
    var resumeData = MyResumeData()
    
    let collectionBtn = UIButton()
    
    var alreadyPay = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setNaviagtionBar()
        self.setSubviews()
        self.loadData()
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
    
    // MARK: 加载数据
    func loadData() {
        self.setSubviews_noPay()

        PublicNetUtil().CheckHadFavorite(
            CHSUserInfo.currentUserInfo.userid,
            object_id: self.resumeData.resumes_id,
            type: "2") { (success, response) in
                if success {
                    self.collectionBtn.isSelected = true
                }else{
                    self.collectionBtn.isSelected = false
                }
        }
    }
    
    // MARK: - 设置 navigationbar
    func setNaviagtionBar() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        self.title = self.resumeData.realname
        
        // rightBarButtonItems
        let shareBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        shareBtn.setImage(UIImage(named: "ic_分享"), for: UIControlState())
        shareBtn.addTarget(self, action: #selector(shareBtnClick), for: .touchUpInside)
        let shareItem = UIBarButtonItem(customView: shareBtn)
        
        collectionBtn.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        collectionBtn.setImage(UIImage(named: "ic_收藏"), for: UIControlState())
        collectionBtn.setImage(UIImage(named: "ic_收藏_sel"), for: .selected)
        collectionBtn.addTarget(self, action: #selector(collectionBtnClick), for: .touchUpInside)
        
        let collectionItem = UIBarButtonItem(customView: collectionBtn)
        
        self.navigationItem.rightBarButtonItems = [collectionItem,shareItem]
        
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        
        // MARK: 获取联系方式
        getContectView.frame = CGRect(x: 0, y: screenSize.height-49, width: screenSize.width, height: 49)
        getContectView.backgroundColor = UIColor.white
        self.view.addSubview(getContectView)
        
        
        
        // MARK: rootScrollView
        rootScrollView.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        self.view.addSubview(rootScrollView)
        
        self.setPersonalInfo()
        
    }
    // MARK:- 设置子视图 —— 未付费
    func setSubviews_noPay() {
        
        rootScrollView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64-49)

        for view in self.getContectView.subviews {
            view.removeFromSuperview()
        }
        
        drawLine(getContectView, color: UIColor.lightGray, fromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: screenSize.width, y: 0), lineWidth: 1/UIScreen.main.scale, pattern: [10,0])
        
        let getContectBtn = UIButton(frame: CGRect(x: 0, y: (getContectView.frame.size.height-(49-16))/2.0, width: screenSize.width/2.0, height: 49-16))
        getContectBtn.backgroundColor = baseColor
        getContectBtn.layer.cornerRadius = getContectBtn.frame.size.height/2.0
        getContectBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        getContectBtn.setTitleColor(UIColor.white, for: UIControlState())
        getContectBtn.setTitle("获取联系方式", for: UIControlState())
        getContectBtn.addTarget(self, action: #selector(getContectBtnClick), for: .touchUpInside)
        getContectBtn.center.x = getContectView.center.x
        getContectView.addSubview(getContectBtn)
        
    }
    
    // MARK:- 设置子视图 —— 已付费
    func setSubviews_alreadyPay() {
        
        // MARK: toolbar
        for view in self.getContectView.subviews {
            view.removeFromSuperview()
        }
        
        drawLine(getContectView, color: UIColor.lightGray, fromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: screenSize.width, y: 0), lineWidth: 1/UIScreen.main.scale, pattern: [10,0])
        
        let telBtn = UIButton(frame: CGRect(
            x: 20,
            y: (getContectView.frame.size.height-(49-16))/2.0,
            width: screenSize.width/2.0-30,
            height: 49-16))
        telBtn.layer.cornerRadius = telBtn.frame.size.height/2.0
        telBtn.setImage(#imageLiteral(resourceName: "ic_FT_电话沟通"), for: .normal)
        telBtn.addTarget(self, action: #selector(telBtnClick(_:)), for: .touchUpInside)
        getContectView.addSubview(telBtn)
        
        let chatBtn = UIButton(frame: CGRect(
            x: telBtn.frame.maxX+20,
            y: (getContectView.frame.size.height-(49-16))/2.0,
            width: screenSize.width/2.0-30,
            height: 49-16))
        chatBtn.layer.cornerRadius = chatBtn.frame.size.height/2.0
        chatBtn.setImage(#imageLiteral(resourceName: "ic_FT_和他聊聊"), for: .normal)
        chatBtn.addTarget(self, action: #selector(chatBtnClick(_:)), for: .touchUpInside)
        getContectView.addSubview(chatBtn)
        
        // MARK: 头部视图
        let headerBgView = UIView(frame: CGRect(x: 0, y: 64, width: screenSize.width, height: 0))
        headerBgView.backgroundColor = UIColor.white
        self.view.addSubview(headerBgView)

        let imgArray = [#imageLiteral(resourceName: "ic_FT_在抢的企业"),#imageLiteral(resourceName: "ic_FT_关注的企业"),#imageLiteral(resourceName: "ic_FT_他人的评价")]
        let imageNameArray = ["在抢的企业","在关注的企业","他人的评价"]
        
        let shareBtnWidth:CGFloat = kWidthScale*40
        let margin = (screenSize.width-CGFloat(imgArray.count)*shareBtnWidth)/CGFloat(imgArray.count+1)
        let margin_y:CGFloat = 10

        let labelHeight = shareBtnWidth/3.0
        
        var labelMaxY:CGFloat = 0
        
        for (i,_) in imgArray.enumerated() {
            
            let shareBtn_1 = UIButton(frame: CGRect(
                x: margin*(CGFloat(i%imgArray.count)+1)+shareBtnWidth*CGFloat(i%imgArray.count),
                y: margin_y,
                width: shareBtnWidth,
                height: shareBtnWidth))
            shareBtn_1.layer.cornerRadius = shareBtnWidth/2.0
            shareBtn_1.setBackgroundImage(imgArray[i], for: .normal)
            shareBtn_1.tag = 1000+i
            shareBtn_1.addTarget(self, action: #selector(toolBtnClick(toolBtn:)), for: .touchUpInside)
            headerBgView.addSubview(shareBtn_1)
            print("抢人才-人才-个人信息页-分享视图-按钮 \(i) frame == \(shareBtn_1.frame)")
            
            let shareLab_1 = UILabel(frame: CGRect(
                x: shareBtn_1.frame.minX-margin/2.0,
                y: shareBtn_1.frame.maxY+margin_y/2.0,
                width: shareBtnWidth+margin,
                height: labelHeight))
            shareLab_1.textColor = UIColor.gray
            shareLab_1.font = UIFont.systemFont(ofSize: 12)
            shareLab_1.textAlignment = .center
            shareLab_1.text = imageNameArray[i]
            headerBgView.addSubview(shareLab_1)
            
            labelMaxY = shareLab_1.frame.maxY
        }
        
        headerBgView.frame.size.height = labelMaxY+margin_y

        drawLine(headerBgView, color: UIColor.lightGray, fromPoint: CGPoint(x: 0, y: headerBgView.frame.size.height), toPoint: CGPoint(x: screenSize.width, y: headerBgView.frame.size.height), lineWidth: 1/UIScreen.main.scale, pattern: [10,0])

        
        // MARK: rootScrollView
        rootScrollView.frame = CGRect(
            x: 0,
            y: 64+headerBgView.frame.size.height,
            width: screenSize.width,
            height: screenSize.height-64-49-headerBgView.frame.size.height)
        
    }
    
    // MARK: - 在抢企业等按钮点击事件
    func toolBtnClick(toolBtn:UIButton) {
        self.navigationController?.pushViewController(FTTaEvaluateViewController(), animated: true)
    }
    
    // MARK: - 设置个人信息
    func setPersonalInfo() {
        
        // MARK: 概况
        let summaryView = UIView(frame: CGRect(x: 10, y: 8, width: screenSize.width-20, height: kHeightScale*174))
        summaryView.layer.cornerRadius = 8
        summaryView.backgroundColor = UIColor.white
        rootScrollView.addSubview(summaryView)
        
        let nameLab = UILabel(frame: CGRect(x: 8, y: 10, width: summaryView.frame.size.width-8-8-50-8, height: kHeightScale*15))
        nameLab.textColor = baseColor
        nameLab.font = UIFont.boldSystemFont(ofSize: 16)
        nameLab.text = self.resumeData.realname
        nameLab.sizeToFit()
        summaryView.addSubview(nameLab)
        
        let jobStateLab = UILabel(frame: CGRect(x: nameLab.frame.maxX+8, y: 0, width: 0, height: 0))
        jobStateLab.font = UIFont.systemFont(ofSize: 15)
        jobStateLab.textColor = UIColor.lightGray
        jobStateLab.text = self.resumeData.jobstate
        jobStateLab.sizeToFit()
        jobStateLab.center.y = nameLab.center.y
        summaryView.addSubview(jobStateLab)
        
        let margin:CGFloat = 5
        
        let addressBtn = UIButton(frame: CGRect(x: 8, y: nameLab.frame.maxY+10, width: screenSize.width, height: kHeightScale*60))
        addressBtn.setImage(UIImage(named: "ic_地点"), for: UIControlState())
        addressBtn.setTitleColor(UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1), for: UIControlState())
        addressBtn.titleLabel!.font = UIFont.systemFont(ofSize: 13)
        addressBtn.titleLabel?.numberOfLines = 0
        addressBtn.contentHorizontalAlignment = .left
        addressBtn.setTitle(self.resumeData.city, for: UIControlState())
        addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        addressBtn.sizeToFit()
        summaryView.addSubview(addressBtn)
        
        let expBtn = UIButton(frame: CGRect(x: addressBtn.frame.maxX+8, y: nameLab.frame.maxY+10, width: screenSize.width, height: kHeightScale*60))
        expBtn.setImage(UIImage(named: "ic_工作经验"), for: UIControlState())
        expBtn.setTitleColor(UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1), for: UIControlState())
        expBtn.titleLabel!.font = UIFont.systemFont(ofSize: 13)
        expBtn.titleLabel?.numberOfLines = 0
        expBtn.contentHorizontalAlignment = .left
        expBtn.setTitle(self.resumeData.work_life, for: UIControlState())
        expBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        expBtn.sizeToFit()
        summaryView.addSubview(expBtn)
        
        let eduBtn = UIButton(frame: CGRect(x: expBtn.frame.maxX+8, y: nameLab.frame.maxY+10, width: screenSize.width, height: kHeightScale*60))
        eduBtn.setImage(UIImage(named: "ic_学历"), for: UIControlState())
        eduBtn.setTitleColor(UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1), for: UIControlState())
        eduBtn.titleLabel!.font = UIFont.systemFont(ofSize: 13)
        eduBtn.titleLabel?.numberOfLines = 0
        eduBtn.contentHorizontalAlignment = .left
        eduBtn.setTitle(self.resumeData.education?.first?.degree, for: UIControlState())
        eduBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        eduBtn.sizeToFit()
        summaryView.addSubview(eduBtn)
        
        let propertyBtn = UIButton(frame: CGRect(x: eduBtn.frame.maxX+8, y: nameLab.frame.maxY+10, width: screenSize.width, height: kHeightScale*60))
        propertyBtn.setImage(UIImage(named: "ic_全职"), for: UIControlState())
        propertyBtn.setTitleColor(UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1), for: UIControlState())
        propertyBtn.titleLabel!.font = UIFont.systemFont(ofSize: 13)
        propertyBtn.titleLabel?.numberOfLines = 0
        propertyBtn.contentHorizontalAlignment = .left
        propertyBtn.setTitle(self.resumeData.work_property, for: UIControlState())
        propertyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        propertyBtn.sizeToFit()
        summaryView.addSubview(propertyBtn)
        
        let headerImg = UIImageView(frame: CGRect(x: summaryView.frame.size.width-8-kHeightScale*50, y: 10, width: kHeightScale*50, height: kHeightScale*50))
        headerImg.layer.cornerRadius = kHeightScale*25
        headerImg.clipsToBounds = true
        headerImg.sd_setImage(with: URL(string: kImagePrefix+self.resumeData.photo), placeholderImage: #imageLiteral(resourceName: "ic_默认头像"))
        summaryView.addSubview(headerImg)
        
        let sexImg = UIImageView(frame: CGRect(x: summaryView.frame.size.width-8-kHeightScale*15, y: headerImg.frame.maxY-kHeightScale*10, width: kHeightScale*15, height: kHeightScale*15))
        sexImg.image = UIImage(named: self.resumeData.sex == "0" ? "ic_女士":"ic_男士")
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
        intentionLab_1.text = self.resumeData.position_type
        intentionLab_1.sizeToFit()
        intentionLab_1.center.y = intentionTagLab_1.center.y
        summaryView.addSubview(intentionLab_1)
        
        let salaryLab = UILabel()
        
        let salaryAttrStr = NSMutableAttributedString(string: "￥ \(self.resumeData.wantsalary)K", attributes: [NSForegroundColorAttributeName:UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1),NSFontAttributeName:UIFont.systemFont(ofSize: 15)])
        salaryAttrStr.addAttributes([NSForegroundColorAttributeName:baseColor], range: NSMakeRange(0, 1))
        
        salaryLab.attributedText = salaryAttrStr
        salaryLab.sizeToFit()
        salaryLab.center.y = intentionLab_1.center.y
        salaryLab.frame.origin.x = summaryView.frame.size.width-8-salaryLab.frame.size.width
        summaryView.addSubview(salaryLab)
        
        let intentionTagLab_2 = UILabel(frame: CGRect(x: 8, y: intentionTagLab_1.frame.maxY+8, width: summaryView.frame.size.width, height: kHeightScale*15))
        intentionTagLab_2.textColor = baseColor
        intentionTagLab_2.font = UIFont.systemFont(ofSize: 16)
        intentionTagLab_2.text = "期望行业"
        intentionTagLab_2.sizeToFit()
        summaryView.addSubview(intentionTagLab_2)
        
        let intentionLab_2 = UILabel(frame: CGRect(x: intentionTagLab_2.frame.maxX+8, y: max(addressBtn.frame.maxY+10, headerImg.frame.maxY+10)+1+10, width: summaryView.frame.size.width, height: kHeightScale*15))
        intentionLab_2.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        intentionLab_2.font = UIFont.systemFont(ofSize: 15)
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
        
        summaryView.frame.size.height = intentionTagLab_2.frame.maxY+10
        
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
        
        for (i,eduModel) in self.resumeData.education!.enumerated() {
            
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
            
            if i < self.resumeData.education!.count-1 {
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
        companyNameLab.text = self.resumeData.work?.first?.company_name
        companyNameLab.sizeToFit()
        jobView.addSubview(companyNameLab)
        
        let jobTimeLab = UILabel(frame: CGRect(x: companyNameLab.frame.maxX+8, y: jobLab.frame.maxY+10+1+10, width: jobView.frame.size.width, height: kHeightScale*15))
        jobTimeLab.textColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        jobTimeLab.font = UIFont.systemFont(ofSize: 15)
        jobTimeLab.text = self.resumeData.work?.first?.work_period
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
        positionLab.text = self.resumeData.work?.first?.jobtype
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
        
        if self.resumeData.work?.first?.skill != nil {
            
            for (i,city) in ((self.resumeData.work?.first?.skill.components(separatedBy: "-"))!).enumerated() {
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
                
                if i+1 < ((self.resumeData.work?.first?.skill.components(separatedBy: "-"))!).count {
                    
                    let nextBtnWidth = calculateWidth(((self.resumeData.work?.first?.skill.components(separatedBy: "-"))!)[i+1], size: 15, height: cityBtnHeight)+cityBtnMargin
                    
                    if cityBtnWidth + cityBtnX + cityBtnMargin + nextBtnWidth >= screenSize.width - 20 {
                        cityBtnX = cityBtnMargin
                        cityBtnY = cityBtnHeight + cityBtnY + cityBtnMargin
                    }else{
                        
                        cityBtnX = cityBtnWidth + cityBtnX + cityBtnMargin
                    }
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
        projectNameLab.text = self.resumeData.project?.first?.project_name
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
        projectDescriptionLab.text = self.resumeData.project?.first?.description_project
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
        advantageDescriptionLab.text = self.resumeData.advantage
        advantageDescriptionLab.sizeToFit()
        advantageView.addSubview(advantageDescriptionLab)
        
        advantageView.frame.size.height = advantageDescriptionLab.frame.maxY+10
        
        rootScrollView.contentSize = CGSize(width: 0, height: advantageView.frame.maxY+10)
    }
    
    // MARK: - 获取联系方式点击事件
    func getContectBtnClick() {
        
        let bgView = UIButton(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        bgView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        bgView.tag = 101
        bgView.addTarget(self, action: #selector(shareViewHide(_:)), for: .touchUpInside)
        UIApplication.shared.keyWindow!.addSubview(bgView)
        
        let scale = #imageLiteral(resourceName: "ic_抢人才_alert_点击查看").size.width/#imageLiteral(resourceName: "ic_抢人才_alert_点击查看").size.height

        let alertView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.height*0.5*scale, height: 0))
        alertView.layer.cornerRadius = 8
        alertView.center.x = bgView.center.x
        bgView.addSubview(alertView)
        
        let alertImg = UIButton(frame: CGRect(x: 0, y: 0, width: screenSize.height*0.5*scale, height: screenSize.height*0.5))
        alertImg.setBackgroundImage(#imageLiteral(resourceName: "ic_抢人才_alert_点击查看"), for: .normal)
        alertImg.addTarget(self, action: #selector(lookBtnClick(_:)), for: .touchUpInside)
        alertView.addSubview(alertImg)
        
        alertView.frame.size.height = alertImg.frame.maxY
        alertView.center.y = bgView.center.y

        let closeBtn = UIButton(frame: CGRect(x: alertView.frame.width-15, y: -15, width: 30, height: 30))

        closeBtn.tag = 102
        closeBtn.setBackgroundImage(#imageLiteral(resourceName: "ic_FT_alertClose"), for: .normal)
        closeBtn.addTarget(self, action: #selector(shareViewHide(_:)), for: .touchUpInside)
        alertView.addSubview(closeBtn)
    }
    
    // MARK: - 立即查看按钮点击事件
    func lookBtnClick(_ lookBtn:UIButton) {
        
        lookBtn.superview?.superview?.removeFromSuperview()
        
        let bgView = UIButton(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        bgView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        bgView.tag = 101
        bgView.addTarget(self, action: #selector(shareViewHide(_:)), for: .touchUpInside)
        UIApplication.shared.keyWindow!.addSubview(bgView)
        
        let alertView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width*0.65, height: 0))
        alertView.backgroundColor = UIColor.white
        alertView.layer.cornerRadius = 8
        alertView.center.x = bgView.center.x
        bgView.addSubview(alertView)
   
        let tipLabel = UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: alertView.frame.width,
            height: (#imageLiteral(resourceName: "ic_抢人才_alert_付费会员特权").size.height/#imageLiteral(resourceName: "ic_抢人才_alert_付费会员特权").size.width)*alertView.frame.width))
        tipLabel.image = #imageLiteral(resourceName: "ic_抢人才_alert_付费会员特权")
        alertView.addSubview(tipLabel)
        
        // 联系方式
        let iconImg1 = UIImageView(frame: CGRect(x: 20, y: tipLabel.frame.maxY+10, width: 30, height: 30))
        iconImg1.image = #imageLiteral(resourceName: "ic_FT_alert_联系方式")
        alertView.addSubview(iconImg1)
        
        let tipLabel1 = UILabel(frame: CGRect(x: iconImg1.frame.maxX+20, y: iconImg1.frame.minY, width: alertView.frame.width - (iconImg1.frame.maxX+20), height: 30))
        tipLabel1.textColor = UIColor.darkGray
        tipLabel1.font = UIFont.systemFont(ofSize: 14)
        tipLabel1.textAlignment = .left
        tipLabel1.adjustsFontSizeToFitWidth = true
        tipLabel1.text = "人才联系方式"
        alertView.addSubview(tipLabel1)
        
        // 企业关注
        let iconImg2 = UIImageView(frame: CGRect(x: 20, y: iconImg1.frame.maxY+20, width: 30, height: 30))
        iconImg2.image = #imageLiteral(resourceName: "ic_FT_alert_企业关注")
        alertView.addSubview(iconImg2)
        
        let tipLabel2 = UILabel(frame: CGRect(x: iconImg2.frame.maxX+20, y: iconImg2.frame.minY, width: alertView.frame.width - (iconImg2.frame.maxX+20), height: 30))
        tipLabel2.textColor = UIColor.darkGray
        tipLabel2.font = UIFont.systemFont(ofSize: 14)
        tipLabel2.textAlignment = .left
        tipLabel2.adjustsFontSizeToFitWidth = true
        tipLabel2.text = "哪些企业在关注这个人才"
        alertView.addSubview(tipLabel2)
        
        // 人才关注
        let iconImg3 = UIImageView(frame: CGRect(x: 20, y: iconImg2.frame.maxY+20, width: 30, height: 30))
        iconImg3.image = #imageLiteral(resourceName: "ic_FT_alert_人才关注")
        alertView.addSubview(iconImg3)
        
        let tipLabel3 = UILabel(frame: CGRect(x: iconImg3.frame.maxX+20, y: iconImg3.frame.minY, width: alertView.frame.width - (iconImg3.frame.maxX+20), height: 30))
        tipLabel3.textColor = UIColor.darkGray
        tipLabel3.font = UIFont.systemFont(ofSize: 14)
        tipLabel3.textAlignment = .left
        tipLabel3.adjustsFontSizeToFitWidth = true
        tipLabel3.text = "人才关注过的企业"
        alertView.addSubview(tipLabel3)
        
        // 评价
        let iconImg4 = UIImageView(frame: CGRect(x: 20, y: iconImg3.frame.maxY+20, width: 30, height: 30))
        iconImg4.image = #imageLiteral(resourceName: "ic_FT_alert_评价")
        alertView.addSubview(iconImg4)
        
        let tipLabel4 = UILabel(frame: CGRect(x: iconImg4.frame.maxX+20, y: iconImg4.frame.minY, width: alertView.frame.width - (iconImg4.frame.maxX+20), height: 30))
        tipLabel4.textColor = UIColor.darkGray
        tipLabel4.font = UIFont.systemFont(ofSize: 14)
        tipLabel4.textAlignment = .left
        tipLabel4.adjustsFontSizeToFitWidth = true
        tipLabel4.text = "企业给他的评价"
        alertView.addSubview(tipLabel4)

        
        let payBtn = UIButton(frame: CGRect(x: 0, y: iconImg4.frame.maxY+20, width: alertView.frame.width*0.6, height: 30))
        payBtn.layer.cornerRadius = 15
        payBtn.backgroundColor = UIColor.red
        payBtn.setTitleColor(UIColor.white, for: .normal)
        payBtn.setTitle("立即付费", for: .normal)
        payBtn.frame.origin.x = (alertView.frame.width-payBtn.frame.width)/2.0
        payBtn.addTarget(self, action: #selector(payBtnClick(_:)), for: .touchUpInside)
        alertView.addSubview(payBtn)
        
        alertView.frame.size.height = payBtn.frame.maxY+20
        alertView.center.y = bgView.center.y

        let closeBtn = UIButton(frame: CGRect(x: alertView.frame.width-15, y: -15, width: 30, height: 30))
        closeBtn.tag = 102
        closeBtn.setBackgroundImage(#imageLiteral(resourceName: "ic_FT_alertClose"), for: .normal)
        closeBtn.addTarget(self, action: #selector(shareViewHide(_:)), for: .touchUpInside)
        alertView.addSubview(closeBtn)
    }
    
    // MARK: - 立即付费按钮点击事件
    func payBtnClick(_ payBtn:UIButton) {
        
        payBtn.superview?.superview?.removeFromSuperview()

        self.setSubviews_alreadyPay()
    }
    
    // MARK: - 和他聊聊按钮 点击事件
    func chatBtnClick(_ chatBtn:UIButton) {
        
        if CHSUserInfo.currentUserInfo.userid == self.resumeData.userid {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.removeFromSuperViewOnHide = true
            hud.mode = .text
            hud.margin = 10
            hud.label.text = "不能和自己聊天"
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        
        
        let chatViewController = FTTaChatViewController()
        chatViewController.resumeData = self.resumeData
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    // MARK: - 电话沟通按钮 点击事件
    func telBtnClick(_ telBtn:UIButton) {

        let bgView = UIButton(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        bgView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        bgView.tag = 101
        bgView.addTarget(self, action: #selector(shareViewHide(_:)), for: .touchUpInside)
        UIApplication.shared.keyWindow!.addSubview(bgView)
        
        let alertView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width*0.6, height: 0))
        alertView.backgroundColor = UIColor.white
        alertView.layer.cornerRadius = 8
        alertView.center.x = bgView.center.x
        bgView.addSubview(alertView)
        
        let tipLabel = UILabel(frame: CGRect(x: 0, y: 5, width: alertView.frame.width, height: 0))
        tipLabel.textColor = UIColor.black
        tipLabel.font = UIFont.systemFont(ofSize: 16)
        tipLabel.textAlignment = .center
        tipLabel.text = "拨打电话"
        tipLabel.sizeToFit()
        tipLabel.frame.origin.x = (alertView.frame.width-tipLabel.frame.width)/2.0
        alertView.addSubview(tipLabel)
        
        
        // 拨打电话
        let iconImg1 = UIImageView(frame: CGRect(x: 20, y: tipLabel.frame.maxY+15, width: 25, height: 25))
        iconImg1.image = #imageLiteral(resourceName: "ic_FT_电话图标")
        alertView.addSubview(iconImg1)
        
        let tipLabel1 = UILabel(frame: CGRect(x: iconImg1.frame.maxX+20, y: iconImg1.frame.minY, width: alertView.frame.width - (iconImg1.frame.maxX+20), height: 25))
        tipLabel1.textColor = UIColor.darkGray
        tipLabel1.font = UIFont.systemFont(ofSize: 14)
        tipLabel1.textAlignment = .left
        tipLabel1.adjustsFontSizeToFitWidth = true
        tipLabel1.text = "拨打电话：\(self.resumeData.phone)"
        alertView.addSubview(tipLabel1)
        
        let cancelBtn = UIButton(frame: CGRect(
            x: 10,
            y: tipLabel1.frame.maxY+10,
            width: alertView.frame.width*0.4,
            height: 30))
        cancelBtn.tag = 102
        cancelBtn.setTitleColor(UIColor.blue, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.addTarget(self, action: #selector(shareViewHide(_:)), for: .touchUpInside)
        alertView.addSubview(cancelBtn)
        
        let payBtn = UIButton(frame: CGRect(
            x: alertView.frame.width*0.6-10,
            y: tipLabel1.frame.maxY+10,
            width: alertView.frame.width*0.4,
            height: 30))
        payBtn.setTitleColor(UIColor.blue, for: .normal)
        payBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        payBtn.setTitle("确认", for: .normal)
        payBtn.addTarget(self, action: #selector(telSureBtnClick(_:)), for: .touchUpInside)
        alertView.addSubview(payBtn)
        
        
        alertView.frame.size.height = cancelBtn.frame.maxY
        alertView.center.y = bgView.center.y
        
        let line1 = UIView(frame: CGRect(x: 10, y: tipLabel.frame.maxY+5, width: alertView.frame.width-20, height: 1/UIScreen.main.scale))
        line1.backgroundColor = UIColor.lightGray
        alertView.addSubview(line1)
        
        let line2 = UIView(frame: CGRect(x: 10, y: tipLabel1.frame.maxY+10, width: alertView.frame.width-20, height: 1/UIScreen.main.scale))
        line2.backgroundColor = UIColor.lightGray
        alertView.addSubview(line2)
        
        let line3 = UIView(frame: CGRect(x: alertView.frame.width*0.5, y: tipLabel1.frame.maxY+10, width: 1/UIScreen.main.scale, height: alertView.frame.height-(tipLabel1.frame.maxY+10)))
        line3.backgroundColor = UIColor.lightGray
        alertView.addSubview(line3)

    }
    
    // MARK: - 拨打电话 确认按钮点击事件
    func telSureBtnClick(_ sureBtn:UIButton) {
        
        sureBtn.superview?.superview?.removeFromSuperview()
        UIApplication.shared.openURL(URL(string: "tel:\(self.resumeData.phone)")!)
    }
    // MARK:- 收藏按钮点击事件
    func collectionBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if collectionBtn.isSelected {
            
            // MARK: 取消收藏
            checkCodeHud.label.text = "正在取消收藏"
            
            PublicNetUtil().cancelfavorite(
                CHSUserInfo.currentUserInfo.userid,
                object_id: self.resumeData.resumes_id,
                type: "2") { (success, response) in
                    if success {
                        
                        self.collectionBtn.isSelected = false
                        
                        checkCodeHud.mode = .text
                        checkCodeHud.label.text = "取消收藏成功"
                        checkCodeHud.hide(animated: true, afterDelay: 1)
                        
                    }else{
                        checkCodeHud.mode = .text
                        checkCodeHud.label.text = "取消收藏失败"
                        checkCodeHud.hide(animated: true, afterDelay: 1)
                        
                    }
            }

        }else{
            
            checkCodeHud.label.text = "正在加入收藏"
            
            PublicNetUtil().addfavorite(
                CHSUserInfo.currentUserInfo.userid,
                object_id: self.resumeData.resumes_id,
                type: "2",
                title: self.resumeData.realname,
                description: "") { (success, response) in
                    if success {
                        
                        self.collectionBtn.isSelected = true
                        
                        checkCodeHud.mode = .text
                        checkCodeHud.label.text = "已加入收藏列表"
                        checkCodeHud.hide(animated: true, afterDelay: 1)
                    }else{
                        checkCodeHud.mode = .text
                        checkCodeHud.label.text = "加入收藏列表失败"
                        checkCodeHud.hide(animated: true, afterDelay: 1)
                    }
            }
        }
    }
    
    // MARK:- 分享视图
    func shareBtnClick() {
        let imageArray = ["ic_share_QQ","ic_share_微信","ic_share_朋友圈"]
        let imgArray = [#imageLiteral(resourceName: "ic_share_QQ"),#imageLiteral(resourceName: "ic_share_微信"),#imageLiteral(resourceName: "ic_share_朋友圈")]
        let imageNameArray = ["QQ","微信","朋友圈"]
        
        let bgView = UIButton(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        bgView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        bgView.tag = 101
        bgView.addTarget(self, action: #selector(shareViewHide(_:)), for: .touchUpInside)
        UIApplication.shared.keyWindow!.addSubview(bgView)
        
        let bottomView = UIView(frame: CGRect(x: 0, y: bgView.frame.maxY, width: screenSize.width, height: screenSize.height*0.4))
        bottomView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
        bgView.addSubview(bottomView)
        
        let shareBtnWidth:CGFloat = kWidthScale*50
        //        let maxMargin:CGFloat = shareBtnWidth/3.0
        let shareBtnCount:Int = 3 // 每行的按钮数
        let margin = (screenSize.width-CGFloat(shareBtnCount)*shareBtnWidth)/CGFloat(shareBtnCount+1)
        let margin_y:CGFloat = 20
        
        let labelHeight = shareBtnWidth/3.0
        
        var labelMaxY:CGFloat = 0
        
        for (i,_) in imageArray.enumerated() {
            
            let shareBtn_1 = UIButton(frame: CGRect(
                x: margin*(CGFloat(i%shareBtnCount)+1)+shareBtnWidth*CGFloat(i%shareBtnCount),
                y: margin_y*(CGFloat(i/shareBtnCount)+1)+(shareBtnWidth+margin_y+labelHeight)*CGFloat(i/shareBtnCount),
                width: shareBtnWidth,
                height: shareBtnWidth))
            shareBtn_1.layer.cornerRadius = shareBtnWidth/2.0
//            shareBtn_1.backgroundColor = UIColor.blue
            //            shareBtn_1.setImage(UIImage(named: imageArray[i]), for: UIControlState())
            shareBtn_1.setBackgroundImage(imgArray[i], for: .normal)
            shareBtn_1.tag = 1000+i
            //            shareBtn_1.addTarget(self, action: #selector(shareBtnClick(_:)), forControlEvents: .TouchUpInside)
            bottomView.addSubview(shareBtn_1)
            print("抢人才-人才-个人信息页-分享视图-按钮 \(i) frame == \(shareBtn_1.frame)")
            
            let shareLab_1 = UILabel(frame: CGRect(
                x: shareBtn_1.frame.minX-margin/2.0,
                y: shareBtn_1.frame.maxY+margin_y/2.0,
                width: shareBtnWidth+margin,
                height: labelHeight))
            shareLab_1.textColor = UIColor.gray
            shareLab_1.font = UIFont.systemFont(ofSize: 14)
            shareLab_1.textAlignment = .center
            shareLab_1.text = imageNameArray[i]
            bottomView.addSubview(shareLab_1)
            
            labelMaxY = shareLab_1.frame.maxY
        }
        
        let line = UIView(frame: CGRect(x: 0, y: labelMaxY+margin_y/2.0, width: screenSize.width, height: 1))
        line.backgroundColor = UIColor.lightGray
        bottomView.addSubview(line)
        
        let cancelBtnHeight:CGFloat = 44
        
        let cancelBtn = UIButton(frame: CGRect(x: 0, y: line.frame.maxY, width: screenSize.width, height: cancelBtnHeight))
        cancelBtn.backgroundColor = UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1)
        cancelBtn.setTitleColor(UIColor.black, for: UIControlState())
        cancelBtn.setTitle("取消", for: UIControlState())
        cancelBtn.tag = 102
        cancelBtn.addTarget(self, action: #selector(shareViewHide(_:)), for: .touchUpInside)
        bottomView.addSubview(cancelBtn)
        
        bottomView.frame.size.height = cancelBtn.frame.maxY
        
        UIView.animate(withDuration: 0.5, animations: {
            bottomView.frame.origin.y = screenSize.height - cancelBtn.frame.maxY
        }) 
    }
    
    // MARK: - 分享视图取消事件
    func shareViewHide(_ shareView:UIButton) {
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
