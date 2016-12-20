//
//  FTMeHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/8.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMeHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-20-44-49), style: .plain)
    
    var chatListArray = [GetChatListData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setNavigationBar()
        setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        CHSNetUtil().GetChatListData(CHSUserInfo.currentUserInfo.userid) { (success, response) in
            
            if success {
                
                self.chatListArray = (response as? [GetChatListData])!
                
                self.rootTableView.reloadData()
            }else {
                
            }
        }
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        self.title = "消息"
        
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        
        // tableView
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-20-44-49)
        rootTableView.register(UINib.init(nibName: "FTMeHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "FTMeHomeCell")
        rootTableView.rowHeight = 66
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
    }
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatListArray.count+4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FTMeHomeCell") as! FTMeHomeTableViewCell
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            cell.titleLab.text = "系统消息"
            
            cell.descriptionLab.text = "北京时代网络公司正在招聘网页设计师（假数据）"
            
            cell.timeLab.text = "07月20日"
            
            cell.iconImg.image = UIImage(named: "ic_message_home_系统")

        case 1:
            cell.titleLab.text = "简历投递通知"
            
            cell.descriptionLab.text = "北京时代网络公司邀请您去面试（假数据）"
            
            cell.timeLab.text = "07月20日"
            
            cell.iconImg.image = UIImage(named: "ic_message_home_面试")

        case 2:
            cell.titleLab.text = "谁收藏我"
            
            cell.descriptionLab.text = "北京时代网络公司收藏了您的简历（假数据）"
            
            cell.timeLab.text = "07月20日"
            
            cell.iconImg.image = UIImage(named: "ic_message_home_收藏")

        case 3:
            cell.titleLab.text = "谁看过我"
            
            cell.descriptionLab.text = "北京时代网络公司查看了您的简历（假数据）"
            
            cell.timeLab.text = "07月20日"
            
            cell.iconImg.image = UIImage(named: "ic_message_home_查看")
            
        default:
            let chatData = self.chatListArray[indexPath.row-4]
            
            cell.titleLab.text = chatData.other_nickname
            
            cell.descriptionLab.text = chatData.last_content
            
            cell.timeLab.text = chatData.create_time
            
            cell.iconImg.sd_setImage(with: URL(string: kImagePrefix + (chatData.other_face ?? "")!), placeholderImage: #imageLiteral(resourceName: "ic_默认头像"))
        }
        
        
        return cell
    }
    
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(FTMeSysMessageViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(FTMeResumeNotificationViewController(), animated: true)
        case 2:
            self.navigationController?.pushViewController(FTMeCollectionMeViewController(), animated: true)
        case 3:
            self.navigationController?.pushViewController(FTMeLookMeViewController(), animated: true)
        default:
            
            if self.chatListArray[indexPath.row-4].chat_uid == nil {
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.margin = 10
                hud.removeFromSuperViewOnHide = true
                hud.mode = .text
                hud.label.text = "数据出错，请稍后再试"
                hud.hide(animated: true, afterDelay: 1)
                return
            }
            let chatController = FTMeChatViewController()
            chatController.hidesBottomBarWhenPushed = true
            chatController.otherId = self.chatListArray[indexPath.row-4].chat_uid!
            self.navigationController?.pushViewController(chatController, animated: true)
        }
        //        self.navigationController?.pushViewController(CHSChPersonalInfoViewController(), animated: true)
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
