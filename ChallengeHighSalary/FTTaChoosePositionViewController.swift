//
//  FTTaChoosePositionViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaChoosePositionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var positionTypeID = "" {
        didSet {
            self.loadData()
        }
    }
    
    var firstPositionTypeArray = [DicDataModel]()
    var secondPositionTypeArray = [DicDataModel]()
    
    let firstTableView = UITableView() // 左 tableview tag = 101
    let secondTableView = UITableView() // 右 tableview tag = 102
    
    var firstCurrentSelectedRow = 0
    var secondCurrentSelectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - 获取数据
    func loadData() {
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud?.removeFromSuperViewOnHide = true
        hud?.margin = 10
        hud?.labelText = "正在获取职位类型"
        
        PublicNetUtil().getDictionaryList(parentid: positionTypeID) { (success, response) in
            if success {
                hud?.hide(true)
                self.firstPositionTypeArray = response as! [DicDataModel]
                
                self.loadData_2(parentid: (self.firstPositionTypeArray.first?.term_id ?? "")!)
                self.firstTableView.reloadData()
            }else{
                hud?.mode = .text
                hud?.labelText = "职位类型获取失败"
                hud?.hide(true, afterDelay: 1)
                
                let time: TimeInterval = 1.0
                let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    
                    _ = self.navigationController?.popViewController(animated: true)
                    
                }
            }
        }
        
    }
    
    func loadData_2(parentid: String) {
        
        if parentid == "" {
            return
        }
        
        PublicNetUtil().getDictionaryList(parentid: parentid) { (success, response) in
            if success {

                self.secondPositionTypeArray = response as! [DicDataModel]
                self.secondTableView.reloadData()
            }else{
                self.secondPositionTypeArray = [DicDataModel]()
                self.secondTableView.reloadData()
            }
        }
        
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        self.view.backgroundColor = UIColor.white
        
        self.title = "选择职位"
        
        // tableView
        firstTableView.frame = CGRect(x: 0, y: 64, width: kWidthScale*160, height: screenSize.height-20-44)
        firstTableView.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        firstTableView.rowHeight = 40
        firstTableView.tag = 101
        firstTableView.dataSource = self
        firstTableView.delegate = self
        self.view.addSubview(firstTableView)
        
        secondTableView.frame = CGRect(x: kWidthScale*160, y: 64, width: kWidthScale*215, height: screenSize.height-20-44)
        secondTableView.backgroundColor = UIColor.white
        secondTableView.rowHeight = 40
        secondTableView.tag = 102
        secondTableView.dataSource = self
        secondTableView.delegate = self
        self.view.addSubview(secondTableView)
        
    }
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 101 {
            return firstPositionTypeArray.count
        }else{
            return secondPositionTypeArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CHSMiSettingCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CHSMiSettingCell")
        }
        cell!.selectionStyle = .none
        
        cell!.accessoryType = .none
        
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell?.textLabel?.textAlignment = .left
        
        cell?.backgroundColor = UIColor.clear
        
        if tableView.tag == 101 {
            
            if firstCurrentSelectedRow == (indexPath as NSIndexPath).row {
                cell?.textLabel?.textColor = baseColor
            }else{
                
                cell?.textLabel?.textColor = UIColor.black
            }
            
            cell?.textLabel!.text = firstPositionTypeArray[indexPath.row].name

        }else{
            
            if secondCurrentSelectedRow == (indexPath as NSIndexPath).row {
                cell?.textLabel?.textColor = baseColor
            }else{
                
                cell?.textLabel?.textColor = UIColor.black
            }
            
            cell?.textLabel!.text = secondPositionTypeArray[indexPath.row].name

        }
        
        return cell!
    }
    
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 101 {
            
            firstCurrentSelectedRow = (indexPath as NSIndexPath).row
            
            loadData_2(parentid: (firstPositionTypeArray[firstCurrentSelectedRow].term_id ?? "")!)

        }else{
            
            secondCurrentSelectedRow = (indexPath as NSIndexPath).row
            
            var FTPublishJobSelectedNameArray = UserDefaults.standard.array(forKey: FTPublishJobSelectedNameArray_key) as! [Array<String>]
            FTPublishJobSelectedNameArray[1][0] = (secondPositionTypeArray[indexPath.row].name ?? "")!
            UserDefaults.standard.setValue(FTPublishJobSelectedNameArray, forKey: FTPublishJobSelectedNameArray_key)
            
            _ = self.navigationController?.popToViewController((self.navigationController?.viewControllers[(self.navigationController?.viewControllers.endIndex)!-3])!, animated: true)
        }
        secondTableView.reloadData()
        firstTableView.reloadData()
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
