//
//  FTTaHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/8.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import MJRefresh

class FTTaHomeViewController: UIViewController, LFLUISegmentedControlDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    var onlineStateDrop = DropDown()
    
    let myTableView = UITableView(frame: CGRect(x: screenSize.width, y: 0, width: screenSize.width, height: screenSize.height-20-44-49-37), style: .plain)
    
    var resumeModel = [MyResumeData]()
    
    var hasPosition = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setNavigationBar()
        setSubviews()
//        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.customizeDropDown()
    }
    
    // MARK: 加载数据
    func loadData() {
        FTNetUtil().getResumeList("") { (success, response) in
            if success {
                self.resumeModel = response as! [MyResumeData]
                self.myTableView.reloadData()
            }else{
                self.hasPosition = false
                self.myTableView.reloadData()
            }
            
            self.myTableView.mj_header.endRefreshing()
        }
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        self.navigationItem.title = "人才"

        // rightBarButtonItem
        let retrievalBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 24))
        retrievalBtn.setImage(UIImage(named: "ic_筛选"), for: UIControlState())
        retrievalBtn.addTarget(self, action: #selector(retrievalBtnClick), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: retrievalBtn)
    }
    
    // MARK: 检索按钮点击事件
    func retrievalBtnClick() {
        print("ChChHomeViewController searchBtnClick")
        
        let retrievalController = FTTaRetrievalViewController()
        retrievalController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(retrievalController, animated: true)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        // 在线状态
        let onlineStateBtn = UIButton()
        onlineStateBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        onlineStateBtn.setTitle("经验", for: UIControlState())
        onlineStateBtn.setImage(UIImage(named: "ic_下拉"), for: UIControlState())
        exchangeBtnImageAndTitle(onlineStateBtn, margin: 5)
        
        // 经验 下拉
        onlineStateDrop.anchorView = onlineStateBtn
        
        onlineStateDrop.bottomOffset = CGPoint(x: 0, y: 38)
        onlineStateDrop.width = screenSize.width
        onlineStateDrop.direction = .bottom
        
        onlineStateDrop.dataSource = ["在线","不在线"]
        
        // 下拉列表选中后的回调方法
        onlineStateDrop.selectionAction = { (index, item) in
            
            onlineStateBtn.setTitle(item, for: UIControlState())
        }
        
        // 选择菜单
        let segChoose = LFLUISegmentedControl.segment(withFrame: CGRect(x: 0, y: 64,width: screenSize.width ,height: 37), titleArray: ["推荐","最近","最热","最新","好评",onlineStateBtn], defaultSelect: 0)!
        segChoose.tag = 102
        segChoose.lineColor(baseColor)
        segChoose.titleColor(UIColor.black, selectTitleColor: baseColor, backGroundColor: UIColor.white, titleFontSize: 14)
        segChoose.delegate = self
        self.view.addSubview(segChoose)
        
        // tableView
        myTableView.frame = CGRect(x: 0, y: segChoose.frame.maxY+1, width: screenSize.width, height: screenSize.height-20-44-49-37)
        myTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        myTableView.register(UINib.init(nibName: "FTTalentTableViewCell", bundle: nil), forCellReuseIdentifier: "FTTalentCell")
        myTableView.register(FTTaNoPositionTableViewCell.self, forCellReuseIdentifier: "FTTaNoPositionTableViewCell")
        myTableView.separatorStyle = .none
        myTableView.rowHeight = 250
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        
        myTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadData))
        myTableView.mj_header.beginRefreshing()
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
        appearance.textColor = .darkGray
        appearance.textFont = UIFont.systemFont(ofSize: 14)
    }
    
    // MARK: LFLUISegmentedControlDelegate
    func uisegumentSelectionChange(_ selection: Int, segmentTag: Int) {
        print("ChChHomeViewController click \(selection) item")
        
        if selection == 5 {
            _ = onlineStateDrop.show()
        }
    }
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if hasPosition {
//            return 1
//        }else{
//        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if hasPosition {
            return self.resumeModel.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if hasPosition {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FTTalentCell") as! FTTalentTableViewCell
            cell.selectionStyle = .none
            
            cell.resumeData = self.resumeModel[(indexPath as NSIndexPath).section]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FTTaNoPositionTableViewCell") as! FTTaNoPositionTableViewCell
            cell.selectionStyle = .none
//            cell.textLabel?.text = "空空如也"
            cell.publishJobBtn.addTarget(self, action: #selector(publishJobBtnClick), for: .touchUpInside)
            return cell
        }
        
    }
    
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if hasPosition {
            return 8
        }else{
            return 0.0001
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if hasPosition {
            return 139
        }else{
            return screenSize.height-64-37-49
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let personalVC = FTPersonalViewController()
        personalVC.resumeData = self.resumeModel[indexPath.section]
        self.navigationController?.pushViewController(personalVC, animated: true)
    }

    // MARK:- 发布职位按钮点击事件
    func publishJobBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
        checkCodeHud.removeFromSuperViewOnHide = true
        checkCodeHud.labelText = "正在获取公司信息"
        
        FTNetUtil().getMyCompany_info(CHSUserInfo.currentUserInfo.userid) { (success, response) in
            if success {
                checkCodeHud.hide(true)
                
                self.navigationController?.pushViewController(FTTaPositionViewController(), animated: true)
            }else{
                
                
                checkCodeHud.mode = .text
                checkCodeHud.labelText = "尚无公司信息"
                checkCodeHud.detailsLabelText = "请先到 我-我的公司信息 中 完善公司信息"
                checkCodeHud.hide(true, afterDelay: 1)
            }
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
