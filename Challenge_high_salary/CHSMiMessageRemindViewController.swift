//
//  CHSMiMessageRemindViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/20.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiMessageRemindViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRectMake(0, 64, screenSize.width, screenSize.height-64), style: .Grouped)
    let nameArray = ["职位邀约","投递反馈","聊天"]
    
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
        self.title = "消息提醒"
        
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-64)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 50
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.tableFooterView = UIView(frame: CGRectZero)
        self.view.addSubview(rootTableView)
    }
    
    // MARK:- 设置按钮点击事件
    func setBtnClick() {
        self.navigationController?.pushViewController(CHSMiSettingViewController(), animated: true)
    }
    
    // MARK:- tableview datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        
        cell?.backgroundColor = UIColor.whiteColor()
        
        cell?.textLabel!.text = nameArray[indexPath.section]
        cell?.textLabel?.font = UIFont.systemFontOfSize(15)
        cell?.textLabel?.textAlignment = .Left
        cell?.textLabel?.textColor = UIColor.blackColor()
        
        let swi = UISwitch.init(frame: CGRectMake(screenSize.width-51-10, 29/2.0, 51, 31))
        swi.on = NSUserDefaults.standardUserDefaults().boolForKey(CHSMiMessageRemindSetting_key_pre+String(indexPath.section*100+indexPath.row))
        swi.tag = indexPath.section*100+indexPath.row
        swi.addTarget(self, action: #selector(switchValueChanged(_:)), forControlEvents: .ValueChanged)
//        print("消息提醒设置，indexPath.section === \(indexPath.section)，indexPath.row === \(indexPath.row)，swi.on = \(swi.on)")
        cell!.contentView.addSubview(swi)
        
        
        return cell!
    }
    
    func switchValueChanged(swi:UISwitch) {
        NSUserDefaults.standardUserDefaults().setBool(swi.on, forKey: CHSMiMessageRemindSetting_key_pre+String(swi.tag))
//        print("消息提醒设置，swi.tag === \(swi.tag)，swi.on = \(swi.on) && \(NSUserDefaults.standardUserDefaults().boolForKey("CHSMiMessageRemindSetting\(swi.tag)"))")
    }
    
    // MARK:- tableview delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return kHeightScale*10
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
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
