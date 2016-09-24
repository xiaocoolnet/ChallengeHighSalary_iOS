//
//  FTTaPositionViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/9/24.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaPositionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRectMake(0, 64, screenSize.width, screenSize.height-64), style: .Grouped)
    let nameArray = [["公司信息"],["职位类型","职位名称","技能要求","薪资范围"],["经验要求","学历要求"],["工作城市","工作地点","职位描述"]]
    
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
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        self.title = "发布职位"
        
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-64-44)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 50
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.tableFooterView = UIView(frame: CGRectZero)
        self.view.addSubview(rootTableView)
        
        let postPositionBtn = UIButton(frame: CGRectMake(0, screenSize.height-44, screenSize.width, 44))
        postPositionBtn.backgroundColor = baseColor
        postPositionBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        postPositionBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        postPositionBtn.setTitle("发布职位", forState: .Normal)
        self.view.addSubview(postPositionBtn)
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
        
        cell!.accessoryType = .DisclosureIndicator
        
        cell?.textLabel?.font = UIFont.systemFontOfSize(15)
        cell?.textLabel?.textAlignment = .Left
        cell?.textLabel?.textColor = UIColor.blackColor()
        cell?.backgroundColor = UIColor.whiteColor()
        
        return cell!
    }
    
    // MARK:- tableview delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return kHeightScale*15
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            self.navigationController?.pushViewController(FTTaCompanyInfoViewController(), animated: true)
//        case (0,1):
//            self.navigationController?.pushViewController(CHSMiCheckPasswordViewController(), animated: true)
//        case (0,2):
//            self.navigationController?.pushViewController(CHSMiMessageRemindViewController(), animated: true)
//        case (1,0):
//            self.navigationController?.pushViewController(CHSMiAboutUsViewController(), animated: true)
//        case (3,0):
//            
//            let signOutAlert = UIAlertController(title: "", message: "确定退出登录？", preferredStyle: .Alert)
//            self.presentViewController(signOutAlert, animated: true, completion: nil)
//            
//            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
//            signOutAlert.addAction(cancelAction)
//            
//            let sureAction = UIAlertAction(title: "确定", style: .Default, handler: { (sureAction) in
//                
//                UIApplication.sharedApplication().keyWindow?.rootViewController = UINavigationController(rootViewController: LoHomeViewController())
//            })
//            signOutAlert.addAction(sureAction)
            
            
        default:
            print("找人才-人才-发布职位-didSelectRowAtIndexPath  default")
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
