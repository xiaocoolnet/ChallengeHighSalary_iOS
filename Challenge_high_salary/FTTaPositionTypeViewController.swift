//
//  FTTaPositionTypeViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/9/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaPositionTypeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView()
    
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
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "职位类型"
        
        // tableView
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-20-44)
        rootTableView.rowHeight = 70
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
    }
    
    // MARK: UITableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CHSMiSettingCell")
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "CHSMiSettingCell")
        }
        cell!.selectionStyle = .None
        
        cell!.accessoryType = .DisclosureIndicator
        
        cell?.textLabel?.font = UIFont.systemFontOfSize(15)
        cell?.textLabel?.textAlignment = .Left
        cell?.textLabel?.textColor = UIColor.blackColor()
        
        cell?.textLabel!.text = "网络|通信|电子"
        
        cell?.detailTextLabel?.font = UIFont.systemFontOfSize(13)
        cell?.detailTextLabel?.textAlignment = .Left
        cell?.detailTextLabel?.textColor = UIColor.lightGrayColor()
        
        cell?.detailTextLabel?.text = "计算机/互联网/通信 | 电子/电气 | 机械/仪器仪表"
        
        cell?.backgroundColor = UIColor.whiteColor()
        
        return cell!
    }
    
    // MARK: UITableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.pushViewController(FTTaChoosePositionViewController(), animated: true)
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
