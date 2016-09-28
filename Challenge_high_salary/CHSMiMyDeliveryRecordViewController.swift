//
//  CHSMiMyDeliveryRecordViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/21.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiMyDeliveryRecordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height-20-44-49-37), style: .Grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
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
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "我的投递记录"

        // tableView
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-20-44)
        rootTableView.registerNib(UINib.init(nibName: "ChChFindJobTableViewCell", bundle: nil), forCellReuseIdentifier: "ChChFindJobTableViewCell")
        rootTableView.separatorStyle = .None
        rootTableView.rowHeight = 140
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChChFindJobTableViewCell") as! ChChFindJobTableViewCell
        cell.selectionStyle = .None
        
        cell.companyBtn.addTarget(self, action: #selector(companyBtnClick), forControlEvents: .TouchUpInside)
        
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
        self.navigationController?.pushViewController(CHSChPersonalInfoViewController(), animated: true)
    }
    
    // MARK:- companyBtnClick
    func companyBtnClick() {
        self.navigationController?.pushViewController(CHSChCompanyHomeViewController(), animated: true)
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
