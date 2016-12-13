//
//  FTMiHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/8.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMiHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var company_infoDataModel = CompanyCertifyDataModel()
    
    let rootTableView = UITableView()
    
    let jobStatusLab = UILabel()
    
    let nameArray = [["认证公司信息","我的公司信息"],["我的收藏","我的悬赏"],["我的招聘记录","我的面试邀请"],["我的黑名单"]]
    let imageArray = [[#imageLiteral(resourceName: "ic_FT_Mi_认证"),#imageLiteral(resourceName: "ic_FT_Mi_信息")],[#imageLiteral(resourceName: "ic_FT_Mi_收藏"),#imageLiteral(resourceName: "ic_FT_Mi_悬赏")],[#imageLiteral(resourceName: "ic_FT_Mi_记录"),#imageLiteral(resourceName: "ic_FT_Mi_面试邀请")],[#imageLiteral(resourceName: "ic_FT_Mi_黑名单")]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
//        self.rootTableView.reloadData()
        self.setHeaderView()
        self.loadData()
    }
    
    // MARK: 加载数据
    func loadData() {
        
        if self.company_infoDataModel.status != "" {
            return
        }
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
        checkCodeHud.removeFromSuperViewOnHide = true
        checkCodeHud.labelText = "正在获取个人信息"
        
        FTNetUtil().getMyCompany_info(CHSUserInfo.currentUserInfo.userid) { (success, response) in
            
            FTNetUtil().getCompanyCertify(CHSUserInfo.currentUserInfo.userid) { (success, response) in
                if success {
                    self.company_infoDataModel = response as! CompanyCertifyDataModel
                    
                    self.jobStatusLab.text = self.company_infoDataModel.status == "1" ? "已认证":"免费认证 得积分"
                    
                    checkCodeHud.mode = .text
                    checkCodeHud.labelText = "获取个人信息成功"
                    checkCodeHud.hide(true, afterDelay: 1)
                    print("获取个人信息成功")
                    
                    self.setHeaderView()
                }else{
                    checkCodeHud.mode = .text
                    checkCodeHud.labelText = "获取个人信息失败"
                    checkCodeHud.hide(true, afterDelay: 1)
                    print("获取个人信息失败")
                }
            }
        }
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        rootTableView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-44)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.register(CHSMiHomeTableViewCell.self, forCellReuseIdentifier: "CHSMiHomeCell")
        rootTableView.rowHeight = 50
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.view.addSubview(rootTableView)
        
        setHeaderView()
    }
    
    // MARK:- 设置tableview 头视图
    func setHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*190))
        headerView.backgroundColor = baseColor
        
        let setBtn = UIButton(frame: CGRect(x: kWidthScale*12, y: kHeightScale*40, width: kHeightScale*28, height: kHeightScale*28))
        setBtn.layer.cornerRadius = setBtn.frame.size.width/2.0
        setBtn.setImage(UIImage(named: "ic_我的_设置"), for: UIControlState())
        setBtn.addTarget(self, action: #selector(setBtnClick), for: .touchUpInside)
        headerView.addSubview(setBtn)
        
        let postPositionBtn = UIButton(frame: CGRect(x: screenSize.width-kWidthScale*85, y: kHeightScale*40, width: kHeightScale*73, height: kHeightScale*24))
        postPositionBtn.layer.cornerRadius = 6
        postPositionBtn.layer.borderColor = UIColor.white.cgColor
        postPositionBtn.layer.borderWidth = 1
        postPositionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        postPositionBtn.setTitle("发布职位", for: UIControlState())
        postPositionBtn.setTitleColor(UIColor.white, for: UIControlState())
        postPositionBtn.center.y = setBtn.center.y
        postPositionBtn.addTarget(self, action: #selector(postPositionBtnClick), for: .touchUpInside)
        headerView.addSubview(postPositionBtn)
        
        let headerImgView = UIImageView(frame: CGRect(x: kWidthScale*12, y: kHeightScale*90, width: kHeightScale*50, height: kHeightScale*50))
        headerImgView.layer.cornerRadius = headerImgView.frame.size.width/2.0
        headerImgView.clipsToBounds = true
        headerImgView.sd_setImage(with: URL(string: kImagePrefix+CHSUserInfo.currentUserInfo.avatar), placeholderImage: #imageLiteral(resourceName: "ic_默认头像"))
        headerView.addSubview(headerImgView)
        
        let nameLab = UILabel(frame: CGRect(
            x: headerImgView.frame.maxX+kWidthScale*15,
            y: headerImgView.frame.minY,
            width: kWidthScale*155,
            height: headerImgView.frame.width/2.0))
        nameLab.textAlignment = .left
        nameLab.textColor = UIColor.white
        nameLab.font = UIFont.systemFont(ofSize: 14)
        nameLab.text = CHSUserInfo.currentUserInfo.realName
        nameLab.sizeToFit()
        headerView.addSubview(nameLab)
        
        let editBtn = UIButton(frame: CGRect(
            x: nameLab.frame.maxX+8,
            y: 0,
            width: nameLab.frame.height*0.75,
            height: nameLab.frame.height))
        editBtn.setImage(#imageLiteral(resourceName: "ic_FT_Mi_修改"), for: .normal)
        editBtn.center.y = nameLab.center.y
        editBtn.addTarget(self, action: #selector(editBtnClick), for: .touchUpInside)
        headerView.addSubview(editBtn)
        
        jobStatusLab.frame = CGRect(
            x: headerImgView.frame.maxX+kWidthScale*15,
            y: nameLab.frame.maxY,
            width: kWidthScale*155,
            height: headerImgView.frame.width/2.0)
        jobStatusLab.textAlignment = .left
        jobStatusLab.textColor = UIColor.white
        jobStatusLab.font = UIFont.systemFont(ofSize: 12)
        jobStatusLab.text = self.company_infoDataModel.status == "1" ? "已认证":"免费认证 得积分"
        headerView.addSubview(jobStatusLab)
        
        let scoreBtn = UIButton(frame: CGRect(
            x: screenSize.width-kWidthScale*132, y: kHeightScale*100, width: kWidthScale*120, height: kHeightScale*30))
        scoreBtn.backgroundColor = UIColor(red: 94/255.0, green: 194/255.0, blue: 132/255.0, alpha: 1)
        scoreBtn.layer.cornerRadius = scoreBtn.frame.size.height/2.0
        scoreBtn.setTitle("积分数|120", for: UIControlState())
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
    
    // MARK:- 编辑个人信息按钮点击事件
    func editBtnClick() {
        self.navigationController?.pushViewController(FTMiInfoViewController(), animated: true)
    }
    
    // MARK:- tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CHSMiHomeCell") as! CHSMiHomeTableViewCell
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        cell.titImage.image = imageArray[indexPath.section][indexPath.row]
        cell.titLab.text = nameArray[indexPath.section][indexPath.row]
        return cell
    }
    
    // MARK:- tableview delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeightScale*15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
        case (0,0):
            
            let companyAuthController = FTMiCompanyAuthViewController()
            companyAuthController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(companyAuthController, animated: true)
        
        case (0,1):
            
            let myCompanyInfoController = FTMiMyCompanyInfoViewController()
            self.navigationController?.pushViewController(myCompanyInfoController, animated: true)
        case (1,0):
            self.navigationController?.pushViewController(FTMiMyCollectionViewController(), animated: true)
        case (1,1):
            self.navigationController?.pushViewController(FTMiMyRewardViewController(), animated: true)
        case (2,0):
            let hiringRecordVC = FTMiMyHiringRecordViewController()
//            hiringRecordVC.jobs = self.company_infoDataModel.jobs
            self.navigationController?.pushViewController(hiringRecordVC, animated: true)
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
