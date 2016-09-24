//
//  FTTaHomeViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/8.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaHomeViewController: UIViewController, LFLUISegmentedControlDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    var experienceDrop = DropDown()
    var eduDrop = DropDown()
    let myTableView = UITableView(frame: CGRectMake(screenSize.width, 0, screenSize.width, screenSize.height-20-44-49-37), style: .Plain)
    
    var hasPosition = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setNavigationBar()
        setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.customizeDropDown()
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        self.navigationItem.title = "人才"

        // rightBarButtonItem
        let retrievalBtn = UIButton(frame: CGRectMake(0, 0, 50, 24))
        retrievalBtn.setTitle("检索", forState: .Normal)
        retrievalBtn.addTarget(self, action: #selector(retrievalBtnClick), forControlEvents: .TouchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: retrievalBtn)
    }
    
    // MARK: 检索按钮点击事件
    func retrievalBtnClick() {
        print("ChChHomeViewController searchBtnClick")
        self.navigationController?.pushViewController(FTTaRetrievalViewController(), animated: true)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1)
        
        // 经验
        let experienceBtn = UIButton()
        experienceBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        experienceBtn.setTitle("经验", forState: .Normal)
        
        // 经验 下拉
        experienceDrop.anchorView = experienceBtn
        
        experienceDrop.bottomOffset = CGPoint(x: 0, y: 38)
        experienceDrop.width = screenSize.width
        experienceDrop.direction = .Bottom
        
        experienceDrop.dataSource = ["不限","一年","2年","3年"]
        
        // 下拉列表选中后的回调方法
        experienceDrop.selectionAction = { (index, item) in
            
            experienceBtn.setTitle(item, forState: .Normal)
        }
        
        // 学历
        let eduBtn = UIButton()
        eduBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        eduBtn.setTitle("学历", forState: .Normal)
        
        // 学历 下拉
        eduDrop.anchorView = eduBtn
        
        eduDrop.bottomOffset = CGPoint(x: 0, y: 38)
        eduDrop.width = screenSize.width
        eduDrop.direction = .Bottom
        
        eduDrop.dataSource = ["测试用","本科","专科","研究生"]
        
        // 下拉列表选中后的回调方法
        eduDrop.selectionAction = { (index, item) in
            
            eduBtn.setTitle(item, forState: .Normal)
        }
        
        // 选择菜单
        let segChoose = LFLUISegmentedControl.segmentWithFrame(CGRectMake(0, 64,screenSize.width ,37), titleArray: ["最新",experienceBtn,eduBtn], defaultSelect: 0)
        segChoose.tag = 102
        segChoose.lineColor(baseColor)
        segChoose.titleColor(UIColor.blackColor(), selectTitleColor: baseColor, backGroundColor: UIColor.whiteColor(), titleFontSize: 14)
        segChoose.delegate = self
        self.view.addSubview(segChoose)
        
        // tableView
        myTableView.frame = CGRectMake(0, CGRectGetMaxY(segChoose.frame)+1, screenSize.width, screenSize.height-20-44-49-37)
        myTableView.registerNib(UINib.init(nibName: "FTTalentTableViewCell", bundle: nil), forCellReuseIdentifier: "FTTalentCell")
        myTableView.registerClass(FTTaNoPositionTableViewCell.self, forCellReuseIdentifier: "FTTaNoPositionTableViewCell")
        myTableView.separatorStyle = .None
        myTableView.rowHeight = 250
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
    
    // MARK:自定义下拉列表样式
    func customizeDropDown() {
        let appearance = DropDown.appearance()
        
        appearance.cellHeight = 45
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        appearance.separatorColor = UIColor(white: 0.7, alpha: 0.8)
        appearance.cornerRadiu = 0
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.9
        appearance.shadowRadius = 0
        appearance.animationduration = 0.25
        appearance.textColor = .darkGrayColor()
        appearance.textFont = UIFont.systemFontOfSize(14)
    }
    
    // MARK: LFLUISegmentedControlDelegate
    func uisegumentSelectionChange(selection: Int, segmentTag: Int) {
        print("ChChHomeViewController click \(selection) item")
        
        if selection == 1 {
            experienceDrop.show()
        }else if selection == 2 {
            eduDrop.show()
        }
    }
    
    // MARK: UITableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if hasPosition {
//            return 1
//        }else{
//        }
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if hasPosition {
            return 10
        }else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if hasPosition {
            let cell = tableView.dequeueReusableCellWithIdentifier("FTTalentCell") as! FTTalentTableViewCell
            cell.selectionStyle = .None
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("FTTaNoPositionTableViewCell") as! FTTaNoPositionTableViewCell
            cell.selectionStyle = .None
//            cell.textLabel?.text = "空空如也"
            cell.publishJobBtn.addTarget(self, action: #selector(publishJobBtnClick), forControlEvents: .TouchUpInside)
            return cell
        }
        
    }
    
    // MARK: UITableView Delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if hasPosition {
            return 8
        }else{
            return 0.0001
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.publishJobBtnClick()
    }
    // MARK:- 发布职位按钮点击事件
    func publishJobBtnClick() {
        self.navigationController?.pushViewController(FTTaPositionViewController(), animated: true)
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
