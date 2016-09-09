//
//  ChChHomeViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/5.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChChHomeViewController: UIViewController, LFLUISegmentedControlDelegate, UITableViewDataSource, UITableViewDelegate {

    let cityBtn = UIButton()
    
    let rootScrollView = UIScrollView()
    
    var salaryDrop = DropDown()
    var redEnvelopeDrop = DropDown()
    let findJobTableView = UITableView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height-20-44-49-37), style: .Grouped)
    
    var scaleDrop = DropDown()
    var nearbyDrop = DropDown()
    let findEmployerTableView = UITableView(frame: CGRectMake(screenSize.width, 0, screenSize.width, screenSize.height-20-44-49-37), style: .Plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        NSNotificationCenter.defaultCenter().addObserverForName("positioningCityNotification", object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (noti) in
            print("chchhome.. 执行")

            self.cityBtn.setTitle(positioningCity, forState: .Normal)
        })
        
        setNavigationBar()
        setSubviews()
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        cityBtn.frame = CGRectMake(0, 0, 60, 44)
        cityBtn.setTitle(positioningCity, forState: .Normal)
        cityBtn.addTarget(self, action: #selector(cityBtnClick), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cityBtn)
        
        //        let seg = UISegmentedControl(frame: CGRectMake(0, 0, 160, 44))
        let seg = UISegmentedControl(items: ["找工作","找雇主"])
        seg.frame = CGRectMake(0, 0, 120, 24)
        seg.addTarget(self, action: #selector(segValueChanged(_:)), forControlEvents: .ValueChanged)
        seg.selectedSegmentIndex = 0
        self.navigationItem.titleView = seg
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(searchBtnClick))
    }
    
    // MARK: 城市按钮点击事件
    func cityBtnClick() {
        self.navigationController?.pushViewController(ChChCityViewController(), animated: true)
    }
    
    // MARK: 搜索按钮点击事件
    func searchBtnClick() {
        print("ChChHomeViewController searchBtnClick")
        self.navigationController?.pushViewController(ChChSearchViewController(), animated: true)
    }
    
    // MARK: seg 点击事件
    func segValueChanged(seg:UISegmentedControl) {
        print(seg.selectedSegmentIndex)
        
        self.rootScrollView.contentOffset = CGPointMake(CGFloat(seg.selectedSegmentIndex)*screenSize.width, 0)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        rootScrollView.frame = CGRectMake(0, 64,screenSize.width ,screenSize.height-49-64)
        rootScrollView.contentSize = CGSizeMake(screenSize.width*2, screenSize.height-49-64)
        rootScrollView.scrollEnabled = false
        self.view.addSubview(rootScrollView)
        
        setSubviews_findJob()
        setSubviews_findEmployer()
    }
    
    // MARK: 设置子视图_找工作
    func setSubviews_findJob() {
        
        // 自定义下拉列表样式
        customizeDropDown()
        
        // 薪资
        let salaryBtn = UIButton()
        salaryBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        salaryBtn.setTitle("薪资", forState: .Normal)
        
        // 薪资 下拉
        salaryDrop.anchorView = salaryBtn
        
        salaryDrop.bottomOffset = CGPoint(x: 0, y: 37)
        salaryDrop.width = screenSize.width
        salaryDrop.direction = .Bottom
        
        salaryDrop.dataSource = ["不限","1万以下","1~2万","2~3万","3~4万","4~5万","5万以上"]
        
        // 下拉列表选中后的回调方法
        salaryDrop.selectionAction = { (index, item) in
            
            salaryBtn.setTitle(item, forState: .Normal)
        }
        
        // 红包
        let redEnvelopeBtn = UIButton()
        redEnvelopeBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        redEnvelopeBtn.setTitle("红包", forState: .Normal)
        
        // 红包 下拉
        redEnvelopeDrop.anchorView = redEnvelopeBtn
        
        redEnvelopeDrop.bottomOffset = CGPoint(x: 0, y: 37)
        redEnvelopeDrop.width = screenSize.width
        redEnvelopeDrop.direction = .Bottom
        
        redEnvelopeDrop.dataSource = ["测试用","大红包","小红包","不大不小的红包"]
        
        // 下拉列表选中后的回调方法
        redEnvelopeDrop.selectionAction = { (index, item) in
            
            redEnvelopeBtn.setTitle(item, forState: .Normal)
        }
        
        // 选择菜单
        let segChoose = LFLUISegmentedControl.segmentWithFrame(CGRectMake(0, 0,screenSize.width ,37), titleArray: ["最新","最热","最近","评价",salaryBtn,redEnvelopeBtn], defaultSelect: 0)
        segChoose.tag = 101
        segChoose.lineColor(baseColor)
        segChoose.titleColor(UIColor.blackColor(), selectTitleColor: baseColor, backGroundColor: UIColor.whiteColor(), titleFontSize: 14)
        segChoose.delegate = self
        self.rootScrollView.addSubview(segChoose)
        
        // tableView
        findJobTableView.frame = CGRectMake(0, CGRectGetMaxY(segChoose.frame), screenSize.width, screenSize.height-20-44-49-37)
        findJobTableView.registerNib(UINib.init(nibName: "ChChFindJobTableViewCell", bundle: nil), forCellReuseIdentifier: "ChChFindJobTableViewCell")
        findJobTableView.separatorStyle = .None
        findJobTableView.rowHeight = 140
        findJobTableView.tag = 101
        findJobTableView.dataSource = self
        findJobTableView.delegate = self
        self.rootScrollView.addSubview(findJobTableView)
    }
    
    // MARK: 设置子视图_找雇主
    func setSubviews_findEmployer() {
        
        // 规模
        let scaleBtn = UIButton()
        scaleBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        scaleBtn.setTitle("规模", forState: .Normal)
        
        // 规模 下拉
        scaleDrop.anchorView = scaleBtn
        
        scaleDrop.bottomOffset = CGPoint(x: 0, y: 37)
        scaleDrop.width = screenSize.width
        scaleDrop.direction = .Bottom
        
        scaleDrop.dataSource = ["不限","一人","2人","3人"]
        
        // 下拉列表选中后的回调方法
        scaleDrop.selectionAction = { (index, item) in
            
            scaleBtn.setTitle(item, forState: .Normal)
        }
        
        // 附近
        let nearbyBtn = UIButton()
        nearbyBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        nearbyBtn.setTitle("附近", forState: .Normal)
        
        // 附近 下拉
        nearbyDrop.anchorView = nearbyBtn
        
        nearbyDrop.bottomOffset = CGPoint(x: 0, y: 37)
        nearbyDrop.width = screenSize.width
        nearbyDrop.direction = .Bottom
        
        nearbyDrop.dataSource = ["测试用","一米","两米","三米"]
        
        // 下拉列表选中后的回调方法
        nearbyDrop.selectionAction = { (index, item) in
            
            nearbyBtn.setTitle(item, forState: .Normal)
        }
        
        // 选择菜单
        let segChoose = LFLUISegmentedControl.segmentWithFrame(CGRectMake(screenSize.width, 0,screenSize.width ,37), titleArray: ["最新",scaleBtn,nearbyBtn], defaultSelect: 0)
        segChoose.tag = 102
        segChoose.lineColor(baseColor)
        segChoose.titleColor(UIColor.blackColor(), selectTitleColor: baseColor, backGroundColor: UIColor.whiteColor(), titleFontSize: 14)
        segChoose.delegate = self
        self.rootScrollView.addSubview(segChoose)
        
        // tableView
        findEmployerTableView.frame = CGRectMake(screenSize.width, CGRectGetMaxY(segChoose.frame), screenSize.width, screenSize.height-20-44-49-37)
        findEmployerTableView.registerNib(UINib.init(nibName: "ChChFindEmployerTableViewCell", bundle: nil), forCellReuseIdentifier: "ChChFindEmployerTableViewCell")
        findEmployerTableView.separatorStyle = .None
        findEmployerTableView.rowHeight = 250
        findEmployerTableView.tag = 102
        findEmployerTableView.dataSource = self
        findEmployerTableView.delegate = self
        self.rootScrollView.addSubview(findEmployerTableView)
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
        
        if segmentTag == 101 {
            
            if selection == 4 {
                salaryDrop.show()
            }else if selection == 5 {
                redEnvelopeDrop.show()
            }
        }else if segmentTag == 102 {
            
            if selection == 1 {
                scaleDrop.show()
            }else if selection == 2 {
                nearbyDrop.show()
            }
        }
    }
    
    // MARK: UITableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 101 {
            return 1
        }else{
            return 8
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView.tag == 101 {
            return 10
        }else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView.tag == 101 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ChChFindJobTableViewCell") as! ChChFindJobTableViewCell
            cell.selectionStyle = .None
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("ChChFindEmployerTableViewCell") as! ChChFindEmployerTableViewCell
            cell.selectionStyle = .None
            
            return cell
        }
        
    }
    
    // MARK: UITableView Delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
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
