//
//  FTMiSettingViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/24.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMiSettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRectMake(0, 64, screenSize.width, screenSize.height-64), style: .Grouped)
    let nameArray = [["手机绑定","设置密码","消息提醒"],["关于我们"],["切换身份"],["退出当前账号"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))
        
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        self.title = "设置"
        
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-64)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 50
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.tableFooterView = UIView(frame: CGRectZero)
        self.view.addSubview(rootTableView)
    }
    
    // MARK:- tableview datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray[section].count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return nameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CHSMiSettingCell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "CHSMiSettingCell")
        }
        cell!.selectionStyle = .None
        
        cell?.textLabel!.text = nameArray[indexPath.section][indexPath.row]
        
        if indexPath.section == nameArray.endIndex-1 {
            cell!.accessoryType = .None
            
            cell?.textLabel?.font = UIFont.systemFontOfSize(16)
            cell?.textLabel?.textAlignment = .Center
            cell?.textLabel?.textColor = UIColor.whiteColor()
            cell?.backgroundColor = baseColor
        }else{
            cell!.accessoryType = .DisclosureIndicator
            
            cell?.textLabel?.font = UIFont.systemFontOfSize(15)
            cell?.textLabel?.textAlignment = .Left
            cell?.textLabel?.textColor = UIColor.blackColor()
            cell?.backgroundColor = UIColor.whiteColor()
        }
        
        return cell!
    }
    
    // MARK:- tableview delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == nameArray.endIndex-1 {
            return kHeightScale*90
        }else{
            return kHeightScale*15
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            self.navigationController?.pushViewController(CHSMiPhoneBindingViewController(), animated: true)
        case (0,1):
            self.navigationController?.pushViewController(CHSMiCheckPasswordViewController(), animated: true)
        case (0,2):
            self.navigationController?.pushViewController(CHSMiMessageRemindViewController(), animated: true)
        case (1,0):
            self.navigationController?.pushViewController(CHSMiAboutUsViewController(), animated: true)
        case (2,0):
            self.navigationController?.pushViewController(FTMiChangeIdentityViewController(), animated: true)
        case (3,0):
            
            let signOutAlert = UIAlertController(title: "", message: "确定退出登录？", preferredStyle: .Alert)
            self.presentViewController(signOutAlert, animated: true, completion: nil)
            
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            signOutAlert.addAction(cancelAction)
            
            let sureAction = UIAlertAction(title: "确定", style: .Default, handler: { (sureAction) in
                
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: isLogin_key)
                NSUserDefaults.standardUserDefaults().removeObjectForKey(logInfo_key)
//                self.presentViewController(UINavigationController(rootViewController: LoHomeViewController()), animated: true, completion: nil)
                
                UIApplication.sharedApplication().keyWindow?.rootViewController = UINavigationController(rootViewController: LoHomeViewController())
            })
            signOutAlert.addAction(sureAction)
            
            
        default:
            print("抢人才-我的-设置-didSelectRowAtIndexPath  default")
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
