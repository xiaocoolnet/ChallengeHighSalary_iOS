//
//  FTTaCompanyInfoViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/24.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaCompanyInfoViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    let rootTableView = UITableView()
    
    let nameArray = ["公司logo","公司全称","公司官网","所属行业","人员规模","融资阶段"]
    let detailNameArray = ["","北京互联科技有限公司","http://www.hulian.net","移动互联网","20-99人","未融资"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
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

        self.title = "公司信息"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(clickSaveBtn))
        
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 50
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- tableView dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "companyInfoCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "companyInfoCell")
        }
        cell?.accessoryType = .disclosureIndicator
        
        cell?.selectionStyle = .none
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell?.textLabel?.textColor = UIColor.black
        cell?.textLabel?.textAlignment = .left
        cell?.textLabel?.text = nameArray[(indexPath as NSIndexPath).row]
        
        if (indexPath as NSIndexPath).row == 0 {
            let logoImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            logoImg.layer.cornerRadius = 20
            logoImg.backgroundColor = UIColor.orange
            cell?.accessoryView = logoImg
        }else{
            cell?.accessoryView = nil
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
            cell?.detailTextLabel?.textAlignment = .right
            cell?.detailTextLabel?.text = detailNameArray[(indexPath as NSIndexPath).row]
        }
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud?.removeFromSuperViewOnHide = true
        hud?.mode = .text
        hud?.margin = 10
        hud?.labelText = "若需修改,请到『我的公司信息』页面"
        hud?.hide(true, afterDelay: 1)
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
