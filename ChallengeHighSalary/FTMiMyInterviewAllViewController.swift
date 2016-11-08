//
//  FTMiMyInterviewAllViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMiMyInterviewAllViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-20-44), style: .grouped)
    
    var typeDrop = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.title = "我的面试邀请"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.view.backgroundColor = UIColor.white
        
        // tableView
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-20-44)
        rootTableView.register(UINib.init(nibName: "FTMyInterviewInvitationTableViewCell", bundle: nil), forCellReuseIdentifier: "FTMyInterviewInvitationCell")
        rootTableView.separatorStyle = .none
        rootTableView.rowHeight = 130
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        setHeaderView()
    }
    
    // MARK:- 设置tableview 头视图
    func setHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        headerView.backgroundColor = UIColor.white
        
        let tipLab = UILabel(frame: CGRect(
            x: 8,
            y: 0,
            width: screenSize.width-8-8-100,
            height: 44))
        tipLab.textAlignment = .left
        tipLab.textColor = UIColor.black
        tipLab.font = UIFont.systemFont(ofSize: 14)
        tipLab.text = "你一共发出4个面试邀请"
        headerView.addSubview(tipLab)
        
        let typeBtn = UIButton(frame: CGRect(
            x: screenSize.width-100-8, y: 0, width: 100, height: 44))
        typeBtn.contentHorizontalAlignment = .right
        typeBtn.setTitleColor(baseColor, for: UIControlState())
        typeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        typeBtn.setTitle("全部", for: UIControlState())
        typeBtn.setImage(UIImage(named: "ic_下拉"), for: UIControlState())
        exchangeBtnImageAndTitle(typeBtn, margin: 5)
        typeBtn.addTarget(self, action: #selector(interviewTypeBtnClick), for: .touchUpInside)
        headerView.addSubview(typeBtn)
        
        // 面试邀请类型 下拉
        typeDrop.anchorView = typeBtn
        
        typeDrop.bottomOffset = CGPoint(x: 0, y: 38)
        typeDrop.width = screenSize.width
        typeDrop.direction = .bottom
        
        typeDrop.dataSource = ["不限","一年","2年","3年"]
        
        // 下拉列表选中后的回调方法
        typeDrop.selectionAction = { (index, item) in
            
            typeBtn.setTitle(item, for: UIControlState())
        }
        
        self.rootTableView.tableHeaderView = headerView
    }
    
    // 面试邀请类型 按钮 点击事件
    func interviewTypeBtnClick() {
        _ = typeDrop.show()
    }
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FTMyInterviewInvitationCell") as! FTMyInterviewInvitationTableViewCell
        cell.selectionStyle = .none
        
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
        //        self.navigationController?.pushViewController(CHSChPersonalInfoViewController(), animated: true)
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
