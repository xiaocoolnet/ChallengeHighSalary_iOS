//
//  CHSMePositionViewController.swift
//  ChallengeHighSalary
//
//  Created by 沈晓龙 on 2016/12/30.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMePositionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let rootTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-20-44), style: .grouped)
    
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
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        self.title = "面试详情"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }

    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        // tableView
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-20-44)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.register(CHSMePositionTableViewCell.self, forCellReuseIdentifier: "cell")
        rootTableView.register(UINib.init(nibName: "CHSChCompanyPositionTableViewCell", bundle: nil), forCellReuseIdentifier: "CHSChCompanyPositionTableViewCell")
        rootTableView.separatorStyle = .none
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        addTableFooterView()
    }
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            
            return 2
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CHSChCompanyPositionTableViewCell") as! CHSChCompanyPositionTableViewCell
            cell.selectionStyle = .none
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CHSMePositionTableViewCell
            cell.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
            cell.selectionStyle = .none
            let titArr = ["面试时间","联系方式"]
            let conArr = ["2017.2.24","16262828662"]
            cell.conLab.text = conArr[indexPath.row]
            cell.titLab.text = titArr[indexPath.row]
            return cell
        }
    }
    
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 146
        }else{
            
            return 50
        }
    }
    
    
    
    func addTableFooterView(){
        
        let bigView = UIView.init(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 190))
        rootTableView.tableFooterView = bigView
        
        let backView = UIView.init(frame: CGRect(x: 13, y: 0, width: screenSize.width - 26, height: 190))
        backView.backgroundColor = UIColor.white
        bigView.addSubview(backView)
        
        let addArray = ["面试地点","其他说明"]
        let detArray = ["山东省烟台市芝罘区祥尧街96-2沁园春","请您带上您的简历及项目经历3"]
        
        for i in 0...1 {
            let height:CGFloat = CGFloat(80*i)
            let addressLab = UILabel.init(frame: CGRect(x: 10, y: 0 + height, width: screenSize.width - 40, height: 30))
            addressLab.text = addArray[i]
            addressLab.font = UIFont.systemFont(ofSize: 16)
            backView.addSubview(addressLab)
            
            let address = UILabel.init(frame: CGRect(x: 10, y: 30 + height, width: screenSize.width - 40, height: 49))
            address.text = detArray[i]
            address.font = UIFont.systemFont(ofSize: 15)
            address.textColor = UIColor.lightGray
            address.numberOfLines = 0
//            address.sizeToFit()
            backView.addSubview(address)
            
            let line = UILabel.init(frame: CGRect(x: 0, y: 79 + height, width: screenSize.width - 26, height: 1))
            line.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
            backView.addSubview(line)
        }
        
        
        
    }
    

}
