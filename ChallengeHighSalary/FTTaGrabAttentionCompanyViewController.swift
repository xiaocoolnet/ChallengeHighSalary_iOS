//
//  FTTaGrabAttentionCompanyViewController.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2017/1/18.
//  Copyright © 2017年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import MJRefresh

class FTTaGrabAttentionCompanyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var companyList = [Company_infoDataModel]()
 
    let findEmployerTableView = UITableView(frame: CGRect(x: screenSize.width, y: 0, width: screenSize.width, height: screenSize.height-20-44-49-37), style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        setNavigationBar()
        setSubviews()
        
    }
    
    var hud = MBProgressHUD()
    var hudShowFlag = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    // MARK: 加载数据 - 公司列表
    func loadCompanyListData() {
        
        CHSNetUtil().getCompanyList(pager: "1") { (success, response) in
            if success {
                self.companyList = (response as! [Company_infoDataModel]?)!
                self.findEmployerTableView.reloadData()
            }else{
                
            }
            
            if self.findEmployerTableView.mj_header.isRefreshing() {
                self.findEmployerTableView.mj_header.endRefreshing()
            }
        }
        
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.navigationItem.title = "在抢他的企业"
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }

    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        setSubviews_findEmployer()
    }
    
    // MARK: 设置子视图_找雇主
    func setSubviews_findEmployer() {
        
        // tableView
        findEmployerTableView.frame = CGRect(x: screenSize.width, y: 64, width: screenSize.width, height: screenSize.height-20-44-49-37)
        findEmployerTableView.backgroundColor = UIColor.lightGray
        findEmployerTableView.register(UINib.init(nibName: "ChChFindEmployerTableViewCell", bundle: nil), forCellReuseIdentifier: "ChChFindEmployerTableViewCell")
        findEmployerTableView.separatorStyle = .none
        findEmployerTableView.rowHeight = 250
        findEmployerTableView.tag = 102
        findEmployerTableView.dataSource = self
        findEmployerTableView.delegate = self
        self.view.addSubview(findEmployerTableView)
        
        findEmployerTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadCompanyListData))
        findEmployerTableView.mj_header.beginRefreshing()
    }
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.companyList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChChFindEmployerTableViewCell") as! ChChFindEmployerTableViewCell
        cell.selectionStyle = .none
        
        cell.companyInfo = self.companyList[(indexPath as NSIndexPath).row]
        cell.jobsCountBtn.tag = (indexPath as NSIndexPath).row
        cell.jobsCountBtn.addTarget(self, action: #selector(jobsCountBtnClick(_:)), for: .touchUpInside)
        return cell
        
    }
    
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let btn = UIButton()
        btn.tag = indexPath.row
        self.companyButtonClick(sender: btn)
    }
    
    // MARK:- jobsCountBtnClick
    func jobsCountBtnClick(_ jobsCountBtn:UIButton) {
        
        let companyPositionListVC = CHSChCompanyPositionListViewController()
        companyPositionListVC.company_infoJobs = self.companyList[jobsCountBtn.tag].jobs!
        self.navigationController?.pushViewController(companyPositionListVC, animated: true)
    }
    
    // MARk: companyButtonClick
    func companyButtonClick(sender:UIButton){
        
        let vc = CHSChCompanyHomeViewController()
        vc.jobInfoUserid = self.companyList[sender.tag].userid
        self.navigationController?.pushViewController(vc, animated: true)
        
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


