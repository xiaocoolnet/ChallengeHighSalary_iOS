//
//  ChChHomeViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/5.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChChHomeViewController: UIViewController, LFLUISegmentedControlDelegate, UITableViewDataSource {

    var salaryDrop = DropDown()
    var redEnvelopeDrop = DropDown()
    let myTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        setNavigationBar()
        setSubviews()
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        let cityBtn = UIButton(frame: CGRectMake(0, 0, 60, 44))
        cityBtn.setTitle("烟台", forState: .Normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cityBtn)
        
        //        let seg = UISegmentedControl(frame: CGRectMake(0, 0, 160, 44))
        let seg = UISegmentedControl(items: ["找工作","找雇主"])
        seg.frame = CGRectMake(0, 0, 120, 24)
        seg.selectedSegmentIndex = 0
        self.navigationItem.titleView = seg
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(searchBtnClick))
    }
    
    // MARK: 搜索按钮点击事件
    func searchBtnClick() {
        print("ChChHomeViewController searchBtnClick")
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
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
        salaryDrop.selectionAction = { [unowned self] (index, item) in
            
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
        redEnvelopeDrop.selectionAction = { [unowned self] (index, item) in
            
            redEnvelopeBtn.setTitle(item, forState: .Normal)
        }
        
        // 选择菜单
        let segChoose = LFLUISegmentedControl.segmentWithFrame(CGRectMake(0, 64,screenSize.width ,37), titleArray: ["最新","最热","最近","评价",salaryBtn,redEnvelopeBtn], defaultSelect: 0)
        segChoose.lineColor(baseColor)
        segChoose.titleColor(UIColor.blackColor(), selectTitleColor: baseColor, backGroundColor: UIColor.whiteColor(), titleFontSize: 14)
        segChoose.delegate = self
        self.view.addSubview(segChoose)
        
        // tableView
        myTableView.frame = CGRectMake(0, CGRectGetMaxY(segChoose.frame), screenSize.width, screenSize.height-20-44-49-37)
        myTableView.registerNib(UINib.init(nibName: "ChChHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "ChChHomeTableViewCell")
        myTableView.rowHeight = 140
        myTableView.dataSource = self
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
    func uisegumentSelectionChange(selection: Int) {
        print("ChChHomeViewController click \(selection) item")
        
        if selection == 4 {
            salaryDrop.show()
        }else if selection == 5 {
            redEnvelopeDrop.show()
        }
    }
    
    // MARK: UITableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChChHomeTableViewCell") as! ChChHomeTableViewCell
        
        return cell
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
