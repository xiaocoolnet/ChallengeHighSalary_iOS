//
//  CHSChCompanyPositionListViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/19.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSChCompanyPositionListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView()
    
    var company_infoJobs = [JobInfoDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        self.view.backgroundColor = UIColor.white
        
        self.title = "热招职位"
        
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.separatorStyle = .none
        rootTableView.register(UINib(nibName: "CHSChCompanyPositionTableViewCell", bundle: nil), forCellReuseIdentifier: "CHSChCompanyPositionCell")
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 16))
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.view.addSubview(rootTableView)
    }
    
    // MARK:- tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return company_infoJobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CHSChCompanyPositionCell") as! CHSChCompanyPositionTableViewCell
        cell.selectionStyle = .none
        
        cell.company_infoJob = company_infoJobs[(indexPath as NSIndexPath).row]
        return cell
    }
    
    // MARK:- tableview delegate
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let personalInfoVC = CHSChPersonalInfoViewController()
        personalInfoVC.jobInfo = self.company_infoJobs[(indexPath as NSIndexPath).row] 
        
        self.navigationController?.pushViewController(personalInfoVC, animated: true)
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
