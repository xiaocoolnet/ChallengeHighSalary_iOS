//
//  FTMiMyCollectionViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/24.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import MJRefresh

class FTMiMyCollectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-20-44-49-37), style: .grouped)
    let sureDeleteBtn = UIButton()
    
    var ResumeDataArray: [MyResumeData]?
    var deleteResumeData = [MyResumeData]()
    
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
        
        PublicNetUtil().getfavoritelist(CHSUserInfo.currentUserInfo.userid, type: "2") { (success, response) in
            if success {
                self.ResumeDataArray = response as? [MyResumeData]
                self.rootTableView.reloadData()
            }
            self.rootTableView.mj_header.endRefreshing()
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
        let alert = UIAlertController(title: "", message: "确定要删除所选的 \(self.deleteResumeData.count) 个收藏吗？", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let sureAction = UIAlertAction(title: "确定", style: .default, handler: { (sureAction) in
            
            var resumeidStr = ""
            for (i,resume) in self.deleteResumeData.enumerated() {
                if i == self.deleteResumeData.count-1 {
                    resumeidStr += "\(resume.resumes_id)"
                }else{
                    resumeidStr += "\(resume.resumes_id),"
                }
            }
            
            PublicNetUtil().cancelfavorite(CHSUserInfo.currentUserInfo.userid, object_id: resumeidStr, type: "2", handle: { (success, response) in
                
                if success {
                    
                    for deleResume in self.deleteResumeData.enumerated() {
                        
                        for resume in (self.ResumeDataArray?.enumerated())! {
                            if deleResume.element.resumes_id == resume.element.resumes_id {
                                
                                let index = self.deleteResumeData.index(where: { (resumeData) -> Bool in
                                    return resumeData.resumes_id == deleResume.element.resumes_id
                                })
                                
                                if (index != nil) {
                                    
                                    self.deleteResumeData.remove(at: index!)
                                }
                                
                                
                                self.ResumeDataArray?.remove(at: resume.offset)
                                break
                            }
                        }
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
        self.view.backgroundColor = UIColor.white
        
        // tableView
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-20-44)
        rootTableView.register(UINib.init(nibName: "FTTalentTableViewCell", bundle: nil), forCellReuseIdentifier: "FTTalentCell")
        rootTableView.separatorStyle = .none
        rootTableView.rowHeight = 140
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        self.rootTableView.isEditing = false
        self.rootTableView.allowsMultipleSelectionDuringEditing = true
        
        self.rootTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadData))
        
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
        return (self.ResumeDataArray?.count ?? 0)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FTTalentCell") as! FTTalentTableViewCell
        
        cell.resumeData = self.ResumeDataArray![indexPath.section]
        
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
            self.deleteResumeData.append(self.ResumeDataArray![(indexPath as NSIndexPath).section])
        }else{
            
            let personalInfoVC = FTPersonalViewController()
            personalInfoVC.resumeData = self.ResumeDataArray![indexPath.section]
            
            self.navigationController?.pushViewController(personalInfoVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            
            for (i,resume) in self.deleteResumeData.enumerated() {
                if resume.resumes_id == self.ResumeDataArray![indexPath.section].resumes_id {
                    self.deleteResumeData.remove(at: i)
                }
            }
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
