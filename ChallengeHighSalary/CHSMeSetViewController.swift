//
//  CHSMeSetViewController.swift
//  ChallengeHighSalary
//
//  Created by 沈晓龙 on 2017/1/3.
//  Copyright © 2017年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMeSetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView()
    
    let nameArray = [["将对方加入黑名单"],["查看历史聊天记录"]]
    var swi = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setSubviews()
        loadBlackData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        //        self.rootTableView.reloadData()
        self.setHeaderView()
        self.loadData()
    }
    
    // MARK: 加载数据
    func loadData() {
        
        
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        self.title = "聊天设置"
        
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-44)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        rootTableView.rowHeight = 44
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.view.addSubview(rootTableView)
        
        setHeaderView()
    }
    
    // MARK:- 设置tableview 头视图
    func setHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 80))
        headerView.backgroundColor = UIColor.white
        
        let headerImg = UIImageView(frame: CGRect(x: 10, y: 15, width: 50, height: 50))
        headerImg.image = UIImage(named: "")
        headerImg.backgroundColor = baseColor
        headerImg.layer.cornerRadius = 25
        headerImg.clipsToBounds = true
        headerView.addSubview(headerImg)
        
        let nameLab = UILabel(frame: CGRect(x: headerImg.frame.maxX+10, y: 15, width: screenSize.width-(headerImg.frame.maxX+10)-10, height: 25))
        nameLab.font = UIFont.systemFont(ofSize: 16)
        nameLab.textColor = baseColor
        nameLab.text = "王大壮"
        headerView.addSubview(nameLab)
        
        let companyLab = UILabel(frame: CGRect(x: headerImg.frame.maxX+10, y: nameLab.frame.maxY, width: screenSize.width-(headerImg.frame.maxX+10)-10, height: 25))
        companyLab.font = UIFont.systemFont(ofSize: 16)
        companyLab.text = "北京校酷网络有限公司"
        headerView.addSubview(companyLab)
        
//        headerView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: headerImg.frame.maxY + 10)
        
        self.rootTableView.tableHeaderView = headerView
    }
    
    // MARK:- tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CHSMiSettingCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "CHSMiSettingCell")
        }
        cell!.selectionStyle = .none
        
        cell?.backgroundColor = UIColor.white
        
        cell?.textLabel!.text = nameArray[indexPath.section][indexPath.row]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell?.textLabel?.textAlignment = .left
        cell?.textLabel?.textColor = UIColor.black
        
        switch indexPath.section {
        case 0:
            cell?.accessoryType = .none
            
            swi = UISwitch.init(frame: CGRect(x: screenSize.width-51-10, y: 13/2.0, width: 51, height: 31))
//            swi.isOn = UserDefaults.standard.bool(forKey: CHSMiMessageRemindSetting_key_pre+String(indexPath.section*100+indexPath.row))
            swi.tag = indexPath.section*100+indexPath.row
            swi.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
            //        print("消息提醒设置，indexPath.section === \(indexPath.section)，indexPath.row === \(indexPath.row)，swi.on = \(swi.on)")
            cell!.contentView.addSubview(swi)
        default:
            cell?.accessoryType = .disclosureIndicator
        }
        
        
        
        return cell!
    }
    
    func switchValueChanged(_ swi:UISwitch) {
//        UserDefaults.standard.set(swi.isOn, forKey: CHSMiMessageRemindSetting_key_pre+String(swi.tag))
        if swi.isOn {
            // 加入黑名单
            addBlackList()
        }else if swi.isOn == false {
            // 取消黑名单
            deleteBlackList()
        }
    }
    
    
    // MARK:- tableview delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeightScale*15
    }
    
    //MARK:检测是否投递简历
    func loadBlackData(){
        
        PublicNetUtil().JudgeBlack(CHSUserInfo.currentUserInfo.userid, blackid: "301", type: "1") { (success, response) in
            if success {
                if (response as! String) == "1"{
                    
                    self.swi.isOn = true
                }else if response as! String == "0"{
                    self.swi.isOn = false
                }
                
            }else{
                
            }
        }
        
    }
    
    // MARK: 加入黑名单
    func addBlackList(){
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true

        PublicNetUtil().setBlackList(CHSUserInfo.currentUserInfo.userid, type: "1", blackid: "301", reason: "") { (success, response) in
            if success {
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "加入黑名单成功"
                checkCodeHud.hide(animated: true, afterDelay: 1)
                self.swi.isOn = true
            }else{
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "加入黑名单失败"
                checkCodeHud.hide(animated: true, afterDelay: 1)
            }
        }
    }
    
    //MARK: 取消黑名单
    func deleteBlackList(){
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        PublicNetUtil().delBlackList(CHSUserInfo.currentUserInfo.userid, type: "1", blackid: "301") { (success, response) in
            if success {
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "取消黑名单成功"
                checkCodeHud.hide(animated: true, afterDelay: 1)
                self.swi.isOn = false
            }else{
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "取消黑名单失败"
                checkCodeHud.hide(animated: true, afterDelay: 1)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
