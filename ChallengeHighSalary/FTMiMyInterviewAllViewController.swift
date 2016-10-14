//
//  FTMiMyInterviewAllViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMiMyInterviewAllViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRectMake(0, 64, screenSize.width, screenSize.height-20-44), style: .Grouped)
    
    var typeDrop = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.title = "我的面试邀请"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))

        self.view.backgroundColor = UIColor.whiteColor()
        
        // tableView
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-20-44)
        rootTableView.registerNib(UINib.init(nibName: "FTMyInterviewInvitationTableViewCell", bundle: nil), forCellReuseIdentifier: "FTMyInterviewInvitationCell")
        rootTableView.separatorStyle = .None
        rootTableView.rowHeight = 130
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        setHeaderView()
    }
    
    // MARK:- 设置tableview 头视图
    func setHeaderView() {
        let headerView = UIView(frame: CGRectMake(0, 0, screenSize.width, 44))
        headerView.backgroundColor = UIColor.whiteColor()
        
        let tipLab = UILabel(frame: CGRectMake(
            8,
            0,
            screenSize.width-8-8-100,
            44))
        tipLab.textAlignment = .Left
        tipLab.textColor = UIColor.blackColor()
        tipLab.font = UIFont.systemFontOfSize(14)
        tipLab.text = "你一共发出4个面试邀请"
        headerView.addSubview(tipLab)
        
        let typeBtn = UIButton(frame: CGRectMake(
            screenSize.width-100-8, 0, 100, 44))
        typeBtn.contentHorizontalAlignment = .Right
        typeBtn.setTitleColor(baseColor, forState: .Normal)
        typeBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        typeBtn.setTitle("全部", forState: .Normal)
        typeBtn.setImage(UIImage(named: "ic_下拉"), forState: .Normal)
        exchangeBtnImageAndTitle(typeBtn, margin: 5)
        typeBtn.addTarget(self, action: #selector(interviewTypeBtnClick), forControlEvents: .TouchUpInside)
        headerView.addSubview(typeBtn)
        
        // 面试邀请类型 下拉
        typeDrop.anchorView = typeBtn
        
        typeDrop.bottomOffset = CGPoint(x: 0, y: 38)
        typeDrop.width = screenSize.width
        typeDrop.direction = .Bottom
        
        typeDrop.dataSource = ["不限","一年","2年","3年"]
        
        // 下拉列表选中后的回调方法
        typeDrop.selectionAction = { (index, item) in
            
            typeBtn.setTitle(item, forState: .Normal)
        }
        
        self.rootTableView.tableHeaderView = headerView
    }
    
    // 面试邀请类型 按钮 点击事件
    func interviewTypeBtnClick() {
        typeDrop.show()
    }
    
    // MARK: UITableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FTMyInterviewInvitationCell") as! FTMyInterviewInvitationTableViewCell
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
