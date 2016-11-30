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
    
    let searchBar = UISearchBar()
    let cityBtn = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cityBtn.setTitle(myCity, for: UIControlState())

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNavigationBar()
        loadData()
        setSubViews()
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        cityBtn.frame = CGRect(x: 0, y: 0, width: 65, height: 44)
        cityBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10)
        cityBtn.contentHorizontalAlignment = .center
        cityBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        cityBtn.setTitle(myCity, for: UIControlState())
        cityBtn.titleLabel!.lineBreakMode =  .byTruncatingTail
        cityBtn.addTarget(self, action: #selector(cityBtnClick), for: .touchUpInside)
        cityBtn.setImage(UIImage(named: "城市下拉箭头"), for: UIControlState())
        exchangeBtnImageAndTitle(cityBtn, margin: 5)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cityBtn)
        
        //        let seg = UISegmentedControl(frame: CGRectMake(0, 0, 160, 44))
        searchBar.frame = CGRect(x: 0, y: 0, width: screenSize.width*2/3.0, height: 24)
        searchBar.placeholder = "职位/公司/技能/姓名"
        searchBar.returnKeyType = .search
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        let cancelBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 44))
        cancelBtn.setTitle("取消", for: UIControlState())
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelBtn)
    }
    
    // MARK: 城市按钮点击事件
    func cityBtnClick() {
        self.navigationController?.pushViewController(ChChCityViewController(), animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        if (searchBar.text != nil) {
            
            var hasText = false
            for text in searhHistoryArray.enumerated() {
                if text.element == searchBar.text {
                    
                    searhHistoryArray.remove(at: text.offset)
                    searhHistoryArray.insert(text.element, at: 0)
                    
                    hasText = true
                }
            }
            
            if !hasText {
                
                searhHistoryArray.append(searchBar.text!)
            }
            
            UserDefaults.standard.setValue(searhHistoryArray, forKey: "searhHistory")
            self.myTableView.reloadData()
        }
        
    }
    
    // MARK: 取消按钮点击事件
    func cancelBtnClick() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func loadData() {
        if (UserDefaults.standard.array(forKey: "searhHistory") != nil) {
            searhHistoryArray = UserDefaults.standard.array(forKey: "searhHistory") as! Array<String>
            myTableView.reloadData()
        }
    }
    
    func setSubViews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        myTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64-49)
        myTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        myTableView.rowHeight = 55
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(ChChSearchTableViewCell.self, forCellReuseIdentifier: "ChChSearchTableViewCell")
        self.view.addSubview(myTableView)
        // 用于去掉多余Cell的分割线
        let removeRedundantCellSepLine = UIView(frame: CGRect.zero)
        myTableView.tableFooterView = removeRedundantCellSepLine
    }
    
    // MARK:- TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searhHistoryArray.count == 0 {
            return 0
        }else{
            return searhHistoryArray.count+1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as NSIndexPath).row == searhHistoryArray.count {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "ChChSearchTableViewCell_clearHistory")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "ChChSearchTableViewCell_clearHistory")
            }
            cell!.selectionStyle = .none
            cell?.textLabel?.textAlignment = .center
            cell?.textLabel?.textColor = UIColor.gray
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell?.textLabel?.text = "清空搜索记录"
            return cell!
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChChSearchTableViewCell") as! ChChSearchTableViewCell
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            
            cell.titImage.setImage(nil, for: UIControlState())
            cell.titLab.text = searhHistoryArray[(indexPath as NSIndexPath).row]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).row == searhHistoryArray.count {
            UserDefaults.standard.removeObject(forKey: "searhHistory")
            self.searhHistoryArray.removeAll()
            self.myTableView.reloadData()
            
        }else{
            self.searchBar.text = self.searhHistoryArray[indexPath.row]
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
