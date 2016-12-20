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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        self.loadData()

    }
    
    // MARK: 加载数据
    func loadData() {
        
        var flag = 0
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        checkCodeHud.label.text = "正在获取公司信息"
        
        // 检查收藏
        PublicNetUtil().CheckHadFavorite(
        CHSUserInfo.currentUserInfo.userid,
        object_id: (self.jobInfo?.jobid ?? "")!,
        type: "1") { (success, response) in
            if success {
                self.collectionBtn.isSelected = true
            }else{
                self.collectionBtn.isSelected = false
            }
            flag += 1
            
            if flag >= 2 {
                checkCodeHud.hide(animated: true)
            }

        }
        
        // 获取公司信息
        FTNetUtil().getMyCompany_info((self.jobInfo?.userid ?? "")!) { (success, response) in
            if success {
                self.company_infoData = response as! Company_infoDataModel
                self.positionBtn.setTitle("共\((self.company_infoData.jobs?.count)!)个职位", for: UIControlState())
                
                flag += 1
                
                if flag >= 2 {
                    checkCodeHud.hide(animated: true)
                }
                

            }else{
                
                flag += 1
                
                if flag >= 2 {
                    checkCodeHud.mode = .text
                    checkCodeHud.label.text = "获取公司信息失败"
                    checkCodeHud.hide(animated: true, afterDelay: 1)
                }
            }
        }
    }
    
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
   
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        self.title = "职位信息"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

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
    
    // MARK:- 收藏按钮点击事件
    func collectionBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if collectionBtn.isSelected {
            // MARK: 取消收藏
            checkCodeHud.label.text = "正在取消收藏"
            
            PublicNetUtil().cancelfavorite(
                CHSUserInfo.currentUserInfo.userid,
                object_id: (self.jobInfo?.jobid ?? "")!,
                type: "1") { (success, response) in
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
                object_id: (self.jobInfo?.jobid ?? "")!,
                type: "1",
                title: (self.jobInfo?.title ?? "")!,
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
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        //MARK: scrollView
        rootScrollView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-20-44-kHeightScale*44)
        rootScrollView.tag = 101
        rootScrollView.delegate = self
        self.view.addSubview(rootScrollView)
        
        //MARK: 概况
        let noteView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*125))
        noteView.backgroundColor = UIColor.white
        rootScrollView.addSubview(noteView)
        
        let titleLab = UILabel(frame: CGRect(x: 8, y: 0, width: screenSize.width, height: kHeightScale*50))
        titleLab.textColor = UIColor.black
        titleLab.font = UIFont.boldSystemFont(ofSize: 16)
        titleLab.text = self.jobInfo?.title ?? ""
        titleLab.sizeToFit()
        titleLab.frame.origin.y = (kHeightScale*50 - titleLab.frame.size.height)/2.0
        noteView.addSubview(titleLab)
        
        let salaryLab = UILabel(frame: CGRect(x: titleLab.frame.maxX, y: 0, width: screenSize.width, height: kHeightScale*50))
        salaryLab.textColor = UIColor(red: 253/255.0, green: 151/255.0, blue: 39/255.0, alpha: 1)
        salaryLab.font = UIFont.boldSystemFont(ofSize: 16)
        salaryLab.text = "【￥\((self.jobInfo?.salary ?? "")!)】"
        salaryLab.sizeToFit()
        salaryLab.center.y = titleLab.center.y
        noteView.addSubview(salaryLab)
        
        let overviewNameArray = [self.jobInfo?.city?.components(separatedBy: "-").last ?? "",self.jobInfo?.experience ?? "",self.jobInfo?.education ?? "",self.jobInfo?.work_property ?? ""]
        let overviewImgNameArray = ["ic_地点","ic_工作经验","ic_学历","ic_全职"]
        for (i,overviewName) in overviewNameArray.enumerated() {
            let overviewBtn = UIButton(frame: CGRect(
                x: screenSize.width/CGFloat(overviewNameArray.count)*CGFloat(i),
                y: salaryLab.frame.maxY+salaryLab.frame.minY,
                width: screenSize.width/CGFloat(overviewNameArray.count),
                height: kHeightScale*35))
            overviewBtn.setImage(UIImage(named: overviewImgNameArray[i]), for: UIControlState())
            overviewBtn.titleLabel?.adjustsFontSizeToFitWidth = true
            overviewBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            overviewBtn.setTitleColor(UIColor(red: 95/255.0, green: 95/255.0, blue: 95/255.0, alpha: 1), for: UIControlState())
            overviewBtn.setTitle(overviewName, for: UIControlState())
            
            noteView.addSubview(overviewBtn)
        }
        
        let noteLab = UILabel(frame: CGRect(x: 8, y: kHeightScale*85, width: screenSize.width, height: kHeightScale*40))
        noteLab.textColor = UIColor(red: 166/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1)
        noteLab.font = UIFont.systemFont(ofSize: 14)
        noteLab.text = "职位诱惑："+(self.jobInfo?.welfare ?? "")!
        noteView.addSubview(noteLab)
        
        noteLab.sizeToFit()
        
        noteView.frame.size.height = noteLab.frame.maxY+10
        
        //MARK: 公司主页
        let companyView = UIView(frame: CGRect(
            x: 0,
            y: noteView.frame.maxY+kHeightScale*10,
            width: screenSize.width,
            height: kHeightScale*168))
        companyView.backgroundColor = UIColor.white
        rootScrollView.addSubview(companyView)
        
        let headerBtn = UIButton(frame: CGRect(x: 8, y: 0, width: kHeightScale*50, height: kHeightScale*50))

        if self.jobInfo?.authentication == "1" {
            
            let companyLab = UILabel(frame: CGRect(x: 8, y: 0, width: screenSize.width-16, height: kHeightScale*40))
            companyLab.textColor = baseColor
            companyLab.font = UIFont.systemFont(ofSize: 14)
            companyLab.textAlignment = .left
            companyLab.text = "公司主页"
            companyView.addSubview(companyLab)
            
            let companyBtn = UIButton(frame: CGRect(x: 8, y: 0, width: screenSize.width-16, height: kHeightScale*40))
            companyBtn.setTitleColor(UIColor(red: 131/255.0, green: 131/255.0, blue: 131/255.0, alpha: 1), for: UIControlState())
            companyBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
            companyBtn.contentHorizontalAlignment = .right
            companyBtn.setTitle(self.jobInfo?.company_name ?? "", for: UIControlState())
            companyBtn.addTarget(self, action: #selector(companyBtnClick), for: .touchUpInside)
            companyView.addSubview(companyBtn)
            
            drawLine(
                companyView,
                color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1),
                fromPoint: CGPoint(x: 8, y: companyBtn.frame.maxY),
                toPoint: CGPoint(x: screenSize.width-8, y: companyBtn.frame.maxY),
                lineWidth: 1,
                pattern: [10,5])
            
            headerBtn.frame = CGRect(x: 8, y: companyBtn.frame.maxY+1+8, width: kHeightScale*50, height: kHeightScale*50)

        }else{
            headerBtn.frame = CGRect(x: 8, y: 8, width: kHeightScale*50, height: kHeightScale*50)
        }
        
        headerBtn.layer.cornerRadius = kHeightScale*25
        headerBtn.clipsToBounds = true
        headerBtn.sd_setImage(with: URL(string: kImagePrefix+(self.jobInfo?.logo ?? "")!), for: UIControlState())
        headerBtn.sd_setImage(with: URL(string: kImagePrefix+(self.jobInfo?.logo ?? "")!), for: UIControlState(), placeholderImage: #imageLiteral(resourceName: "ic_默认头像"))
        companyView.addSubview(headerBtn)
        
        let nameBtn = UIButton(frame: CGRect(
            x: headerBtn.frame.maxX+kWidthScale*17,
            y: headerBtn.frame.minY,
            width: kWidthScale*200,
            height: headerBtn.frame.size.height/2.0))
        nameBtn.contentHorizontalAlignment = .left
        nameBtn.setTitleColor(UIColor.black, for: UIControlState())
        nameBtn.setTitle(self.jobInfo?.realname ?? "", for: UIControlState())
//        nameBtn.setImage(UIImage(named: "ic_女士"), forState: .Normal)
//        exchangeBtnImageAndTitle(nameBtn, margin: 5)
        companyView.addSubview(nameBtn)
        
        let hrNoteLab = UILabel(frame: CGRect(
            x: headerBtn.frame.maxX+kWidthScale*17,
            y: nameBtn.frame.maxY,
            width: screenSize.width-headerBtn.frame.maxX+kWidthScale*17,
            height: headerBtn.frame.size.height/2.0))
        hrNoteLab.textAlignment = .left
        hrNoteLab.textColor = UIColor(red: 101/255.0, green: 101/255.0, blue: 101/255.0, alpha: 1)
        hrNoteLab.font = UIFont.systemFont(ofSize: 14)
        hrNoteLab.text = "\((self.jobInfo?.myjob ?? "")!) | \((self.jobInfo?.industry?.replacingOccurrences(of: "/", with: " | ") ?? "")!)"
        companyView.addSubview(hrNoteLab)
        
        positionBtn.frame = CGRect(
            x: screenSize.width-kWidthScale*85-8,
            y: headerBtn.frame.minY,
            width: kWidthScale*85,
            height: headerBtn.frame.size.height/2.0)
        positionBtn.layer.cornerRadius = 8
        positionBtn.layer.borderColor = baseColor.cgColor
        positionBtn.layer.borderWidth = 1
        positionBtn.setTitleColor(baseColor, for: UIControlState())
        positionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        positionBtn.addTarget(self, action: #selector(positionBtnClick), for: .touchUpInside)
        companyView.addSubview(positionBtn)
        
        drawLine(
            companyView,
            color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1),
            fromPoint: CGPoint(x: 8, y: headerBtn.frame.maxY+8),
            toPoint: CGPoint(x: screenSize.width-8, y: headerBtn.frame.maxY+8),
            lineWidth: 1,
            pattern: [10,5])
        
        let margin:CGFloat = 8

        let countBtn = UIButton(frame: CGRect(x: 10, y: headerBtn.frame.maxY+1+8+8, width: screenSize.width-16, height: kHeightScale*60))
        countBtn.setImage(UIImage(named: "ic_职位详情页_人数"), for: UIControlState())
        countBtn.setTitleColor(UIColor.black, for: UIControlState())
        countBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        countBtn.titleLabel?.numberOfLines = 0
        countBtn.contentHorizontalAlignment = .left
        countBtn.setTitle("\((self.jobInfo?.count ?? "0")!)", for: UIControlState())
        countBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        companyView.addSubview(countBtn)
        countBtn.sizeToFit()
        
        let company_webBtn = UIButton(frame: CGRect(x: 8, y: countBtn.frame.maxY+8, width: screenSize.width-16, height: kHeightScale*60))
        company_webBtn.setImage(UIImage(named: "ic_职位详情页_网址"), for: UIControlState())
        company_webBtn.setTitleColor(UIColor.black, for: UIControlState())
        company_webBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        company_webBtn.titleLabel?.numberOfLines = 0
        company_webBtn.contentHorizontalAlignment = .left
        company_webBtn.setTitle((self.jobInfo?.company_web ?? "")!, for: UIControlState())
        company_webBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        companyView.addSubview(company_webBtn)
        company_webBtn.sizeToFit()
        
        let company_nameBtn = UIButton(frame: CGRect(x: 8, y: company_webBtn.frame.maxY+8, width: screenSize.width-16, height: kHeightScale*60))
        company_nameBtn.setImage(UIImage(named: "ic_职位详情页_公司"), for: UIControlState())
        company_nameBtn.setTitleColor(UIColor.black, for: UIControlState())
        company_nameBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        company_nameBtn.titleLabel?.numberOfLines = 0
        company_nameBtn.contentHorizontalAlignment = .left
        company_nameBtn.setTitle((self.jobInfo?.company_name ?? "")!, for: UIControlState())
        company_nameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        companyView.addSubview(company_nameBtn)
        
        company_nameBtn.sizeToFit()
        
        let placeBtn = UIButton(frame: CGRect(x: 8, y: company_nameBtn.frame.maxY+8, width: screenSize.width-16, height: kHeightScale*60))
        placeBtn.setImage(UIImage(named: "ic_职位详情页_地点"), for: UIControlState())
        placeBtn.setTitleColor(UIColor.black, for: UIControlState())
        placeBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        placeBtn.titleLabel?.numberOfLines = 0
        placeBtn.contentHorizontalAlignment = .left
        placeBtn.setTitle("上班地点：\((self.jobInfo?.city?.replacingOccurrences(of: "-", with: "") ?? "")!)\((self.jobInfo?.address ?? "")!)", for: UIControlState())
        placeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, -margin)
        companyView.addSubview(placeBtn)
        
        placeBtn.sizeToFit()
        
        companyView.frame.size.height = placeBtn.frame.maxY+10
        
        //MARK: 职位描述
        positionView.frame = CGRect(x: 0, y: companyView.frame.maxY+kHeightScale*10, width: screenSize.width, height: kHeightScale*220)
        positionView.backgroundColor = UIColor.white
        rootScrollView.addSubview(positionView)
        
        let positionLab = UILabel(frame: CGRect(x: 8, y: 0, width: screenSize.width-16, height: kHeightScale*40))
        positionLab.textColor = baseColor
        positionLab.font = UIFont.systemFont(ofSize: 14)
        positionLab.textAlignment = .left
        positionLab.text = "职位描述"
        positionView.addSubview(positionLab)
        
        drawDashed(positionView, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPoint(x: 8, y: positionLab.frame.maxY), toPoint: CGPoint(x: screenSize.width-8, y: positionLab.frame.maxY), lineWidth: 1)
        
        descriptionLab.frame = CGRect(x: 8, y: positionLab.frame.maxY+1+8, width: screenSize.width-16, height: kHeightScale*135)
        descriptionLab.textColor = UIColor.black
        descriptionLab.font = UIFont.systemFont(ofSize: 14)
        descriptionLab.textAlignment = .left
        descriptionLab.numberOfLines = 0
        descriptionLab.text = self.jobInfo?.description_job ?? ""
        positionView.addSubview(descriptionLab)
        
        if calculateHeight((self.jobInfo?.description_job ?? "")!, size: 14, width: screenSize.width-16) > kHeightScale*135 {
            
            descriptionLab.frame.size.height = kHeightScale*135
            
            let showAllBtn = UIButton(frame: CGRect(x: 8, y: descriptionLab.frame.maxY+1+8, width: screenSize.width-16, height: calculateHeight("显示全部", size: 14, width: screenSize.width-16)+8+8))
            showAllBtn.setTitleColor(baseColor, for: UIControlState())
            showAllBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
            showAllBtn.setTitle("显示全部", for: UIControlState())
            showAllBtn.setTitle("收起", for: .selected)

            showAllBtn.addTarget(self, action: #selector(showAllBtnClick(_:)), for: .touchUpInside)
            positionView.addSubview(showAllBtn)
            
            drawLine(
                showAllBtn,
                color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1),
                fromPoint: CGPoint(x: 8, y: 0),
                toPoint: CGPoint(x: screenSize.width-8, y: 0),
                lineWidth: 1,
                pattern: [10,5])
            
            positionView.frame.size.height = showAllBtn.frame.maxY
            
            rootScrollView.contentSize = CGSize(width: 0, height: positionView.frame.maxY+kHeightScale*10)
        }else{

            descriptionLab.frame.size.height = calculateHeight((self.jobInfo?.description_job ?? "")!, size: 14, width: screenSize.width-16)+8
            
            positionView.frame.size.height = descriptionLab.frame.maxY+kHeightScale*10

            rootScrollView.contentSize = CGSize(width: 0, height: positionView.frame.maxY+kHeightScale*10)
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
        
        self.utilView.frame = CGRect(
            x: 0,
            y: screenSize.height-kHeightScale*44,
            width: screenSize.width,
            height: kHeightScale*44)
        self.view.addSubview(self.utilView)
        
        let chatBtn_2 = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: screenSize.width,
            height: kHeightScale*44))
        chatBtn_2.backgroundColor = baseColor
        //        chatBtn_2.layer.cornerRadius = chatBtn.frame.size.height/2.0
        chatBtn_2.setTitleColor(UIColor.white, for: UIControlState())
        chatBtn_2.setTitle("立即沟通", for: UIControlState())
        chatBtn_2.addTarget(self, action: #selector(chatBtnClick), for: .touchUpInside)
        self.utilView.addSubview(chatBtn_2)
    }
    //MARK:-
    
    func showAllBtnClick(_ showAllBtn:UIButton) {
        
        if showAllBtn.isSelected {
            
            descriptionLab.frame.size.height = kHeightScale*135
            

        }else{
            descriptionLab.frame.size.height = calculateHeight((self.jobInfo?.description_job ?? "")!, size: 14, width: screenSize.width-16)+8
        }
        
        showAllBtn.frame.origin.y = descriptionLab.frame.maxY+1+8
        positionView.frame.size.height = showAllBtn.frame.maxY
        
        rootScrollView.contentSize = CGSize(width: 0, height: positionView.frame.maxY+kHeightScale*10)
        
        showAllBtn.isSelected = !showAllBtn.isSelected

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
            print("挑战高薪-机会-个人信息页-分享视图-按钮 \(i) frame == \(shareBtn_1.frame)")
            
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
    
    // 分享视图取消事件
    func shareViewHide(_ shareView:UIButton) {
        if shareView.tag == 102 {
            shareView.superview!.superview!.removeFromSuperview()
        }else{
            shareView.removeFromSuperview()
        }
    }
    // MARK:-
    
    // MARK: 立即沟通按钮点击事件
    func chatBtnClick() {

//        let chatController = CHSMeChatViewController(conversationChatter: self.jobInfo?.userid, conversationType: EMConversationTypeChat)
        let chatController = CHSMeChatViewController()

        
        
        chatController.hidesBottomBarWhenPushed = true
        
        chatController.jobInfo = self.jobInfo
        
        
        self.navigationController?.pushViewController(chatController, animated: true)
        
//        EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"8001" conversationType:EMConversationTypeChat];
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
