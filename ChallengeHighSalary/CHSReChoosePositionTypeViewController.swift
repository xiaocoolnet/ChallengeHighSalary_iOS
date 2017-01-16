//
//  CHSReChoosePositionTypeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/12.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSReChoosePositionTypeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var vcType:FromVCType = .default

    let rootTableView = UITableView()
    
    var positionTypeArray = [DicDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        if positionTypeArray.count <= 0 {
            loadData()
        }
    }
    
    // MARK: - 获取数据
    func loadData() {
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.removeFromSuperViewOnHide = true
        hud.margin = 10
        hud.label.text = "正在获取职位类型"
        
        PublicNetUtil.getDictionaryList(parentid: "1") { (success, response) in
            if success {
                hud.hide(animated: true)
                self.positionTypeArray = response as! [DicDataModel]
                self.rootTableView.reloadData()
            }else{
                hud.mode = .text
                hud.label.text = "职位类型获取失败"
                hud.hide(animated: true, afterDelay: 1)
                
                let time: TimeInterval = 1.0
                let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    
                    _ = self.navigationController?.popViewController(animated: true)
                    
                }
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
        
        self.title = "职位类型"
        
        // tableView
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-20-44)
        rootTableView.rowHeight = 70
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
    }
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return positionTypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CHSMiSettingCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CHSMiSettingCell")
        }
        cell!.selectionStyle = .none
        
        cell!.accessoryType = .disclosureIndicator
        
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell?.textLabel?.textAlignment = .left
        cell?.textLabel?.textColor = UIColor.black
        
        cell?.textLabel!.text = positionTypeArray[indexPath.row].name
        
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell?.detailTextLabel?.textAlignment = .left
        cell?.detailTextLabel?.textColor = UIColor.lightGray
        
        cell?.detailTextLabel?.text = positionTypeArray[indexPath.row].description
        
        cell?.backgroundColor = UIColor.white
        
        return cell!
    }
    
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let choosePositionVC = CHSReChoosePositionViewController()
        choosePositionVC.vcType = self.vcType
        choosePositionVC.positionTypeID = (self.positionTypeArray[indexPath.row].term_id ?? "")!
        self.navigationController?.pushViewController(choosePositionVC, animated: true)
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
