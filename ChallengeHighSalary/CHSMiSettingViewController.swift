//
//  CHSMiSettingViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/19.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiSettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64), style: .grouped)
//    let nameArray = [["手机绑定","设置密码","消息提醒"],["关于我们"],["切换身份"],["退出当前账号"]]
    let nameArray = [["手机绑定","设置密码","消息提醒"],["关于我们"],["退出当前账号"]]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        self.title = "设置"
        
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 50
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.view.addSubview(rootTableView)
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
        
        cell?.textLabel!.text = nameArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        
        if (indexPath as NSIndexPath).section == nameArray.endIndex-1 {
            cell!.accessoryType = .none

            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell?.textLabel?.textAlignment = .center
            cell?.textLabel?.textColor = UIColor.white
            cell?.backgroundColor = baseColor
        }else{
            cell!.accessoryType = .disclosureIndicator
            
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell?.textLabel?.textAlignment = .left
            cell?.textLabel?.textColor = UIColor.black
            cell?.backgroundColor = UIColor.white
        }
        
        return cell!
    }
    
    // MARK:- tableview delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == nameArray.endIndex-1 {
            return kHeightScale*90
        }else{
            return kHeightScale*15
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
        case (0,0):
            self.navigationController?.pushViewController(CHSMiPhoneBindingViewController(), animated: true)
        case (0,1):
            self.navigationController?.pushViewController(CHSMiCheckPasswordViewController(), animated: true)
        case (0,2):
            self.navigationController?.pushViewController(CHSMiMessageRemindViewController(), animated: true)
        case (1,0):
            self.navigationController?.pushViewController(CHSMiAboutUsViewController(), animated: true)
//        case (2,0):
//            self.navigationController?.pushViewController(CHSMiChangeIdentityViewController(), animated: true)
        case (2,0):
            
            let signOutAlert = UIAlertController(title: "", message: "确定退出登录？", preferredStyle: .alert)
            self.present(signOutAlert, animated: true, completion: nil)
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            signOutAlert.addAction(cancelAction)
            
            let sureAction = UIAlertAction(title: "确定", style: .default, handler: { (sureAction) in
                
                UserDefaults.standard.set(false, forKey: isLogin_key)
                UserDefaults.standard.removeObject(forKey: logInfo_key)
//                self.presentViewController(UINavigationController(rootViewController: LoHomeViewController()), animated: true, completion: nil)
                
                
                UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LoHomeViewController())

            })
            signOutAlert.addAction(sureAction)
            
            
        default:
            print("挑战高薪-我的-设置-didSelectRowAtIndexPath  default")
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
