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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
        setHeaderView()
    }
    
    // MARK: 加载数据
    func loadData() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        checkCodeHud.label.text = "正在获取个人信息"
        
        CHSNetUtil().getMyResume(CHSUserInfo.currentUserInfo.userid) { (success, response) in
            if success {
                
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "获取个人信息成功"
                checkCodeHud.hide(animated: true, afterDelay: 1)
                print("获取个人信息成功")
                
                self.setHeaderView()
            }else{
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "获取个人信息失败"
                checkCodeHud.hide(animated: true, afterDelay: 1)
                print("获取个人信息失败")
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
        
    }
    
    // MARK:- 设置tableview 头视图
    func setHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*190))
        headerView.backgroundColor = baseColor
        
        let setBtn = UIButton(frame: CGRect(x: screenSize.width-kWidthScale*42, y: kHeightScale*40, width: kHeightScale*28, height: kHeightScale*28))
        setBtn.layer.cornerRadius = setBtn.frame.size.width/2.0
        setBtn.setImage(UIImage(named: "ic_我的_设置"), for: UIControlState())
        setBtn.addTarget(self, action: #selector(setBtnClick), for: .touchUpInside)
        headerView.addSubview(setBtn)
        
        let headerImgView = UIImageView(frame: CGRect(x: kWidthScale*30, y: kHeightScale*90, width: kHeightScale*50, height: kHeightScale*50))
        headerImgView.layer.cornerRadius = headerImgView.frame.size.width/2.0
        headerImgView.clipsToBounds = true
//        headerImgView.backgroundColor = UIColor.gray
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
        headerView.addSubview(nameLab)
        
        let jobStatusLab = UILabel(frame: CGRect(
            x: headerImgView.frame.maxX+kWidthScale*15,
            y: nameLab.frame.maxY,
            width: kWidthScale*155,
            height: headerImgView.frame.width/2.0))
        jobStatusLab.textAlignment = .left
        jobStatusLab.textColor = UIColor.white
        jobStatusLab.font = UIFont.systemFont(ofSize: 13)
        jobStatusLab.text = CHSUserInfo.currentUserInfo.jobstate
        headerView.addSubview(jobStatusLab)
        
        let scoreBtn = UIButton(frame: CGRect(
            x: screenSize.width-kWidthScale*135, y: kHeightScale*100, width: kWidthScale*120, height: kHeightScale*30))
        scoreBtn.backgroundColor = UIColor(red: 94/255.0, green: 194/255.0, blue: 132/255.0, alpha: 1)
        scoreBtn.layer.cornerRadius = scoreBtn.frame.size.height/2.0
        scoreBtn.setTitle("积分数|120", for: UIControlState())
        headerView.addSubview(scoreBtn)
        
        self.rootTableView.tableHeaderView = headerView
    }
    
    // MARK:- 设置按钮点击事件
    func setBtnClick() {
        self.navigationController?.pushViewController(CHSMiSettingViewController(), animated: true)
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
        
        cell.titImage.image = UIImage(named: imageNameArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row])
        cell.titLab.text = nameArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        return cell
    }
    
    // MARK:- tableview delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeightScale*15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
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
