//
//  FTMiMyHiringRecordViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/9/24.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMiMyHiringRecordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height-20-44-49-37), style: .Grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setNavigationBar()
        setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = true
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        self.title = "我的招聘"
        
//        // rightBarButtonItem
//        let deleteBtn = UIButton(frame: CGRectMake(0, 0, 50, 24))
//        deleteBtn.setTitle("删除", forState: .Normal)
//        deleteBtn.addTarget(self, action: #selector(deleteBtnClick), forControlEvents: .TouchUpInside)
//        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: deleteBtn)
    }
    
//    // MARK: 删除按钮点击事件
//    func deleteBtnClick() {
//        print("ChChHomeViewController searchBtnClick")
//        //        self.navigationController?.pushViewController(ChChSearchViewController(), animated: true)
//    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()
        
        // tableView
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-20-44)
        rootTableView.registerNib(UINib.init(nibName: "FTMiMyHiringRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "FTMiMyHiringRecordCell")
        rootTableView.separatorStyle = .None
        rootTableView.rowHeight = 70
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
    }
    
    // MARK: UITableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FTMiMyHiringRecordCell") as! FTMiMyHiringRecordTableViewCell
        cell.selectionStyle = .None
        
        return cell
    }
    
    // MARK: UITableView Delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
