//
//  CHSReJobIntensionViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/13.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSReJobIntensionViewController: UIViewController, UITableViewDataSource {

    let rootTableView = UITableView()
    
    let nameArray = ["工作性质","工作地点","职位类型","行业类别","期望薪资","工作状态"]
    let detailArray = ["全职","北京","产品经理","互联网","4k-6k/月","离职，可立即上岗"]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
    }
    
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        self.title = "求职意向"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Done, target: self, action: #selector(clickSaveBtn))
        
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 60
        rootTableView.dataSource = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK:- tableView dataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("myInfoCell")
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "myInfoCell")
        }
        
        cell?.selectionStyle = .None
        cell?.accessoryType = .DisclosureIndicator
        cell?.textLabel?.font = UIFont.systemFontOfSize(16)
        cell?.textLabel?.textColor = UIColor.blackColor()
        cell?.textLabel?.textAlignment = .Left
        cell?.textLabel?.text = nameArray[indexPath.row]
        
        cell?.detailTextLabel?.font = UIFont.systemFontOfSize(14)
        cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
        cell?.detailTextLabel?.textAlignment = .Right
        cell?.detailTextLabel?.text = detailArray[indexPath.row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "账号关联"
        }else{
            return nil
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
