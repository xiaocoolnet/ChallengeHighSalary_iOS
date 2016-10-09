//
//  FTMeHomeViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/8.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMeHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height-20-44-49), style: .Plain)
    
    let dataArray = [
        [
            "title":"系统消息",
            "description":"北京时代网络公司正在招聘网页设计师噢",
            "time":"07月20日",
            "type":"1"
        ],
        [
            "title":"简历投递通知",
            "description":"北京时代网络公司邀请您去面试",
            "time":"07月20日",
            "type":"2"
        ],
        [
            "title":"谁收藏我",
            "description":"北京时代网络公司收藏了您的简历",
            "time":"07月20日",
            "type":"3"
        ],
        [
            "title":"谁看过我",
            "description":"北京时代网络公司查看了您的简历",
            "time":"07月20日",
            "type":"4"
        ],
        [
            "title":"王小妞",
            "description":"",
            "time":"07月20日",
            "type":"5"
        ],
        [
            "title":"李大壮",
            "description":"",
            "time":"07月20日",
            "type":"5"
        ],
        [
            "title":"第三者",
            "description":"",
            "time":"07月20日",
            "type":"5"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setNavigationBar()
        setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = false
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        self.title = "消息"
        
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()
        
        // tableView
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-20-44-49)
        rootTableView.registerNib(UINib.init(nibName: "FTMeHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "FTMeHomeCell")
        rootTableView.rowHeight = 66
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
    }
    
    // MARK: UITableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FTMeHomeCell") as! FTMeHomeTableViewCell
        cell.selectionStyle = .None
        
        cell.titleLab.text = self.dataArray[indexPath.row]["title"]!
        cell.descriptionLab.text = self.dataArray[indexPath.row]["description"]!
        cell.timeLab.text = self.dataArray[indexPath.row]["time"]!
        
        return cell
    }
    
    // MARK: UITableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch self.dataArray[indexPath.row]["type"]! {
        case "1":
            self.navigationController?.pushViewController(FTMeSysMessageViewController(), animated: true)
        case "2":
            self.navigationController?.pushViewController(FTMeResumeNotificationViewController(), animated: true)
        case "3":
            self.navigationController?.pushViewController(FTMeCollectionMeViewController(), animated: true)
        case "4":
            self.navigationController?.pushViewController(FTMeLookMeViewController(), animated: true)
        default:
            break
        }
        //        self.navigationController?.pushViewController(CHSChPersonalInfoViewController(), animated: true)
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
