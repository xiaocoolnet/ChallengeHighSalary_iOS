//
//  CHSChPersonalInfoViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/18.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSChPersonalInfoViewController: UIViewController, UIScrollViewDelegate {
    
    let rootScrollView = UIScrollView()
    
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
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
   
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        self.title = "个人信息"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))

        // rightBarButtonItems
        let shareBtn = UIButton(frame: CGRectMake(0, 0, 24, 24))
        shareBtn.setImage(UIImage(named: "ic-分享"), forState: .Normal)
        shareBtn.addTarget(self, action: #selector(shareBtnClick), forControlEvents: .TouchUpInside)
        let shareItem = UIBarButtonItem(customView: shareBtn)
        
        let collectionBtn = UIButton(frame: CGRectMake(0, 0, 24, 24))
        collectionBtn.setImage(UIImage(named: "ic-收藏"), forState: .Normal)
        //        searchBtn.addTarget(self, action: #selector(searchBtnClick), forControlEvents: .TouchUpInside)
        let collectionItem = UIBarButtonItem(customView: collectionBtn)
        
        self.navigationItem.rightBarButtonItems = [collectionItem,shareItem]
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        //MARK: scrollView
        rootScrollView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-20-44-kHeightScale*55)
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
        titleLab.text = "UI设计师"
        titleLab.sizeToFit()
        titleLab.frame.origin.y = (kHeightScale*50 - titleLab.frame.size.height)/2.0
        noteView.addSubview(titleLab)
        
        let salaryLab = UILabel(frame: CGRectMake(CGRectGetMaxX(titleLab.frame), 0, screenSize.width, kHeightScale*50))
        salaryLab.textColor = UIColor(red: 253/255.0, green: 151/255.0, blue: 39/255.0, alpha: 1)
        salaryLab.font = UIFont.boldSystemFontOfSize(16)
        salaryLab.text = "【￥5k-6k】"
        salaryLab.sizeToFit()
        salaryLab.center.y = titleLab.center.y
        noteView.addSubview(salaryLab)
        
        let overviewNameArray = ["北京","1-3年","本科","全职"]
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
        noteLab.text = "职位诱惑：五险一金，双休，带薪年假，生日福利"
        noteView.addSubview(noteLab)
        
        //MARK: 公司主页
        let companyView = UIView(frame: CGRectMake(
            0,
            CGRectGetMaxY(noteView.frame)+kHeightScale*10,
            screenSize.width,
            kHeightScale*168))
        companyView.backgroundColor = UIColor.whiteColor()
        rootScrollView.addSubview(companyView)
        
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
        companyBtn.setTitle("北京互联科技有限公司", forState: .Normal)
        companyBtn.addTarget(self, action: #selector(companyBtnClick), forControlEvents: .TouchUpInside)
        companyView.addSubview(companyBtn)
        
        drawDashed(companyView, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, CGRectGetMaxY(companyBtn.frame)), toPoint: CGPointMake(screenSize.width-8, CGRectGetMaxY(companyBtn.frame)), lineWidth: 1)
        
        let headerBtn = UIButton(frame: CGRectMake(8, CGRectGetMaxY(companyBtn.frame)+1+8, kHeightScale*50, kHeightScale*50))
        headerBtn.backgroundColor = baseColor
        companyView.addSubview(headerBtn)
        
        let nameBtn = UIButton(frame: CGRectMake(
            CGRectGetMaxX(headerBtn.frame)+kWidthScale*17,
            CGRectGetMinY(headerBtn.frame),
            kWidthScale*200,
            headerBtn.frame.size.height/2.0))
        nameBtn.contentHorizontalAlignment = .Left
        nameBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        nameBtn.setTitle("王小妞", forState: .Normal)
        nameBtn.setImage(UIImage(named: "ic_女士"), forState: .Normal)
        exchangeBtnImageAndTitle(nameBtn, margin: 5)
        companyView.addSubview(nameBtn)
        
        let hrNoteLab = UILabel(frame: CGRectMake(
            CGRectGetMaxX(headerBtn.frame)+kWidthScale*17,
            CGRectGetMaxY(nameBtn.frame),
            screenSize.width-CGRectGetMaxX(headerBtn.frame)+kWidthScale*17,
            headerBtn.frame.size.height/2.0))
        hrNoteLab.textAlignment = .Left
        hrNoteLab.textColor = UIColor(red: 101/255.0, green: 101/255.0, blue: 101/255.0, alpha: 1)
        hrNoteLab.font = UIFont.systemFontOfSize(14)
        hrNoteLab.text = "人事经理 | 互联科技 | 互联网"
        companyView.addSubview(hrNoteLab)
        
        let positionBtn = UIButton(frame: CGRectMake(
            screenSize.width-kWidthScale*85-8,
            CGRectGetMinY(headerBtn.frame),
            kWidthScale*85,
            headerBtn.frame.size.height/2.0))
        positionBtn.layer.cornerRadius = 8
        positionBtn.layer.borderColor = baseColor.CGColor
        positionBtn.layer.borderWidth = 1
        positionBtn.setTitleColor(baseColor, forState: .Normal)
        positionBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        positionBtn.setTitle("共7个职位", forState: .Normal)
        positionBtn.addTarget(self, action: #selector(positionBtnClick), forControlEvents: .TouchUpInside)
        companyView.addSubview(positionBtn)
        
        drawDashed(companyView, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, CGRectGetMaxY(headerBtn.frame)+8), toPoint: CGPointMake(screenSize.width-8, CGRectGetMaxY(headerBtn.frame)+8), lineWidth: 1)
        
        let placeBtn = UIButton(frame: CGRectMake(8, CGRectGetMaxY(headerBtn.frame)+1+8, screenSize.width, kHeightScale*60))
        placeBtn.setImage(UIImage(named: "1"), forState: .Normal)
        placeBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        placeBtn.titleLabel!.font = UIFont.systemFontOfSize(14)
        placeBtn.titleLabel?.numberOfLines = 0
        placeBtn.contentHorizontalAlignment = .Left
        placeBtn.setTitle("上班地点：北京市朝阳区酒仙桥路122号（电子城大厦）121", forState: .Normal)
        companyView.addSubview(placeBtn)
        
        //MARK: 职位描述
        let positionView = UIView(frame: CGRectMake(0, CGRectGetMaxY(companyView.frame)+kHeightScale*10, screenSize.width, kHeightScale*220))
        positionView.backgroundColor = UIColor.whiteColor()
        rootScrollView.addSubview(positionView)
        
        let positionLab = UILabel(frame: CGRectMake(8, 0, screenSize.width-16, kHeightScale*40))
        positionLab.textColor = baseColor
        positionLab.font = UIFont.systemFontOfSize(14)
        positionLab.textAlignment = .Left
        positionLab.text = "职位描述"
        positionView.addSubview(positionLab)
        
        drawDashed(positionView, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, CGRectGetMaxY(positionLab.frame)), toPoint: CGPointMake(screenSize.width-8, CGRectGetMaxY(positionLab.frame)), lineWidth: 1)
        
        let descriptionLab = UILabel(frame: CGRectMake(8, CGRectGetMaxY(positionLab.frame)+1, screenSize.width, kHeightScale*135))
        descriptionLab.textColor = UIColor.blackColor()
        descriptionLab.font = UIFont.systemFontOfSize(14)
        descriptionLab.textAlignment = .Left
        descriptionLab.numberOfLines = 0
        descriptionLab.text = "一、岗位职责:\n1、负责整体UI视觉设计与用户体验；\n2、准确理解产品需求和交互原型，配合产品经理和开发人员完成原型或demo设计；\n3、关注所负责产品的设计动向，为产品提供专业的美术意见及建议；"
        positionView.addSubview(descriptionLab)
        
        drawDashed(positionView, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, CGRectGetMaxY(descriptionLab.frame)+8), toPoint: CGPointMake(screenSize.width-8, CGRectGetMaxY(descriptionLab.frame)+8), lineWidth: 1)
        
        let showAllBtn = UIButton(frame: CGRectMake(8, CGRectGetMaxY(descriptionLab.frame)+1+8, screenSize.width-16, kHeightScale*35))
        showAllBtn.setTitleColor(baseColor, forState: .Normal)
        showAllBtn.titleLabel!.font = UIFont.systemFontOfSize(14)
        showAllBtn.setTitle("显示全部", forState: .Normal)
        positionView.addSubview(showAllBtn)
        
        rootScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(positionView.frame)+kHeightScale*10)
        
        //MARK: 下方视图背景
        let utilView = UIView(frame: CGRectMake(
            0,
            screenSize.height-kHeightScale*55,
            screenSize.width,
            kHeightScale*55))
        utilView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(utilView)
        
        let sendBtn = UIButton(frame: CGRectMake(kWidthScale*10, kHeightScale*10, kWidthScale*140, kHeightScale*35))
        sendBtn.backgroundColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1)
        sendBtn.layer.cornerRadius = sendBtn.frame.size.height/2.0
        sendBtn.layer.borderColor = UIColor(red: 180/255.0, green: 180/255.0, blue: 180/255.0, alpha: 1).CGColor
        sendBtn.layer.borderWidth = 1
        sendBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        sendBtn.setTitle("发送简历", forState: .Normal)
        utilView.addSubview(sendBtn)
        
        let chatBtn = UIButton(frame: CGRectMake(
            CGRectGetMaxX(sendBtn.frame)+kWidthScale*10,
            kHeightScale*10,
            screenSize.width-CGRectGetMaxX(sendBtn.frame)+kWidthScale*10-kHeightScale*20,
            kHeightScale*35))
        chatBtn.backgroundColor = baseColor
        chatBtn.layer.cornerRadius = chatBtn.frame.size.height/2.0
        chatBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        chatBtn.setTitle("和Ta聊聊", forState: .Normal)
        utilView.addSubview(chatBtn)
    }
    //MARK:-
    
    //MARK: 公司主页点击事件
    func companyBtnClick() {
        
        self.navigationController?.pushViewController(CHSChCompanyHomeViewController(), animated: true)
    }
    
    //MARK: 公司职位点击事件
    func positionBtnClick() {
        
        self.navigationController?.pushViewController(CHSChCompanyPositionListViewController(), animated: true)
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
