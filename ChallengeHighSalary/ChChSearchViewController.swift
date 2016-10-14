//
//  ChChSearchViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/7.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChChSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var searhHistoryArray = Array<String>()
    let myTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNavigationBar()
        loadData()
        setSubViews()
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        let cityBtn = UIButton(frame: CGRectMake(0, 0, 65, 44))
        cityBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10)
        cityBtn.contentHorizontalAlignment = .Center
        cityBtn.titleLabel?.font = UIFont.systemFontOfSize(17)
        cityBtn.setTitle("烟台", forState: .Normal)
        cityBtn.titleLabel!.lineBreakMode =  .ByTruncatingTail
        cityBtn.addTarget(self, action: #selector(cityBtnClick), forControlEvents: .TouchUpInside)
        cityBtn.setImage(UIImage(named: "城市下拉箭头"), forState: .Normal)
        exchangeBtnImageAndTitle(cityBtn, margin: 5)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cityBtn)
        
        //        let seg = UISegmentedControl(frame: CGRectMake(0, 0, 160, 44))
        let searchBar = UISearchBar(frame: CGRectMake(0, 0, screenSize.width*2/3.0, 24))
        searchBar.placeholder = "职位/公司/技能/姓名"
        searchBar.returnKeyType = .Search
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        let cancelBtn = UIButton(frame: CGRectMake(0, 0, 40, 44))
        cancelBtn.setTitle("取消", forState: .Normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelBtn)
    }
    
    // MARK: 城市按钮点击事件
    func cityBtnClick() {
        self.navigationController?.pushViewController(ChChCityViewController(), animated: true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        if (searchBar.text != nil) {
            searhHistoryArray.append(searchBar.text!)
            NSUserDefaults.standardUserDefaults().setValue(searhHistoryArray, forKey: "searhHistory")
            self.myTableView.reloadData()
        }
        
    }
    
    // MARK: 取消按钮点击事件
    func cancelBtnClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func loadData() {
        if (NSUserDefaults.standardUserDefaults().arrayForKey("searhHistory") != nil) {
            searhHistoryArray = NSUserDefaults.standardUserDefaults().arrayForKey("searhHistory") as! Array<String>
            myTableView.reloadData()
        }
    }
    
    func setSubViews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        myTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-64-49)
        myTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        myTableView.rowHeight = 55
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.registerClass(ChChSearchTableViewCell.self, forCellReuseIdentifier: "ChChSearchTableViewCell")
        self.view.addSubview(myTableView)
        // 用于去掉多余Cell的分割线
        let removeRedundantCellSepLine = UIView(frame: CGRectZero)
        myTableView.tableFooterView = removeRedundantCellSepLine
    }
    
    // MARK:- TableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searhHistoryArray.count == 0 {
            return 0
        }else{
            return searhHistoryArray.count+1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == searhHistoryArray.count {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("ChChSearchTableViewCell_clearHistory")
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: "ChChSearchTableViewCell_clearHistory")
            }
            cell!.selectionStyle = .None
            cell?.textLabel?.textAlignment = .Center
            cell?.textLabel?.textColor = UIColor.grayColor()
            cell?.textLabel?.font = UIFont.systemFontOfSize(14)
            cell?.textLabel?.text = "清空搜索记录"
            return cell!
        }else{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("ChChSearchTableViewCell") as! ChChSearchTableViewCell
            cell.selectionStyle = .None
            cell.accessoryType = .DisclosureIndicator
            
            cell.titImage.setImage(nil, forState: .Normal)
            cell.titLab.text = searhHistoryArray[indexPath.row]
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == searhHistoryArray.count {
            NSUserDefaults.standardUserDefaults().removeObjectForKey("searhHistory")
            self.searhHistoryArray.removeAll()
            self.myTableView.reloadData()
            
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
