//
//  ChChResultViewController.swift
//  ChallengeHighSalary
//
//  Created by 沈晓龙 on 2017/1/9.
//  Copyright © 2017年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChChResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let findJobTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height), style: .grouped)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        addsubViews()
        
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }

    
    // MARK: 加载子视图
    func addsubViews(){
        // tableView
        findJobTableView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        findJobTableView.register(UINib.init(nibName: "ChChFindJobTableViewCell", bundle: nil), forCellReuseIdentifier: "ChChFindJobTableViewCell")
        findJobTableView.separatorStyle = .none
        findJobTableView.rowHeight = 140
        findJobTableView.dataSource = self
        findJobTableView.delegate = self
        self.view.addSubview(findJobTableView)
        
        let titleLab = UILabel.init(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 40))
        titleLab.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        titleLab.text = "以下是“设计师”的相关职位"
        titleLab.font = UIFont.systemFont(ofSize: 15)
        titleLab.textColor = UIColor.lightGray
        titleLab.textAlignment = .center
        self.findJobTableView.tableHeaderView = titleLab
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChChFindJobTableViewCell") as! ChChFindJobTableViewCell
        cell.selectionStyle = .none
        
        //            cell.jobInfo = self.jobList[(indexPath as NSIndexPath).section]
        //            cell.companyBtn.tag = (indexPath as NSIndexPath).section
        cell.companyBtn.addTarget(self, action: #selector(companyBtnClick(_:)), for: .touchUpInside)
        
        return cell
        
    }
    
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let personalInfoVC = CHSChPersonalInfoViewController()
//        personalInfoVC.jobInfo = self.jobList[(indexPath as NSIndexPath).section]
        
        self.navigationController?.pushViewController(personalInfoVC, animated: true)
        
    }
    
    // MARK:- companyBtnClick
    func companyBtnClick(_ companyBtn:UIButton) {
        
        let companyHomeVC = CHSChCompanyHomeViewController()
//        companyHomeVC.jobInfoUserid = self.jobList[companyBtn.tag].userid ?? ""
        self.navigationController?.pushViewController(companyHomeVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
