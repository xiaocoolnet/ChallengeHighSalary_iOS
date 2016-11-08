//
//  CHSMiMessageRemindViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/20.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiMessageRemindViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64), style: .grouped)
    let nameArray = ["职位邀约","投递反馈","聊天"]
    
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
        self.title = "消息提醒"
        
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 50
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.view.addSubview(rootTableView)
    }
    
    // MARK:- 设置按钮点击事件
    func setBtnClick() {
        self.navigationController?.pushViewController(CHSMiSettingViewController(), animated: true)
    }
    
    // MARK:- tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        
        cell?.textLabel!.text = nameArray[(indexPath as NSIndexPath).section]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell?.textLabel?.textAlignment = .left
        cell?.textLabel?.textColor = UIColor.black
        
        let swi = UISwitch.init(frame: CGRect(x: screenSize.width-51-10, y: 29/2.0, width: 51, height: 31))
        swi.isOn = UserDefaults.standard.bool(forKey: CHSMiMessageRemindSetting_key_pre+String((indexPath as NSIndexPath).section*100+(indexPath as NSIndexPath).row))
        swi.tag = (indexPath as NSIndexPath).section*100+(indexPath as NSIndexPath).row
        swi.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
//        print("消息提醒设置，indexPath.section === \(indexPath.section)，indexPath.row === \(indexPath.row)，swi.on = \(swi.on)")
        cell!.contentView.addSubview(swi)
        
        
        return cell!
    }
    
    func switchValueChanged(_ swi:UISwitch) {
        UserDefaults.standard.set(swi.isOn, forKey: CHSMiMessageRemindSetting_key_pre+String(swi.tag))
//        print("消息提醒设置，swi.tag === \(swi.tag)，swi.on = \(swi.on) && \(NSUserDefaults.standardUserDefaults().boolForKey("CHSMiMessageRemindSetting\(swi.tag)"))")
    }
    
    // MARK:- tableview delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return kHeightScale*10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
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
