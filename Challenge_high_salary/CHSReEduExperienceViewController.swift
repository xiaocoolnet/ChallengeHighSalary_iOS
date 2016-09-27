//
//  CHSReEduExperienceViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/9/25.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSReEduExperienceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView()
    
    let nameArray = ["中英美术学院","鲁东大学"]
    let detailArray = ["2013.6-2016.6","2013.6-2016.6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = true
        
    }
    
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.title = "教育经历"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Done, target: self, action: #selector(clickSaveBtn))
        
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 50
        rootTableView.separatorStyle = .None
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK:- tableView dataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count+1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == nameArray.count {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("ChChSearchTableViewCell_clearHistory")
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: "ChChSearchTableViewCell_clearHistory")
            }
            cell!.selectionStyle = .None
            cell?.backgroundColor = UIColor.whiteColor()
            cell?.textLabel?.textAlignment = .Center
            cell?.textLabel?.textColor = baseColor
            cell?.textLabel?.font = UIFont.systemFontOfSize(14)
            cell?.textLabel?.text = "添加教育经历"
            return cell!
        }else {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("eduExperienceCell")
            if cell == nil {
                cell = UITableViewCell(style: .Value1, reuseIdentifier: "eduExperienceCell")
            }
            
            cell?.selectionStyle = .None
            
            cell?.accessoryType = .DisclosureIndicator
            cell?.textLabel?.font = UIFont.systemFontOfSize(16)
            cell?.textLabel?.textColor = UIColor.blackColor()
            cell?.textLabel?.textAlignment = .Left
            cell?.textLabel?.text = nameArray[indexPath.row]
            
            if indexPath.row == 0 {
                
                let companyNameTf = UITextField(frame: CGRectMake(0, 0, 150, 50))
                companyNameTf.font = UIFont.systemFontOfSize(14)
                companyNameTf.placeholder = detailArray[indexPath.row]
                companyNameTf.textAlignment = .Right
                cell?.accessoryView = companyNameTf
            }else{
                
                cell?.detailTextLabel?.font = UIFont.systemFontOfSize(14)
                cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
                cell?.detailTextLabel?.textAlignment = .Right
                cell?.detailTextLabel?.text = detailArray[indexPath.row]
            }
            
            if indexPath.row < nameArray.count-1 {
                drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, 59), toPoint: CGPointMake(screenSize.width-8, 59), lineWidth: 1/UIScreen.mainScreen().scale)
            }
            
            return cell!
        }
    }
    
    // MARK:- tableView delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.pushViewController(CHSReEditEduExperienceViewController(), animated: true)
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
