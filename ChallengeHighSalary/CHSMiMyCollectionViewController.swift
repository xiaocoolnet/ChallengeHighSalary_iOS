//
//  CHSMiMyCollectionViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/21.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiMyCollectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height-20-44-49-37), style: .Grouped)
    let sureDeleteBtn = UIButton()
    
    var jobInfoData: [JobInfoDataModel]?
    var deleteJobInfoData = [JobInfoDataModel]()
    
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
        
        self.loadData()
    }
    
    // MARK: 加载数据
    func loadData() {
        
        PublicNetUtil().getfavoritelist(CHSUserInfo.currentUserInfo.userid, type: "1") { (success, response) in
            if success {
                self.jobInfoData = response as? [JobInfoDataModel]
                self.rootTableView.reloadData()
            }
        }
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        self.title = "我的收藏"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))

        // rightBarButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_删除"), style: .Done, target: self, action: #selector(deleteBtnClick))
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: 删除按钮点击事件
    func deleteBtnClick() {
        print("CHSMiMyCollectionViewController deleteBtnClick")
        
        if self.sureDeleteBtn.hidden {
            
            self.rootTableView.frame.size.height = screenSize.height-20-44-sureDeleteBtn.frame.size.height
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .Done, target: self, action: #selector(deleteBtnClick))

        }else{
            self.rootTableView.frame.size.height = screenSize.height-20-44
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_删除"), style: .Done, target: self, action: #selector(deleteBtnClick))

        }
        self.sureDeleteBtn.hidden = !self.sureDeleteBtn.hidden
        self.rootTableView.editing = !self.rootTableView.editing;

//        self.rootTableView.editing = true
//        self.navigationController?.pushViewController(ChChSearchViewController(), animated: true)
    }
    
    // MARK: 下方确认删除按钮 点击事件
    func sureDeleteBtnClick() {
        let alert = UIAlertController(title: "", message: "确定要删除所选的 \(self.deleteJobInfoData.count) 个收藏吗？", preferredStyle: .Alert)
        self.presentViewController(alert, animated: true, completion: nil)
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let sureAction = UIAlertAction(title: "确定", style: .Default, handler: { (sureAction) in
            
            var jobidStr = ""
            for (i,jobInfo) in self.deleteJobInfoData.enumerate() {
                if i == self.deleteJobInfoData.count-1 {
                    jobidStr += "\((jobInfo.jobid ?? "")!)"
                }else{
                    jobidStr += "\((jobInfo.jobid ?? "")!),"
                }
            }
            PublicNetUtil().cancelfavorite(CHSUserInfo.currentUserInfo.userid, object_id: jobidStr, type: "1", handle: { (success, response) in
                if success {
                    for jobInfo in self.deleteJobInfoData {
                        self.jobInfoData?.removeAtIndex((self.jobInfoData?.indexOf(jobInfo))!)
                    }
                    self.rootTableView.reloadData()
                    self.deleteBtnClick()
                }
            })
            
        })
        alert.addAction(sureAction)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()

        // tableView
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-20-44)
        rootTableView.registerNib(UINib.init(nibName: "ChChFindJobTableViewCell", bundle: nil), forCellReuseIdentifier: "ChChFindJobTableViewCell")
        rootTableView.separatorStyle = .None
        rootTableView.rowHeight = 140
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        self.rootTableView.editing = false
        self.rootTableView.allowsMultipleSelectionDuringEditing = true
        
        sureDeleteBtn.frame = CGRectMake(
            0,
            screenSize.height-kHeightScale*44,
            screenSize.width,
            kHeightScale*44)
        sureDeleteBtn.backgroundColor = baseColor
        //        chatBtn_2.layer.cornerRadius = chatBtn.frame.size.height/2.0
        sureDeleteBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sureDeleteBtn.setTitle("删除", forState: .Normal)
        sureDeleteBtn.addTarget(self, action: #selector(sureDeleteBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(sureDeleteBtn)
        sureDeleteBtn.hidden = true

    }
    
    // MARK: UITableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (self.jobInfoData?.count ?? 0)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChChFindJobTableViewCell") as! ChChFindJobTableViewCell
//        cell.selectionStyle = .None
        
        cell.jobInfo = self.jobInfoData![indexPath.section]
//        cell.companyBtn.addTarget(self, action: #selector(companyBtnClick), forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    //是否可以编辑  默认的时YES
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //选择编辑的方式,按照选择的方式对表进行处理
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
        }
    }
    
    // MARK: UITableView Delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView.editing {
            self.deleteJobInfoData.append(self.jobInfoData![indexPath.section])
        }else{
            
            let personalInfoVC = CHSChPersonalInfoViewController()
            personalInfoVC.jobInfo = self.jobInfoData![indexPath.section]
            
            self.navigationController?.pushViewController(personalInfoVC, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.editing {
            
            let index = self.deleteJobInfoData.indexOf(self.jobInfoData![indexPath.section])
            
            if (index != nil) {
                self.deleteJobInfoData.removeAtIndex(index!)
            }
            
//            for (i,jobInfo) in self.deleteJobInfoData!.enumerate() {
//                if jobInfo == self.jobInfoData![indexPath.row] {
//                    self.deleteJobInfoData?.removeAtIndex(i)
//                }
//            }
        }
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle(rawValue: UITableViewCellEditingStyle.Delete.rawValue|UITableViewCellEditingStyle.Insert.rawValue)!
    }
    
   

    
//    // MARK:- companyBtnClick
//    func companyBtnClick() {
//        self.navigationController?.pushViewController(CHSChCompanyHomeViewController(), animated: true)
//    }
    
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
