//
//  CHSReChoosePositionViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/12.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSReChoosePositionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var vcType:FromVCType = .Default

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
        
        self.title = "选择职位"
        
        // tableView
        firstTableView.frame = CGRectMake(0, 64, kWidthScale*160, screenSize.height-20-44)
        firstTableView.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        firstTableView.rowHeight = 40
        firstTableView.tag = 101
        firstTableView.dataSource = self
        firstTableView.delegate = self
        self.view.addSubview(firstTableView)
        
        secondTableView.frame = CGRectMake(kWidthScale*160, 64, kWidthScale*215, screenSize.height-20-44)
        secondTableView.backgroundColor = UIColor.whiteColor()
        secondTableView.rowHeight = 40
        secondTableView.tag = 102
        secondTableView.dataSource = self
        secondTableView.delegate = self
        self.view.addSubview(secondTableView)
        
        firstArray = Array(rootDic.keys)
        secondArray = rootDic[firstArray.first!]!
        
        firstCurrentSelectedRow = 1
        secondCurrentSelectedRow = 2
    }
    
    // MARK: UITableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 101 {
            return firstArray.count
        }else{
            return secondArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CHSMiSettingCell")
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "CHSMiSettingCell")
        }
        cell!.selectionStyle = .None
        
        cell!.accessoryType = .None
        
        cell?.textLabel?.font = UIFont.systemFontOfSize(15)
        cell?.textLabel?.textAlignment = .Left
        
        cell?.backgroundColor = UIColor.clearColor()
        
        if tableView.tag == 101 {
            
            if firstCurrentSelectedRow == indexPath.row {
                cell?.textLabel?.textColor = baseColor
            }else{
                
                cell?.textLabel?.textColor = UIColor.blackColor()
            }
            
            cell?.textLabel!.text = firstArray[indexPath.row]
        }else{
            
            if secondCurrentSelectedRow == indexPath.row {
                cell?.textLabel?.textColor = baseColor
            }else{
                
                cell?.textLabel?.textColor = UIColor.blackColor()
            }
            
            cell?.textLabel!.text = secondArray[indexPath.row]
        }
        
        return cell!
    }
    
    // MARK: UITableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.tag == 101 {
            
            firstCurrentSelectedRow = indexPath.row
            
            secondArray = rootDic[firstArray[indexPath.row]]!
        }else{
            
            secondCurrentSelectedRow = indexPath.row
            
            
            if self.vcType == .Intension {
                NSNotificationCenter.defaultCenter().postNotificationName("PersonalChangeJobIntensionNotification", object: nil, userInfo: ["type":"PositionType","value":secondArray[indexPath.row]])
                
            }else if self.vcType == .JobExperience {
                NSNotificationCenter.defaultCenter().postNotificationName("PersonalChangeJobExperienceNotification", object: nil, userInfo: ["type":"PositionType","value":secondArray[indexPath.row]])
                
            }
            
            self.navigationController?.popToViewController((self.navigationController?.viewControllers[(self.navigationController?.viewControllers.endIndex)!-3])!, animated: true)
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
