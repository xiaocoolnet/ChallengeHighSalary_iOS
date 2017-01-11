//
//  CHSChCompanyInterviewEvaluationViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/21.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSChCompanyInterviewEvaluationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-20-44-49-37), style: .grouped)
    
    var dataArray = EvaluateStartData()
    var dataSource = [getEvaluateListData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        loadData()
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
    
    // MARK: 加载数据
    func loadData(){
        // 获取公司综合评分
        CHSNetUtil().getCompanyEvaluateStart(companyid: "1") { (success, response) in
            if success {
                self.dataArray = response as! EvaluateStartData
                self.rootTableView.reloadData()
            }else{
                
            }
        }
        
        // 获取面试评价列表
        CHSNetUtil().getEvaluateList(companyid: "1", pager: "1") { (success, response) in
            if success {
                
                self.dataSource = response as! [getEvaluateListData]
                self.rootTableView.reloadData()
                self.title = "面试评价(\(self.dataSource.count))"
            }else{
                
            }
        }
    }
    
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        
        self.title = "面试评价(2)"
        
        // tableView
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-20-44)
        rootTableView.register(UINib.init(nibName: "CHSChInterviewEvaHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "CHSChInterviewHeaderCell")
        rootTableView.register(UINib.init(nibName: "CHSChInterviewEvaTableViewCell", bundle: nil), forCellReuseIdentifier: "CHSChInterviewCell")
        rootTableView.rowHeight = 140
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
    }
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return self.dataSource.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as NSIndexPath).section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CHSChInterviewHeaderCell") as! CHSChInterviewEvaHeaderTableViewCell
            cell.selectionStyle = .none
            rootTableView.rowHeight = 61
            
            cell.evaluateStartInfo = self.dataArray
            
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CHSChInterviewCell") as! CHSChInterviewEvaTableViewCell
            cell.selectionStyle = .none
            
            cell.evaluateList = self.dataSource[indexPath.row]
            
            rootTableView.rowHeight = cell.usefulBtn.frame.maxY + 20
            
            return cell
        }
    }
    
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.navigationController?.pushViewController(CHSChPersonalInfoViewController(), animated: true)
    }
    
    // MARK:- companyBtnClick
    func companyBtnClick() {
        self.navigationController?.pushViewController(CHSChCompanyHomeViewController(), animated: true)
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
