//
//  CHSReEduExperienceViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/25.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSReEduExperienceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView()
    
//    let nameArray = ["中英美术学院","鲁东大学"]
//    let detailArray = ["2013.6-2016.6","2013.6-2016.6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        self.rootTableView.reloadData()
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.title = "教育经历"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_提交"), style: .Done, target: self, action: #selector(clickSaveBtn))
        
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 60
        rootTableView.separatorStyle = .none
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
//    // MARK: 点击保存按钮
//    func clickSaveBtn() {
//        self.navigationController?.popViewControllerAnimated(true)
//    }
    
    // MARK:- tableView dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (CHSUserInfo.currentUserInfo.education!.count)+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as NSIndexPath).row == (CHSUserInfo.currentUserInfo.education!.count) {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "ChChSearchTableViewCell_clearHistory")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "ChChSearchTableViewCell_clearHistory")
                
                cell!.selectionStyle = .none
                
                let btn = UIButton(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 60))
                btn.setImage(UIImage(named: "ic_添加"), for: UIControlState())
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
                btn.setTitleColor(baseColor, for: UIControlState())
                btn.setTitle("添加教育经历", for: UIControlState())
                btn.isEnabled = false
                cell?.contentView.addSubview(btn)
            }
//            cell?.backgroundColor = UIColor.whiteColor()
//            cell?.textLabel?.textAlignment = .Center
//            cell?.textLabel?.textColor = baseColor
//            cell?.textLabel?.font = UIFont.systemFontOfSize(14)
//            cell?.textLabel?.text = "添加教育经历"
            
            
            return cell!
        }else {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "eduExperienceCell")
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: "eduExperienceCell")
            }
            
            cell?.selectionStyle = .none
            
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell?.textLabel?.textColor = UIColor.black
            cell?.textLabel?.textAlignment = .left
            cell?.textLabel?.text = CHSUserInfo.currentUserInfo.education![(indexPath as NSIndexPath).row].school
            

            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
            cell?.detailTextLabel?.textAlignment = .right
            cell?.detailTextLabel?.text = CHSUserInfo.currentUserInfo.education![(indexPath as NSIndexPath).row].time
                        
            if (indexPath as NSIndexPath).row < CHSUserInfo.currentUserInfo.education!.count {
                drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPoint(x: 8, y: 59), toPoint: CGPoint(x: screenSize.width-8, y: 59), lineWidth: 1/UIScreen.main.scale)
            }
            
            return cell!
        }
    }
    
    // MARK:- tableView delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath as NSIndexPath).row == (CHSUserInfo.currentUserInfo.education!.count) {
            
            self.navigationController?.pushViewController(CHSReEditEduExperienceViewController(), animated: true)
        }else {
            
            let editEduExperienceVC = CHSReEditEduExperienceViewController()
            editEduExperienceVC.selectedIndex = (indexPath as NSIndexPath).row
            self.navigationController?.pushViewController(editEduExperienceVC, animated: true)
        }
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
