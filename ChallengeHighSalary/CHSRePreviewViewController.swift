//
//  CHSRePreviewViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/25.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSRePreviewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    let resumeItemArray = [
//        [
//            ["name":"李玉洁","city":"烟台","exp":"1年","edu":"大专","jobType":"全职"],
//            ["jobIntension":"产品经理","salary":"￥3k-5k"],
//            ["industry":"互联网"],
//            ["jobStatus":"离职-可立即上岗"]
//        ],
//        [
//            ["school":"中英美术学院","eduTime":"2013.6-2016.6"],
//            ["major":"产品设计","edu":"大专"]
//        ],
//        [
//            ["company":"校酷 | IT软件","jobTime":"2013.6-2016.6"],
//            ["position":"UI设计"],
//            ["skill":["原型设计","交互设计","UI设计"]]
//        ],
//        [
//            [
//                ["exp":"APP软件开发"],
//                ["describe":"如果你无法简洁的表达你的想法，那只说明你还不够了解它。如果你无法简洁的表达你的想法，那只说明你还不够了解它。"]
//            ],
//            [
//                ["exp":"APP软件开发2"],
//                ["describe":"如果你无法简洁的表达你的想法，那只说明你还不够了解它。如果你无法简洁的表达你的想法，那只说明你还不够了解它。"]
//            ]
//        ]
//    ]
    
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
        self.view.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        
        self.title = "简历"
        
        // TableView
        let myTableView = UITableView(frame: CGRectMake(0, 64, screenSize.width, screenSize.height-64))
        myTableView.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        myTableView.rowHeight = 50
        myTableView.dataSource = self
        myTableView.delegate = self
        
        self.view.addSubview(myTableView)
        // 用于去掉多余Cell的分割线
        let removeRedundantCellSepLine = UIView(frame: CGRectZero)
        myTableView.tableFooterView = removeRedundantCellSepLine
        
    }
    
    // MARK:- tableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("resumeCell")
        if (cell == nil) {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "resumeCell")
        }
        cell?.selectionStyle = .None
        cell?.accessoryType = .DisclosureIndicator
        cell?.textLabel?.font = UIFont.boldSystemFontOfSize(16)
        cell?.textLabel?.textColor = UIColor.blackColor()
        cell?.textLabel?.textAlignment = .Left
//        cell?.textLabel?.text = resumeItemArray[indexPath.row]
        
//        cell?.detailTextLabel?.font = UIFont.systemFontOfSize(14)
//        cell?.detailTextLabel?.textColor = resumeItemStatusArray[indexPath.row]=="待完善" ? baseColor:UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
//        cell?.detailTextLabel?.textAlignment = .Right
//        cell?.detailTextLabel?.text = resumeItemStatusArray[indexPath.row]
        
        return cell!
    }
    
    // MARK:- tableView DataSource
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(CHSReJobIntensionViewController(), animated: true)
        }else if indexPath.row == 2 {
            self.navigationController?.pushViewController(CHSReJobExperienceViewController(), animated: true)
        }else if indexPath.row == 3 {
            self.navigationController?.pushViewController(CHSReProjectExperienceViewController(), animated: true)
        }else if indexPath.row == 4 {
            self.navigationController?.pushViewController(CHSReMyAdvantagesViewController(), animated: true)
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
