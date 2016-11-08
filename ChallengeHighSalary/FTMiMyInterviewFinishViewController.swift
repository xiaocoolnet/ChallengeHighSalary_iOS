//
//  FTMiMyInterviewFinishViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMiMyInterviewFinishViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-20-44-44), style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        
        // tableView
        rootTableView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-20-44-44)
        rootTableView.register(UINib.init(nibName: "FTMyInterviewInvitationTableViewCell", bundle: nil), forCellReuseIdentifier: "FTMyInterviewInvitationCell")
        rootTableView.separatorStyle = .none
        rootTableView.rowHeight = 130
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
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
