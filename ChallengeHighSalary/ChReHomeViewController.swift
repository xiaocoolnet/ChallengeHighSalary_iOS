//
//  ChReHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/5.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ChReHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let myTableView = UITableView()
    
    let resumeItemArray = ["求职意向","教育背景","工作/实习经历","项目经验","我的优势"]
    var resumeItemStatusArray = ["待完善","待完善","待完善","待完善","待完善"]{
        didSet {
            self.myTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setSubviews()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.alpha = 1
        self.tabBarController?.tabBar.isHidden = false
        
        if CHSUserInfo.currentUserInfo.work_property != "" && CHSUserInfo.currentUserInfo.address != "" && CHSUserInfo.currentUserInfo.position_type != "" && CHSUserInfo.currentUserInfo.categories != "" && CHSUserInfo.currentUserInfo.wantsalary != "" && CHSUserInfo.currentUserInfo.jobstate != ""{
            self.resumeItemStatusArray[0] = "完整"
        }else{
            self.resumeItemStatusArray[1] = "待完善"
        }
        
        if CHSUserInfo.currentUserInfo.education?.count > 0 {
            self.resumeItemStatusArray[1] = "完整"
        }else{
            self.resumeItemStatusArray[1] = "待完善"
        }
        if CHSUserInfo.currentUserInfo.work?.count > 0 {
            self.resumeItemStatusArray[2] = "完整"
        }else{
            self.resumeItemStatusArray[2] = "待完善"
        }
        if CHSUserInfo.currentUserInfo.project?.count > 0 {
            self.resumeItemStatusArray[3] = "完整"
        }else{
            self.resumeItemStatusArray[3] = "待完善"
        }
        if CHSUserInfo.currentUserInfo.advantage != "" {
            self.resumeItemStatusArray[4] = "完整"
        }else{
            self.resumeItemStatusArray[4] = "待完善"
        }
    }
    
    // MARK: 加载数据
    func loadData() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
        checkCodeHud.removeFromSuperViewOnHide = true
        checkCodeHud.labelText = "正在获取简历信息"
            
        CHSNetUtil().getMyResume(CHSUserInfo.currentUserInfo.userid) { (success, response) in
            if success {
                
                if CHSUserInfo.currentUserInfo.work_property != "" && CHSUserInfo.currentUserInfo.address != "" && CHSUserInfo.currentUserInfo.position_type != "" && CHSUserInfo.currentUserInfo.categories != "" && CHSUserInfo.currentUserInfo.wantsalary != "" && CHSUserInfo.currentUserInfo.jobstate != "" {
                    self.resumeItemStatusArray[0] = "完整"
                }else{
                    self.resumeItemStatusArray[1] = "待完善"
                }
                
                if CHSUserInfo.currentUserInfo.education?.count > 0 {
                    self.resumeItemStatusArray[1] = "完整"
                }else{
                    self.resumeItemStatusArray[1] = "待完善"
                }
                if CHSUserInfo.currentUserInfo.work?.count > 0 {
                    self.resumeItemStatusArray[2] = "完整"
                }else{
                    self.resumeItemStatusArray[2] = "待完善"
                }
                if CHSUserInfo.currentUserInfo.project?.count > 0 {
                    self.resumeItemStatusArray[3] = "完整"
                }else{
                    self.resumeItemStatusArray[3] = "待完善"
                }
                if CHSUserInfo.currentUserInfo.advantage != "" {
                    self.resumeItemStatusArray[4] = "完整"
                }else{
                    self.resumeItemStatusArray[4] = "待完善"
                }
                
                checkCodeHud.mode = .text
                checkCodeHud.labelText = "获取简历信息成功"
                checkCodeHud.hide(true, afterDelay: 1)
                print("获取简历信息成功")
            }else{
                checkCodeHud.mode = .text
                checkCodeHud.labelText = "获取简历信息失败"
                checkCodeHud.hide(true, afterDelay: 1)
                print("获取简历信息失败")
            }
        }
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        
        self.title = "简历"
        
        let previewBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 24))
        previewBtn.layer.cornerRadius = 6
        previewBtn.layer.borderColor = UIColor.white.cgColor
        previewBtn.layer.borderWidth = 1
        previewBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        previewBtn.setTitleColor(UIColor.white, for: UIControlState())
        previewBtn.setTitle("预览", for: UIControlState())
        previewBtn.addTarget(self, action: #selector(clickPreviewBtn), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: previewBtn)
        
        // top imageBgView
        let topBgImageView = UIImageView(frame: CGRect(x: 0, y: 64, width: screenSize.width, height: kHeightScale*213))
        topBgImageView.isUserInteractionEnabled = true
//        topBgImageView.backgroundColor = UIColor.whiteColor()
        topBgImageView.image = UIImage(named: "ic_简历_home_bg")
        self.view.addSubview(topBgImageView)
        
        // header imageview
        let headerImageView = UIImageView(frame: CGRect(x: (screenSize.width-screenSize.width*0.16)/2.0, y: screenSize.height*0.087, width: screenSize.width*0.16, height: screenSize.width*0.16))
        headerImageView.layer.cornerRadius = screenSize.width*0.08
        headerImageView.clipsToBounds = true

        headerImageView.sd_setImage(with: URL(string: kImagePrefix+CHSUserInfo.currentUserInfo.avatar)!, placeholderImage: UIImage(named: "temp_default_headerImg"))

        topBgImageView.addSubview(headerImageView)
        
        // name Label
        let nameLab = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        nameLab.textColor = baseColor
        nameLab.text = CHSUserInfo.currentUserInfo.realName
        nameLab.font = UIFont.boldSystemFont(ofSize: 16)
        nameLab.sizeToFit()
        nameLab.center.x = self.view.center.x
        nameLab.frame.origin.y = headerImageView.frame.maxY+10
        topBgImageView.addSubview(nameLab)
        
        // Overview Label
        let overviewLab = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        overviewLab.textColor = UIColor(red: 159/255.0, green: 159/255.0, blue: 159/255.0, alpha: 1)
        let sexStr = CHSUserInfo.currentUserInfo.sex == "0" ? "女":"男"
        let jobExpStr = CHSUserInfo.currentUserInfo.work_life
        let cityStr = CHSUserInfo.currentUserInfo.city
        
        overviewLab.text = "\(sexStr) | \(jobExpStr)工作经验 | \(cityStr)"
        overviewLab.font = UIFont.systemFont(ofSize: 14)
        overviewLab.sizeToFit()
        overviewLab.center.x = self.view.center.x
        overviewLab.frame.origin.y = nameLab.frame.maxY+10
        topBgImageView.addSubview(overviewLab)
        
        // 编辑 按钮
        let editBtn = UIButton(frame: CGRect(x: overviewLab.frame.maxX+5, y: 0, width: 15.5, height: 20))
        editBtn.setImage(UIImage(named: "ic_编辑"), for: UIControlState())
        editBtn.center.y = overviewLab.center.y
        editBtn.addTarget(self, action: #selector(clickEditBtn), for: .touchUpInside)
        topBgImageView.addSubview(editBtn)
        
        // TableView
        myTableView.frame = CGRect(x: 0, y: topBgImageView.frame.maxY+12, width: screenSize.width, height: screenSize.height-topBgImageView.frame.maxY-49)
        myTableView.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        myTableView.rowHeight = 50
        myTableView.dataSource = self
        myTableView.delegate = self
        
        self.view.addSubview(myTableView)
        // 用于去掉多余Cell的分割线
        let removeRedundantCellSepLine = UIView(frame: CGRect.zero)
        myTableView.tableFooterView = removeRedundantCellSepLine
        
    }
    
    // MARK: 点击编辑按钮
    func clickEditBtn() {
        self.navigationController?.pushViewController(CHSReEditPersonalInfoViewController(), animated: true)
    }
    
    // MARK: 点击预览按钮
    func clickPreviewBtn() {
        
        
        self.navigationController?.pushViewController(CHSRePreviewViewController(), animated: true)
    }
    
    // MARK:- tableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resumeItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "resumeCell")
        if (cell == nil) {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "resumeCell")
        }
        cell?.selectionStyle = .none
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell?.textLabel?.textColor = UIColor.black
        cell?.textLabel?.textAlignment = .left
        cell?.textLabel?.text = resumeItemArray[(indexPath as NSIndexPath).row]
        
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.detailTextLabel?.textColor = resumeItemStatusArray[(indexPath as NSIndexPath).row]=="待完善" ? baseColor:UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
        cell?.detailTextLabel?.textAlignment = .right
        cell?.detailTextLabel?.text = resumeItemStatusArray[(indexPath as NSIndexPath).row]
        
        return cell!
    }
    
    // MARK:- tableView DataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).row == 0 {
            self.navigationController?.pushViewController(CHSReJobIntensionViewController(), animated: true)
        }else if (indexPath as NSIndexPath).row == 1 {
            self.navigationController?.pushViewController(CHSReEduExperienceViewController(), animated: true)
        }else if (indexPath as NSIndexPath).row == 2 {
            self.navigationController?.pushViewController(CHSReJobExperienceViewController(), animated: true)
        }else if (indexPath as NSIndexPath).row == 3 {
            self.navigationController?.pushViewController(CHSReProjectExperienceViewController(), animated: true)
        }else if (indexPath as NSIndexPath).row == 4 {
            self.navigationController?.pushViewController(CHSReMyAdvantagesViewController(), animated: true)
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
