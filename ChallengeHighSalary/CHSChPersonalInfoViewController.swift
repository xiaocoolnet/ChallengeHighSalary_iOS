//
//  CHSChPersonalInfoViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/18.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSChPersonalInfoViewController: UIViewController, UIScrollViewDelegate {
    
    let collectionBtn = UIButton()
    
    let rootScrollView = UIScrollView()
    
    let positionBtn = UIButton()
    
    let positionView = UIView()
    
    let descriptionLab = UILabel()
    
    var utilView = UIView()
//    let utilView_applyJob = UIView()
//    let utilView_noApplyJob = UIView()
    
    var jobInfo:JobInfoDataModel?
    
    var company_infoData = Company_infoDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setNavigationBar()
        self.setSubviews()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = true
        
        self.loadData()

    }
    
    // MARK: 加载数据
    func loadData() {
        
        // 检查收藏
        PublicNetUtil().CheckHadFavorite(
        CHSUserInfo.currentUserInfo.userid,
        object_id: (self.jobInfo?.jobid ?? "")!,
        type: "1") { (success, response) in
            if success {
                self.collectionBtn.selected = true
            }else{
                self.collectionBtn.selected = false
            }
        }
        
        // 获取公司信息
        FTNetUtil().getMyCompany_info((self.jobInfo?.userid ?? "")!) { (success, response) in
            if success {
                self.company_infoData = response as! Company_infoDataModel
                self.positionBtn.setTitle("共\((self.company_infoData.jobs?.count)!)个职位", forState: .Normal)
            }else{
                
            }
        }
    }
    
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
   
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        self.title = "职位信息"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))

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
    }
    
    // MARK:- 收藏按钮点击事件
    func collectionBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if collectionBtn.selected {
            // MARK: 取消收藏
            checkCodeHud.labelText = "正在取消收藏"
            
            PublicNetUtil().cancelfavorite(
                CHSUserInfo.currentUserInfo.userid,
                object_id: (self.jobInfo?.jobid ?? "")!,
                type: "1") { (success, response) in
                    if success {
                        
                        self.collectionBtn.selected = false
                        
                        checkCodeHud.mode = .Text
                        checkCodeHud.labelText = "取消收藏成功"
                        checkCodeHud.hide(true, afterDelay: 1)
                        
                    }else{
                        checkCodeHud.mode = .Text
                        checkCodeHud.labelText = "取消收藏失败"
                        checkCodeHud.hide(true, afterDelay: 1)
                        
                    }
            }
        }else{
            
            checkCodeHud.labelText = "正在加入收藏"
            
            PublicNetUtil().addfavorite(
                CHSUserInfo.currentUserInfo.userid,
                object_id: (self.jobInfo?.jobid ?? "")!,
                type: "1",
                title: (self.jobInfo?.title ?? "")!,
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
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        //MARK: scrollView
        rootScrollView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-20-44-kHeightScale*44)
        rootScrollView.tag = 101
        rootScrollView.delegate = self
        self.view.addSubview(rootScrollView)
        
        //MARK: 概况
        let noteView = UIView(frame: CGRectMake(0, 0, screenSize.width, kHeightScale*125))
        noteView.backgroundColor = UIColor.whiteColor()
        rootScrollView.addSubview(noteView)
        
        let titleLab = UILabel(frame: CGRectMake(8, 0, screenSize.width, kHeightScale*50))
        titleLab.textColor = UIColor.blackColor()
        titleLab.font = UIFont.boldSystemFontOfSize(16)
        titleLab.text = self.jobInfo?.title ?? ""
        titleLab.sizeToFit()
        titleLab.frame.origin.y = (kHeightScale*50 - titleLab.frame.size.height)/2.0
        noteView.addSubview(titleLab)
        
        let salaryLab = UILabel(frame: CGRectMake(CGRectGetMaxX(titleLab.frame), 0, screenSize.width, kHeightScale*50))
        salaryLab.textColor = UIColor(red: 253/255.0, green: 151/255.0, blue: 39/255.0, alpha: 1)
        salaryLab.font = UIFont.boldSystemFontOfSize(16)
        salaryLab.text = "【￥\((self.jobInfo?.salary ?? "")!)】"
        salaryLab.sizeToFit()
        salaryLab.center.y = titleLab.center.y
        noteView.addSubview(salaryLab)
        
        let overviewNameArray = [self.jobInfo?.city?.componentsSeparatedByString("-").last ?? "",self.jobInfo?.experience ?? "",self.jobInfo?.education ?? "",self.jobInfo?.work_property ?? ""]
        let overviewImgNameArray = ["ic_地点","ic_工作经验","ic_学历","ic_全职"]
        for (i,overviewName) in overviewNameArray.enumerate() {
            let overviewBtn = UIButton(frame: CGRectMake(
                screenSize.width/CGFloat(overviewNameArray.count)*CGFloat(i),
                CGRectGetMaxY(salaryLab.frame)+CGRectGetMinY(salaryLab.frame),
                screenSize.width/CGFloat(overviewNameArray.count),
                kHeightScale*35))
            overviewBtn.setImage(UIImage(named: overviewImgNameArray[i]), forState: .Normal)
            overviewBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
            overviewBtn.setTitleColor(UIColor(red: 95/255.0, green: 95/255.0, blue: 95/255.0, alpha: 1), forState: .Normal)
            overviewBtn.setTitle(overviewName, forState: .Normal)
            
            noteView.addSubview(overviewBtn)
        }
        
        let noteLab = UILabel(frame: CGRectMake(8, kHeightScale*85, screenSize.width, kHeightScale*40))
        noteLab.textColor = UIColor(red: 166/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1)
        noteLab.font = UIFont.systemFontOfSize(14)
        noteLab.text = "职位诱惑："+(self.jobInfo?.welfare ?? "")!
        noteView.addSubview(noteLab)
        
        noteLab.sizeToFit()
        
        noteView.frame.size.height = CGRectGetMaxY(noteLab.frame)+10
        
        //MARK: 公司主页
        let companyView = UIView(frame: CGRectMake(
            0,
            CGRectGetMaxY(noteView.frame)+kHeightScale*10,
            screenSize.width,
            kHeightScale*168))
        companyView.backgroundColor = UIColor.whiteColor()
        rootScrollView.addSubview(companyView)
        
        let headerBtn = UIButton(frame: CGRectMake(8, 0, kHeightScale*50, kHeightScale*50))

        if self.jobInfo?.authentication == "1" {
            
            let companyLab = UILabel(frame: CGRectMake(8, 0, screenSize.width-16, kHeightScale*40))
            companyLab.textColor = baseColor
            companyLab.font = UIFont.systemFontOfSize(14)
            companyLab.textAlignment = .Left
            companyLab.text = "公司主页"
            companyView.addSubview(companyLab)
            
            let companyBtn = UIButton(frame: CGRectMake(8, 0, screenSize.width-16, kHeightScale*40))
            companyBtn.setTitleColor(UIColor(red: 131/255.0, green: 131/255.0, blue: 131/255.0, alpha: 1), forState: .Normal)
            companyBtn.titleLabel!.font = UIFont.systemFontOfSize(14)
            companyBtn.contentHorizontalAlignment = .Right
            companyBtn.setTitle(self.jobInfo?.company_name ?? "", forState: .Normal)
            companyBtn.addTarget(self, action: #selector(companyBtnClick), forControlEvents: .TouchUpInside)
            companyView.addSubview(companyBtn)
            
            drawLine(
                companyView,
                color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1),
                fromPoint: CGPointMake(8, CGRectGetMaxY(companyBtn.frame)),
                toPoint: CGPointMake(screenSize.width-8, CGRectGetMaxY(companyBtn.frame)),
                lineWidth: 1,
                pattern: [10,5])
            
            headerBtn.frame = CGRectMake(8, CGRectGetMaxY(companyBtn.frame)+1+8, kHeightScale*50, kHeightScale*50)

        }else{
            headerBtn.frame = CGRectMake(8, 8, kHeightScale*50, kHeightScale*50)
        }
        
        headerBtn.backgroundColor = baseColor
        headerBtn.layer.cornerRadius = kHeightScale*25
        headerBtn.clipsToBounds = true
        headerBtn.sd_setImageWithURL(NSURL(string: kImagePrefix+(self.jobInfo?.logo ?? "")!), forState: .Normal)
        companyView.addSubview(headerBtn)
        
        let nameBtn = UIButton(frame: CGRectMake(
            CGRectGetMaxX(headerBtn.frame)+kWidthScale*17,
            CGRectGetMinY(headerBtn.frame),
            kWidthScale*200,
            headerBtn.frame.size.height/2.0))
        nameBtn.contentHorizontalAlignment = .Left
        nameBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        nameBtn.setTitle(self.jobInfo?.realname ?? "", forState: .Normal)
//        nameBtn.setImage(UIImage(named: "ic_女士"), forState: .Normal)
//        exchangeBtnImageAndTitle(nameBtn, margin: 5)
        companyView.addSubview(nameBtn)
        
        let hrNoteLab = UILabel(frame: CGRectMake(
            CGRectGetMaxX(headerBtn.frame)+kWidthScale*17,
            CGRectGetMaxY(nameBtn.frame),
            screenSize.width-CGRectGetMaxX(headerBtn.frame)+kWidthScale*17,
            headerBtn.frame.size.height/2.0))
        hrNoteLab.textAlignment = .Left
        hrNoteLab.textColor = UIColor(red: 101/255.0, green: 101/255.0, blue: 101/255.0, alpha: 1)
        hrNoteLab.font = UIFont.systemFontOfSize(14)
        hrNoteLab.text = "\((self.jobInfo?.myjob ?? "")!) | \((self.jobInfo?.industry?.stringByReplacingOccurrencesOfString("/", withString: " | ") ?? "")!)"
        companyView.addSubview(hrNoteLab)
        
        positionBtn.frame = CGRectMake(
            screenSize.width-kWidthScale*85-8,
            CGRectGetMinY(headerBtn.frame),
            kWidthScale*85,
            headerBtn.frame.size.height/2.0)
        positionBtn.layer.cornerRadius = 8
        positionBtn.layer.borderColor = baseColor.CGColor
        positionBtn.layer.borderWidth = 1
        positionBtn.setTitleColor(baseColor, forState: .Normal)
        positionBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        positionBtn.addTarget(self, action: #selector(positionBtnClick), forControlEvents: .TouchUpInside)
        companyView.addSubview(positionBtn)
        
        drawLine(
            companyView,
            color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1),
            fromPoint: CGPointMake(8, CGRectGetMaxY(headerBtn.frame)+8),
            toPoint: CGPointMake(screenSize.width-8, CGRectGetMaxY(headerBtn.frame)+8),
            lineWidth: 1,
            pattern: [10,5])
        
        let margin:CGFloat = 8

        let countBtn = UIButton(frame: CGRectMake(8, CGRectGetMaxY(headerBtn.frame)+1+8+8, screenSize.width-16, kHeightScale*60))
        countBtn.setImage(UIImage(named: "ic_职位详情页_人数"), forState: .Normal)
        countBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        countBtn.titleLabel!.font = UIFont.systemFontOfSize(14)
        countBtn.titleLabel?.numberOfLines = 0
        countBtn.contentHorizontalAlignment = .Left
        countBtn.setTitle("\((self.jobInfo?.count ?? "0")!)", forState: .Normal)
        countBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        companyView.addSubview(countBtn)
        
        countBtn.sizeToFit()
        
        let company_webBtn = UIButton(frame: CGRectMake(8, CGRectGetMaxY(countBtn.frame)+8, screenSize.width-16, kHeightScale*60))
        company_webBtn.setImage(UIImage(named: "ic_职位详情页_网址"), forState: .Normal)
        company_webBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        company_webBtn.titleLabel!.font = UIFont.systemFontOfSize(14)
        company_webBtn.titleLabel?.numberOfLines = 0
        company_webBtn.contentHorizontalAlignment = .Left
        company_webBtn.setTitle("\((self.jobInfo?.company_web)!)", forState: .Normal)
        company_webBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        companyView.addSubview(company_webBtn)
        
        company_webBtn.sizeToFit()
        
        let company_nameBtn = UIButton(frame: CGRectMake(8, CGRectGetMaxY(company_webBtn.frame)+8, screenSize.width-16, kHeightScale*60))
        company_nameBtn.setImage(UIImage(named: "ic_职位详情页_公司"), forState: .Normal)
        company_nameBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        company_nameBtn.titleLabel!.font = UIFont.systemFontOfSize(14)
        company_nameBtn.titleLabel?.numberOfLines = 0
        company_nameBtn.contentHorizontalAlignment = .Left
        company_nameBtn.setTitle("\((self.jobInfo?.company_name)!)", forState: .Normal)
        company_nameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        companyView.addSubview(company_nameBtn)
        
        company_nameBtn.sizeToFit()
        
        let placeBtn = UIButton(frame: CGRectMake(8, CGRectGetMaxY(company_nameBtn.frame)+8, screenSize.width-16, kHeightScale*60))
        placeBtn.setImage(UIImage(named: "ic_职位详情页_地点"), forState: .Normal)
        placeBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        placeBtn.titleLabel!.font = UIFont.systemFontOfSize(14)
        placeBtn.titleLabel?.numberOfLines = 0
        placeBtn.contentHorizontalAlignment = .Left
        placeBtn.setTitle("上班地点：\((self.jobInfo?.city?.stringByReplacingOccurrencesOfString("-", withString: "") ?? "")!)\((self.jobInfo?.address ?? "")!)", forState: .Normal)
        placeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        companyView.addSubview(placeBtn)
        
        placeBtn.sizeToFit()
        
        companyView.frame.size.height = CGRectGetMaxY(placeBtn.frame)+10
        
        //MARK: 职位描述
        positionView.frame = CGRectMake(0, CGRectGetMaxY(companyView.frame)+kHeightScale*10, screenSize.width, kHeightScale*220)
        positionView.backgroundColor = UIColor.whiteColor()
        rootScrollView.addSubview(positionView)
        
        let positionLab = UILabel(frame: CGRectMake(8, 0, screenSize.width-16, kHeightScale*40))
        positionLab.textColor = baseColor
        positionLab.font = UIFont.systemFontOfSize(14)
        positionLab.textAlignment = .Left
        positionLab.text = "职位描述"
        positionView.addSubview(positionLab)
        
        drawDashed(positionView, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, CGRectGetMaxY(positionLab.frame)), toPoint: CGPointMake(screenSize.width-8, CGRectGetMaxY(positionLab.frame)), lineWidth: 1)
        
        descriptionLab.frame = CGRectMake(8, CGRectGetMaxY(positionLab.frame)+1+8, screenSize.width-16, kHeightScale*135)
        descriptionLab.textColor = UIColor.blackColor()
        descriptionLab.font = UIFont.systemFontOfSize(14)
        descriptionLab.textAlignment = .Left
        descriptionLab.numberOfLines = 0
        descriptionLab.text = self.jobInfo?.description_job ?? ""
        positionView.addSubview(descriptionLab)
        
        if calculateHeight((self.jobInfo?.description_job ?? "")!, size: 14, width: screenSize.width-16) > kHeightScale*135 {
            
            descriptionLab.frame.size.height = kHeightScale*135
            
            let showAllBtn = UIButton(frame: CGRectMake(8, CGRectGetMaxY(descriptionLab.frame)+1+8, screenSize.width-16, calculateHeight("显示全部", size: 14, width: screenSize.width-16)+8+8))
            showAllBtn.setTitleColor(baseColor, forState: .Normal)
            showAllBtn.titleLabel!.font = UIFont.systemFontOfSize(14)
            showAllBtn.setTitle("显示全部", forState: .Normal)
            showAllBtn.setTitle("收起", forState: .Selected)

            showAllBtn.addTarget(self, action: #selector(showAllBtnClick(_:)), forControlEvents: .TouchUpInside)
            positionView.addSubview(showAllBtn)
            
            drawLine(
                showAllBtn,
                color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1),
                fromPoint: CGPointMake(8, 0),
                toPoint: CGPointMake(screenSize.width-8, 0),
                lineWidth: 1,
                pattern: [10,5])
            
            positionView.frame.size.height = CGRectGetMaxY(showAllBtn.frame)
            
            rootScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(positionView.frame)+kHeightScale*10)
        }else{

            descriptionLab.frame.size.height = calculateHeight((self.jobInfo?.description_job ?? "")!, size: 14, width: screenSize.width-16)+8
            
            positionView.frame.size.height = CGRectGetMaxY(descriptionLab.frame)

            rootScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(positionView.frame)+kHeightScale*10)
        }
        
        //MARK: 下方视图背景
//        utilView_noApplyJob.frame = CGRectMake(
//            0,
//            0,
//            screenSize.width,
//            kHeightScale*55)
//        self.utilView_noApplyJob.backgroundColor = UIColor.whiteColor()
////        self.view.addSubview(self.utilView_noApplyJob)
//        
//        let sendBtn = UIButton(frame: CGRectMake(kWidthScale*10, kHeightScale*10, kWidthScale*140, kHeightScale*35))
//        sendBtn.backgroundColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1)
//        sendBtn.layer.cornerRadius = sendBtn.frame.size.height/2.0
//        sendBtn.layer.borderColor = UIColor(red: 180/255.0, green: 180/255.0, blue: 180/255.0, alpha: 1).CGColor
//        sendBtn.layer.borderWidth = 1
//        sendBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        sendBtn.setTitle("发送简历", forState: .Normal)
//        self.utilView_noApplyJob.addSubview(sendBtn)
//        
//        let chatBtn = UIButton(frame: CGRectMake(
//            CGRectGetMaxX(sendBtn.frame)+kWidthScale*10,
//            kHeightScale*10,
//            screenSize.width-CGRectGetMaxX(sendBtn.frame)-kWidthScale*10-kHeightScale*20,
//            kHeightScale*35))
//        chatBtn.backgroundColor = baseColor
//        chatBtn.layer.cornerRadius = chatBtn.frame.size.height/2.0
//        chatBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
//        chatBtn.setTitle("和Ta聊聊", forState: .Normal)
//        self.utilView_noApplyJob.addSubview(chatBtn)
//        
//        //MARK: 下方视图背景
//        
//        utilView_applyJob.frame = CGRectMake(
//            0,
//            0,
//            screenSize.width,
//            kHeightScale*55)
//        self.utilView_applyJob.backgroundColor = UIColor.whiteColor()
//        self.utilView.addSubview(self.utilView_applyJob)
        
        self.utilView.frame = CGRectMake(
            0,
            screenSize.height-kHeightScale*44,
            screenSize.width,
            kHeightScale*44)
        self.view.addSubview(self.utilView)
        
        let chatBtn_2 = UIButton(frame: CGRectMake(
            0,
            0,
            screenSize.width,
            kHeightScale*44))
        chatBtn_2.backgroundColor = baseColor
        //        chatBtn_2.layer.cornerRadius = chatBtn.frame.size.height/2.0
        chatBtn_2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        chatBtn_2.setTitle("立即沟通", forState: .Normal)
        self.utilView.addSubview(chatBtn_2)
    }
    //MARK:-
    
    func showAllBtnClick(showAllBtn:UIButton) {
        
        if showAllBtn.selected {
            
            descriptionLab.frame.size.height = kHeightScale*135
            

        }else{
            descriptionLab.frame.size.height = calculateHeight((self.jobInfo?.description_job ?? "")!, size: 14, width: screenSize.width-16)+8
        }
        
        showAllBtn.frame.origin.y = CGRectGetMaxY(descriptionLab.frame)+1+8
        positionView.frame.size.height = CGRectGetMaxY(showAllBtn.frame)
        
        rootScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(positionView.frame)+kHeightScale*10)
        
        showAllBtn.selected = !showAllBtn.selected

    }
    //MARK: 公司主页点击事件
    func companyBtnClick() {
        
        let companyHomeVC = CHSChCompanyHomeViewController()
        companyHomeVC.jobInfoUserid = self.jobInfo?.userid ?? ""
        self.navigationController?.pushViewController(companyHomeVC, animated: true)
        
    }
    
    //MARK: 公司职位点击事件
    func positionBtnClick() {
        let companyPositionListVC = CHSChCompanyPositionListViewController()
        companyPositionListVC.company_infoJobs = self.company_infoData.jobs!
        self.navigationController?.pushViewController(companyPositionListVC, animated: true)
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
