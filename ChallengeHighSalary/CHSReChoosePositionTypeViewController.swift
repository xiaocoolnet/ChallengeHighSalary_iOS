//
//  CHSReChoosePositionTypeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/12.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSReChoosePositionTypeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView()
    
    var vcType:FromVCType = .default

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
        return 3
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
        
        cell?.textLabel!.text = "网络|通信|电子"
        
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell?.detailTextLabel?.textAlignment = .left
        cell?.detailTextLabel?.textColor = UIColor.lightGray
        
        cell?.detailTextLabel?.text = "计算机/互联网/通信 | 电子/电气 | 机械/仪器仪表"
        
        cell?.backgroundColor = UIColor.white
        
        return cell!
    }
    
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let choosePositionVC = CHSReChoosePositionViewController()
        choosePositionVC.vcType = self.vcType
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
