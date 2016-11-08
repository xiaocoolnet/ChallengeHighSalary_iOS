//
//  CHSReChoosePositionViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/12.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSReChoosePositionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var vcType:FromVCType = .default

    let firstTableView = UITableView() // 左 tableview tag = 101
    let secondTableView = UITableView() // 右 tableview tag = 102
    
    let rootDic = ["计算机/互联网/通信":["全部","技术专员/助理","技术总监/经理","技术支持/维护","软件工程师","程序员"],"电子/电气":["硬件工程师","质量工程师","测试工程师","系统架构师","数据库管理/DBA","游戏设计/开发","网页设计/制作","语音/视频/图形网站编辑","项目经理/主管","产品经理/专员"],"机械/仪器仪表":["网站策划","网络管理员","网站运营","网络与信息安全工程师"]]
    //    var firstArray = ["计算机/互联网/通信","电子/电气","机械/仪器仪表"]
    var firstArray = [String]()
    var secondArray = [String]()
    
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
        
        firstArray = Array(rootDic.keys)
        secondArray = rootDic[firstArray.first!]!
        
//        firstCurrentSelectedRow = 1
//        secondCurrentSelectedRow = 2
    }
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 101 {
            return firstArray.count
        }else{
            return secondArray.count
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
                cell?.backgroundColor = UIColor.white
            }else{
                
                cell?.textLabel?.textColor = UIColor.black
                cell?.backgroundColor = UIColor.clear
            }
            
            cell?.textLabel!.text = firstArray[(indexPath as NSIndexPath).row]
        }else{
            
            if secondCurrentSelectedRow == (indexPath as NSIndexPath).row {
                cell?.textLabel?.textColor = baseColor
            }else{
                
                cell?.textLabel?.textColor = UIColor.black
            }
            
            cell?.textLabel!.text = secondArray[(indexPath as NSIndexPath).row]
        }
        
        return cell!
    }
    
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 101 {
            
            firstCurrentSelectedRow = (indexPath as NSIndexPath).row
            
            secondArray = rootDic[firstArray[(indexPath as NSIndexPath).row]]!
        }else{
            
            secondCurrentSelectedRow = (indexPath as NSIndexPath).row
            
            
            if self.vcType == .intension {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "PersonalChangeJobIntensionNotification"), object: nil, userInfo: ["type":"PositionType","value":secondArray[(indexPath as NSIndexPath).row]])
                
            }else if self.vcType == .jobExperience {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "PersonalChangeJobExperienceNotification"), object: nil, userInfo: ["type":"PositionType","value":secondArray[(indexPath as NSIndexPath).row]])
                
            }
            
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
