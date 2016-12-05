//
//  FTMiCompanyAuthInfoViewController.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2016/12/5.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMiCompanyAuthInfoViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    let nameArray = ["公司全称","所属行业","人员规模","融资阶段"]
    // TODO:
    let detailNameArray = [CHSUserInfo.currentUserInfo.company,CHSUserInfo.currentUserInfo.categories,"20-99人","未融资"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        self.title = "个人信息"
        //        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(clickSaveBtn))
        
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 50
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        // MARK: 个人信息
        let personalBgView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*80))
        personalBgView.layer.cornerRadius = 8
        personalBgView.backgroundColor = UIColor.white
        self.view.addSubview(personalBgView)
        
        let headerImg = UIImageView(frame: CGRect(x: 15, y: personalBgView.frame.height/2.0-25, width: 50, height: 50))
        headerImg.layer.cornerRadius = 25
        headerImg.clipsToBounds = true
        headerImg.sd_setImage(with: URL(string: kImagePrefix + CHSUserInfo.currentUserInfo.avatar)!, placeholderImage: #imageLiteral(resourceName: "ic_默认头像"))
        personalBgView.addSubview(headerImg)
        
        let noteLab1 = UILabel(frame: CGRect(x: headerImg.frame.maxX+10, y: headerImg.frame.minY, width: personalBgView.frame.width-35-15-(headerImg.frame.maxX)-20, height: 25))
        noteLab1.font = UIFont.systemFont(ofSize: 16)
        noteLab1.textColor = UIColor.darkGray
        noteLab1.text = "\(CHSUserInfo.currentUserInfo.realName) | \(CHSUserInfo.currentUserInfo.myjob)"
        personalBgView.addSubview(noteLab1)
        
        let noteLab2 = UILabel(frame: CGRect(x: headerImg.frame.maxX+10, y: noteLab1.frame.maxY, width: personalBgView.frame.width-35-15-(headerImg.frame.maxX)-20, height: 25))
        noteLab2.font = UIFont.systemFont(ofSize: 15)
        noteLab2.textColor = UIColor.gray
        noteLab2.text = "企业邮箱:\(CHSUserInfo.currentUserInfo.email)"
        personalBgView.addSubview(noteLab2)
        rootTableView.tableHeaderView = personalBgView
        
        let footLab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 25))
        footLab.textColor = UIColor.darkGray
        footLab.font = UIFont.systemFont(ofSize: 14)
        footLab.textAlignment = .center
        footLab.text = "若要修改公司信息,请到【我的-我的公司信息】页面"
        rootTableView.tableFooterView = footLab
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- tableView dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "companyInfoCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "companyInfoCell")
        }
        cell?.accessoryType = .disclosureIndicator
        
        cell?.selectionStyle = .none
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell?.textLabel?.textColor = UIColor.black
        cell?.textLabel?.textAlignment = .left
        cell?.textLabel?.text = nameArray[(indexPath as NSIndexPath).row]
        
//        if (indexPath as NSIndexPath).row == 0 {
//            let logoImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//            logoImg.layer.cornerRadius = 20
//            logoImg.backgroundColor = UIColor.orange
//            cell?.accessoryView = logoImg
//        }else{
            cell?.accessoryView = nil
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
            cell?.detailTextLabel?.textAlignment = .right
            cell?.detailTextLabel?.text = detailNameArray[(indexPath as NSIndexPath).row]
//        }
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let sectionHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*35))
            sectionHeaderView.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
            
            let sectionHeaderLab = UILabel(frame: CGRect(x: 16, y: 0, width: screenSize.width, height: kHeightScale*35))
            sectionHeaderLab.font = UIFont.systemFont(ofSize: 14)
            sectionHeaderLab.textColor = UIColor.darkGray
            sectionHeaderLab.text = "所在公司"
            sectionHeaderView.addSubview(sectionHeaderLab)
            
            return sectionHeaderView
        }
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeightScale*35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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
