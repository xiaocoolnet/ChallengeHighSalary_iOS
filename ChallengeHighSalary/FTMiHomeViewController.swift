//
//  FTMiHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/8.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMiHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView()
    let nameArray = [["认证公司信息","我的公司主页"],["我的收藏","我的悬赏"],["我的招聘记录","我的面试邀请"],["我的黑名单"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
        self.tabBarController?.tabBar.hidden = false
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        rootTableView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height-44)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.registerClass(CHSMiHomeTableViewCell.self, forCellReuseIdentifier: "CHSMiHomeCell")
        rootTableView.rowHeight = 50
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.tableFooterView = UIView(frame: CGRectZero)
        self.view.addSubview(rootTableView)
        
        setHeaderView()
    }
    
    // MARK:- 设置tableview 头视图
    func setHeaderView() {
        let headerView = UIView(frame: CGRectMake(0, 0, screenSize.width, kHeightScale*190))
        headerView.backgroundColor = baseColor
        
        let setBtn = UIButton(frame: CGRectMake(kWidthScale*12, kHeightScale*40, kHeightScale*28, kHeightScale*28))
        setBtn.backgroundColor = UIColor.orangeColor()
        setBtn.layer.cornerRadius = setBtn.frame.size.width/2.0
        setBtn.layer.borderColor = UIColor.whiteColor().CGColor
        setBtn.layer.borderWidth = 1
        setBtn.addTarget(self, action: #selector(setBtnClick), forControlEvents: .TouchUpInside)
        headerView.addSubview(setBtn)
        
        let postPositionBtn = UIButton(frame: CGRectMake(screenSize.width-kWidthScale*85, kHeightScale*40, kHeightScale*73, kHeightScale*24))
        postPositionBtn.layer.cornerRadius = 6
        postPositionBtn.layer.borderColor = UIColor.whiteColor().CGColor
        postPositionBtn.layer.borderWidth = 1
        postPositionBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        postPositionBtn.setTitle("发布职位", forState: .Normal)
        postPositionBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        postPositionBtn.center.y = setBtn.center.y
        postPositionBtn.addTarget(self, action: #selector(postPositionBtnClick), forControlEvents: .TouchUpInside)
        headerView.addSubview(postPositionBtn)
        
        let headerImgView = UIImageView(frame: CGRectMake(kWidthScale*12, kHeightScale*90, kHeightScale*50, kHeightScale*50))
        headerImgView.layer.cornerRadius = headerImgView.frame.size.width/2.0
        headerImgView.backgroundColor = UIColor.grayColor()
        headerView.addSubview(headerImgView)
        
        let nameLab = UILabel(frame: CGRectMake(
            CGRectGetMaxX(headerImgView.frame)+kWidthScale*15,
            CGRectGetMinY(headerImgView.frame),
            kWidthScale*155,
            CGRectGetWidth(headerImgView.frame)/2.0))
        nameLab.textAlignment = .Left
        nameLab.textColor = UIColor.whiteColor()
        nameLab.font = UIFont.systemFontOfSize(14)
        nameLab.text = "王小妞"
        headerView.addSubview(nameLab)
        
        let jobStatusLab = UILabel(frame: CGRectMake(
            CGRectGetMaxX(headerImgView.frame)+kWidthScale*15,
            CGRectGetMaxY(nameLab.frame),
            kWidthScale*155,
            CGRectGetWidth(headerImgView.frame)/2.0))
        jobStatusLab.textAlignment = .Left
        jobStatusLab.textColor = UIColor.whiteColor()
        jobStatusLab.font = UIFont.systemFontOfSize(12)
        jobStatusLab.text = "免费认证 得积分"
        headerView.addSubview(jobStatusLab)
        
        let scoreBtn = UIButton(frame: CGRectMake(
            screenSize.width-kWidthScale*132, kHeightScale*100, kWidthScale*120, kHeightScale*30))
        scoreBtn.backgroundColor = UIColor(red: 94/255.0, green: 194/255.0, blue: 132/255.0, alpha: 1)
        scoreBtn.layer.cornerRadius = scoreBtn.frame.size.height/2.0
        scoreBtn.setTitle("积分数|120", forState: .Normal)
        headerView.addSubview(scoreBtn)
        
        self.rootTableView.tableHeaderView = headerView
    }
    
    // MARK:- 设置按钮点击事件
    func setBtnClick() {
        self.navigationController?.pushViewController(FTMiSettingViewController(), animated: true)
    }
    // MARK:- 发布职位按钮点击事件
    func postPositionBtnClick() {
        self.navigationController?.pushViewController(FTTaPositionViewController(), animated: true)
    }
    
    // MARK:- tableview datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray[section].count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return nameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CHSMiHomeCell") as! CHSMiHomeTableViewCell
        cell.selectionStyle = .None
        cell.accessoryType = .DisclosureIndicator
        
        cell.titLab.text = nameArray[indexPath.section][indexPath.row]
        return cell
    }
    
    // MARK:- tableview delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeightScale*15
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch (indexPath.section,indexPath.row) {
        case (1,0):
            self.navigationController?.pushViewController(FTMiMyCollectionViewController(), animated: true)
        case (1,1):
            self.navigationController?.pushViewController(FTMiMyRewardViewController(), animated: true)
        case (2,0):
            self.navigationController?.pushViewController(FTMiMyHiringRecordViewController(), animated: true)
        case (2,1):
            self.navigationController?.pushViewController(FTMiMyInterviewInvitationViewController(), animated: true)
        case (3,0):
            self.navigationController?.pushViewController(FTMiMyBlacklistViewController(), animated: true)
            
        default:
            print("抢人才-我的-didSelectRowAtIndexPath  default")
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
