//
//  ChMiHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/5.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChMiHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView()
    let nameArray = [["我的收藏","我的奖金"],["我的投递记录","我的黑名单"]]
    let imageNameArray = [["ic_我的_收藏","ic_我的_奖金"],["ic_我的_投递记录","ic_我的_黑名单"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setSubviews()
        
        self.loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
        self.tabBarController?.tabBar.hidden = false
        
        setHeaderView()
    }
    
    // MARK: 加载数据
    func loadData() {
        
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        checkCodeHud.labelText = "正在获取个人信息"
        
        CHSNetUtil().getMyResume(CHSUserInfo.currentUserInfo.userid) { (success, response) in
            if success {
                
                checkCodeHud.mode = .Text
                checkCodeHud.labelText = "获取个人信息成功"
                checkCodeHud.hide(true, afterDelay: 1)
                print("获取个人信息成功")
                
                self.setHeaderView()
            }else{
                checkCodeHud.mode = .Text
                checkCodeHud.labelText = "获取个人信息失败"
                checkCodeHud.hide(true, afterDelay: 1)
                print("获取个人信息失败")
            }
        }
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
        
    }
    
    // MARK:- 设置tableview 头视图
    func setHeaderView() {
        let headerView = UIView(frame: CGRectMake(0, 0, screenSize.width, kHeightScale*190))
        headerView.backgroundColor = baseColor
        
        let setBtn = UIButton(frame: CGRectMake(screenSize.width-kWidthScale*42, kHeightScale*40, kHeightScale*28, kHeightScale*28))
        setBtn.layer.cornerRadius = setBtn.frame.size.width/2.0
        setBtn.setImage(UIImage(named: "ic_我的_设置"), forState: .Normal)
        setBtn.addTarget(self, action: #selector(setBtnClick), forControlEvents: .TouchUpInside)
        headerView.addSubview(setBtn)
        
        let headerImgView = UIImageView(frame: CGRectMake(kWidthScale*30, kHeightScale*90, kHeightScale*50, kHeightScale*50))
        headerImgView.layer.cornerRadius = headerImgView.frame.size.width/2.0
        headerImgView.clipsToBounds = true
        headerImgView.backgroundColor = UIColor.grayColor()
        headerImgView.sd_setImageWithURL(NSURL(string: kImagePrefix+CHSUserInfo.currentUserInfo.avatar), placeholderImage: nil)
        headerView.addSubview(headerImgView)
        
        let nameLab = UILabel(frame: CGRectMake(
            CGRectGetMaxX(headerImgView.frame)+kWidthScale*15,
            CGRectGetMinY(headerImgView.frame),
            kWidthScale*155,
            CGRectGetWidth(headerImgView.frame)/2.0))
        nameLab.textAlignment = .Left
        nameLab.textColor = UIColor.whiteColor()
        nameLab.font = UIFont.systemFontOfSize(14)
        nameLab.text = CHSUserInfo.currentUserInfo.realName
        headerView.addSubview(nameLab)
        
        let jobStatusLab = UILabel(frame: CGRectMake(
            CGRectGetMaxX(headerImgView.frame)+kWidthScale*15,
            CGRectGetMaxY(nameLab.frame),
            kWidthScale*155,
            CGRectGetWidth(headerImgView.frame)/2.0))
        jobStatusLab.textAlignment = .Left
        jobStatusLab.textColor = UIColor.whiteColor()
        jobStatusLab.font = UIFont.systemFontOfSize(13)
        jobStatusLab.text = CHSUserInfo.currentUserInfo.jobstate
        headerView.addSubview(jobStatusLab)
        
        let scoreBtn = UIButton(frame: CGRectMake(
            screenSize.width-kWidthScale*135, kHeightScale*100, kWidthScale*120, kHeightScale*30))
        scoreBtn.backgroundColor = UIColor(red: 94/255.0, green: 194/255.0, blue: 132/255.0, alpha: 1)
        scoreBtn.layer.cornerRadius = scoreBtn.frame.size.height/2.0
        scoreBtn.setTitle("积分数|120", forState: .Normal)
        headerView.addSubview(scoreBtn)
        
        self.rootTableView.tableHeaderView = headerView
    }
    
    // MARK:- 设置按钮点击事件
    func setBtnClick() {
        self.navigationController?.pushViewController(CHSMiSettingViewController(), animated: true)
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
        
        cell.titImage.image = UIImage(named: imageNameArray[indexPath.section][indexPath.row])
        cell.titLab.text = nameArray[indexPath.section][indexPath.row]
        return cell
    }
    
    // MARK:- tableview delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeightScale*15
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            self.navigationController?.pushViewController(CHSMiMyCollectionViewController(), animated: true)
        case (0,1):
            self.navigationController?.pushViewController(CHSMiMyBonusViewController(), animated: true)
        case (1,0):
            self.navigationController?.pushViewController(CHSMiMyDeliveryRecordViewController(), animated: true)
        case (1,1):
            self.navigationController?.pushViewController(CHSMiMyBlacklistViewController(), animated: true)
        default:
            print("挑战高薪-我的-didSelectRowAtIndexPath  default")
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
