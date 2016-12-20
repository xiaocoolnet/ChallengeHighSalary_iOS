//
//  FTMiMyBlacklistViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import MJRefresh

class FTMiMyBlacklistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView()
    
    var blackListDataArray = [BlackListData_company]()
    
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
    
    // MARK: - 加载数据
    func loadData() {
        
        PublicNetUtil().getBlackList(CHSUserInfo.currentUserInfo.userid, type: "2") { (success, response) in
            if success {
                self.blackListDataArray = response as! [BlackListData_company]
                self.rootTableView.reloadData()
            }
            self.rootTableView.mj_header.endRefreshing()
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
        
        self.title = "我的黑名单"
        
        // tableView
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-20-44)
        rootTableView.register(UINib.init(nibName: "FTMiMyBlacklistTableViewCell", bundle: nil), forCellReuseIdentifier: "FTMiMyBlacklistCell")
        rootTableView.rowHeight = 100
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadData))
        rootTableView.mj_header.beginRefreshing()
    }
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blackListDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FTMiMyBlacklistCell") as! FTMiMyBlacklistTableViewCell
        cell.selectionStyle = .none
        
        cell.blackListResumeData = self.blackListDataArray[indexPath.row].blacks
        cell.cancelBlacklistBtn.tag = 100+indexPath.row
        cell.cancelBlacklistBtn.addTarget(self, action: #selector(cancelBtnClick(with:)), for: .touchUpInside)
        return cell
    }
    
    // MARK: - 取消黑名单按钮 点击事件
    func cancelBtnClick(with cancelBtn:UIButton) {
        
        let alertController = UIAlertController(title: "您确定要取消拉黑 \((self.blackListDataArray[cancelBtn.tag-100].blacks?.realname ?? "该用户")!) 吗？", message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        
        let cancelAction = UIAlertAction(title: "点错了", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in
            
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.removeFromSuperViewOnHide = true

            PublicNetUtil().delBlackList(CHSUserInfo.currentUserInfo.userid, type: "2", blackid: (self.blackListDataArray[cancelBtn.tag-100].blackid ?? "")!) { (success, response) in
                if success {
                    
                    hud.hide(animated: true)

                    self.blackListDataArray.remove(at: cancelBtn.tag-100)
                    self.rootTableView.reloadData()
                }else{
                    hud.mode = .text
                    hud.label.text = ((response as? String) ?? "取消黑名单失败，请稍后再试")!
                    hud.hide(animated: true, afterDelay: 1)
                }
            }
        }
        alertController.addAction(sureAction)
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
