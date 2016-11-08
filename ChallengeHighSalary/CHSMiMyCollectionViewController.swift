//
//  CHSMiMyCollectionViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/21.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiMyCollectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-20-44-49-37), style: .grouped)
    let sureDeleteBtn = UIButton()
    
    var jobInfoData: [JobInfoDataModel]?
    var deleteJobInfoData = [JobInfoDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setNavigationBar()
        setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        // rightBarButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_删除"), style: .done, target: self, action: #selector(deleteBtnClick))
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 删除按钮点击事件
    func deleteBtnClick() {
        print("CHSMiMyCollectionViewController deleteBtnClick")
        
        if self.sureDeleteBtn.isHidden {
            
            self.rootTableView.frame.size.height = screenSize.height-20-44-sureDeleteBtn.frame.size.height
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(deleteBtnClick))

        }else{
            self.rootTableView.frame.size.height = screenSize.height-20-44
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_删除"), style: .done, target: self, action: #selector(deleteBtnClick))

        }
        self.sureDeleteBtn.isHidden = !self.sureDeleteBtn.isHidden
        self.rootTableView.isEditing = !self.rootTableView.isEditing;

//        self.rootTableView.editing = true
//        self.navigationController?.pushViewController(ChChSearchViewController(), animated: true)
    }
    
    // MARK: 下方确认删除按钮 点击事件
    func sureDeleteBtnClick() {
        let alert = UIAlertController(title: "", message: "确定要删除所选的 \(self.deleteJobInfoData.count) 个收藏吗？", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let sureAction = UIAlertAction(title: "确定", style: .default, handler: { (sureAction) in
            
            var jobidStr = ""
            for (i,jobInfo) in self.deleteJobInfoData.enumerated() {
                if i == self.deleteJobInfoData.count-1 {
                    jobidStr += "\((jobInfo.jobid)!)"
                }else{
                    jobidStr += "\((jobInfo.jobid)!),"
                }
            }
//            PublicNetUtil().cancelfavorite(CHSUserInfo.currentUserInfo.userid, object_id: jobidStr, type: "1", handle: { (success, response) in
//                if success {
//                    for jobInfo in self.deleteJobInfoData {
//                        self.jobInfoData?.remove(at: (self.jobInfoData?.index(where: { (jobInfo) -> Bool in
//                            
//                        }))!)
////                        self.jobInfoData?.remove(at: (self.jobInfoData?.index(of: jobInfo))!)
//                    }
//                    self.rootTableView.reloadData()
//                    self.deleteBtnClick()
//                }
//            })
            
        })
        alert.addAction(sureAction)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white

        // tableView
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-20-44)
        rootTableView.register(UINib.init(nibName: "ChChFindJobTableViewCell", bundle: nil), forCellReuseIdentifier: "ChChFindJobTableViewCell")
        rootTableView.separatorStyle = .none
        rootTableView.rowHeight = 140
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        self.rootTableView.isEditing = false
        self.rootTableView.allowsMultipleSelectionDuringEditing = true
        
        sureDeleteBtn.frame = CGRect(
            x: 0,
            y: screenSize.height-kHeightScale*44,
            width: screenSize.width,
            height: kHeightScale*44)
        sureDeleteBtn.backgroundColor = baseColor
        //        chatBtn_2.layer.cornerRadius = chatBtn.frame.size.height/2.0
        sureDeleteBtn.setTitleColor(UIColor.white, for: UIControlState())
        sureDeleteBtn.setTitle("删除", for: UIControlState())
        sureDeleteBtn.addTarget(self, action: #selector(sureDeleteBtnClick), for: .touchUpInside)
        self.view.addSubview(sureDeleteBtn)
        sureDeleteBtn.isHidden = true

    }
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.jobInfoData?.count ?? 0)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChChFindJobTableViewCell") as! ChChFindJobTableViewCell
//        cell.selectionStyle = .None
        
        cell.jobInfo = self.jobInfoData![(indexPath as NSIndexPath).section]
//        cell.companyBtn.addTarget(self, action: #selector(companyBtnClick), forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    //是否可以编辑  默认的时YES
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //选择编辑的方式,按照选择的方式对表进行处理
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
    
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.isEditing {
            self.deleteJobInfoData.append(self.jobInfoData![(indexPath as NSIndexPath).section])
        }else{
            
            let personalInfoVC = CHSChPersonalInfoViewController()
            personalInfoVC.jobInfo = self.jobInfoData![(indexPath as NSIndexPath).section]
            
            self.navigationController?.pushViewController(personalInfoVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            
//            self.deleteJobInfoData.index(where: { (jobInfo) -> Bool in
//                
//                self.deleteJobInfoData.remove(at: <#T##Int#>)
//                
//            })
//            self.deleteJobInfoData.remove(at: self.deleteJobInfoData.index(where: { (jobInfo) -> Bool in
//                
//            })!)
            
//            let jobInfo = self.jobInfoData?[indexPath.section]
//            let index = self.deleteJobInfoData.index(where: { (jobInfo) -> Bool in
//                
//                self.deleteJobInfoData.remove(at: <#T##Int#>)
//                self.deleteJobInfoData.remove(at: index!)
//
//            })
//            self.deleteJobInfoData?.remove(at: (self.jobInfoData?.index(where: { (jobInfo) -> Bool in
//                
//            }))!)
//            let index = self.deleteJobInfoData.index(of: self.jobInfoData![(indexPath as NSIndexPath).section])
//            
//            if (index != nil) {
//                self.deleteJobInfoData.remove(at: index!)
//            }
            
//            for (i,jobInfo) in self.deleteJobInfoData!.enumerate() {
//                if jobInfo == self.jobInfoData![indexPath.row] {
//                    self.deleteJobInfoData?.removeAtIndex(i)
//                }
//            }
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle(rawValue: UITableViewCellEditingStyle.delete.rawValue|UITableViewCellEditingStyle.insert.rawValue)!
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
