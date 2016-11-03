//
//  ChMeHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/5.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChMeHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height-20-44-49), style: .Plain)
    
    var dataArray = [
        [
            "conversationId":"",
            "title":"系统消息",
            "description":"北京时代网络公司正在招聘网页设计师噢",
            "time":"07月20日",
            "image":"ic_message_home_系统",
            "type":"1"
        ],
        [
            "conversationId":"",
            "title":"面试邀请通知",
            "description":"北京时代网络公司邀请您去面试",
            "time":"07月20日",
            "image":"ic_message_home_面试",
            "type":"2"
        ],
        [
            "conversationId":"",
            "title":"谁收藏我",
            "description":"北京时代网络公司收藏了您的简历",
            "time":"07月20日",
            "image":"ic_message_home_收藏",
            "type":"3"
        ],
        [
            "conversationId":"",
            "title":"谁看过我",
            "description":"北京时代网络公司查看了您的简历",
            "time":"07月20日",
            "image":"ic_message_home_查看",
            "type":"4"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setNavigationBar()
        setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = false
        
        
        self.dataArray.removeRange(Range(4 ..< self.dataArray.count))
//        for conversation in [] {
////            [
////                "title":"王小妞",
////                "description":"",
////                "time":"07月20日",
////                "type":"5"
////            ],
//            
//            if conversation.conversationId == "admin" {
//                var description = ""
//                switch conversation.latestMessage.body.type {
//                case EMMessageBodyTypeText:
//                    description = (conversation.latestMessage.body as! EMTextMessageBody).text
//                default:
//                    description = "[其他]"
//                }
//                
//                let dic:[String:String] = [
//                    "conversationId":conversation.conversationId,
//                    "title":"系统消息",
//                    "description":description,
//                    "time":self.timeStampToString(String(conversation.latestMessage.timestamp/1000)),
//                    "image":"ic_message_home_系统",
//                    "type":"5"]
//                
//                self.dataArray.append(dic)
//                self.rootTableView.reloadData()
//            }else{
//                
//                FTNetUtil().getMyCompany_info(conversation.conversationId, handle: { (success, response) in
//                    if success {
//                        let company_infoData = response as! Company_infoDataModel
//                        
//                        var description = ""
//                        switch conversation.latestMessage.body.type {
//                        case EMMessageBodyTypeText:
//                            description = (conversation.latestMessage.body as! EMTextMessageBody).text
//                        default:
//                            description = "[其他]"
//                        }
//                        
//                        let dic:[String:String] = [
//                            "conversationId":conversation.conversationId,
//                            "title":company_infoData.company_name,
//                            "description":description,
//                            "time":self.timeStampToString(String(conversation.latestMessage.timestamp/1000)),
//                            "image":kImagePrefix+company_infoData.logo,
//                            "type":"5"]
//                        
//                        self.dataArray.append(dic)
//                        self.rootTableView.reloadData()
//                    }
//                })
//            }
//            
//        }
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        self.title = "消息"
        
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()
        
        // tableView
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-20-44-49)
        rootTableView.registerNib(UINib.init(nibName: "CHSMeHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "CHSMeHomeCell")
        rootTableView.rowHeight = 66
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
    }
    
    // MARK: UITableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CHSMeHomeCell") as! CHSMeHomeTableViewCell
        cell.selectionStyle = .None
        
        switch self.dataArray[indexPath.row]["type"]! {
        case "5":
            let url = NSURL(string: (self.dataArray[indexPath.row]["image"]! ?? "")!)
            cell.iconImg.sd_setImageWithURL(url, placeholderImage: nil)
        default:
            cell.iconImg.image = UIImage(named: self.dataArray[indexPath.row]["image"]!)
        }
        
        cell.titleLab.text = self.dataArray[indexPath.row]["title"]!
        cell.descriptionLab.text = self.dataArray[indexPath.row]["description"]!
        cell.timeLab.text = self.dataArray[indexPath.row]["time"]!
        
        return cell
    }
    
    // MARK: UITableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch self.dataArray[indexPath.row]["type"]! {
        case "1":
            self.navigationController?.pushViewController(CHSMeSysMessageViewController(), animated: true)
        case "2":
            self.navigationController?.pushViewController(CHSMeInvitedViewController(), animated: true)
        case "3":
            self.navigationController?.pushViewController(CHSMeCollectionMeViewController(), animated: true)
        case "4":
            self.navigationController?.pushViewController(CHSMeLookMeViewController(), animated: true)
            
        case "5":
//            let chatController = CHSMeChatViewController(conversationChatter: self.conversations[indexPath.row-4].conversationId, conversationType: EMConversationTypeChat)
            let chatController = CHSMeChatViewController()

            chatController.hidesBottomBarWhenPushed = true
            
            chatController.selfTitle = self.dataArray[indexPath.row]["title"]!
//            chatController.conversationId = self.conversations[indexPath.row-4].conversationId
            
            
            self.navigationController?.pushViewController(chatController, animated: true)

        default:
//            let chatController = CHSMeChatViewController(conversationChatter: self.conversations[indexPath.row-4].conversationId, conversationType: EMConversationTypeChat)
            let chatController = CHSMeChatViewController()

            chatController.hidesBottomBarWhenPushed = true
            
            chatController.selfTitle = self.dataArray[indexPath.row]["title"]!
//            chatController.conversationId = self.conversations[indexPath.row-4].conversationId
            
            
            self.navigationController?.pushViewController(chatController, animated: true)
        }
        //        self.navigationController?.pushViewController(CHSChPersonalInfoViewController(), animated: true)
    }
    
    // Linux时间戳转标准时间
    func timeStampToString(timeStamp:String)->String {
        
        let string = NSString(string: timeStamp)
        
        let timeSta:NSTimeInterval = string.doubleValue
        let dfmatter = NSDateFormatter()
        dfmatter.dateFormat="MM月dd日"
        
        let date = NSDate(timeIntervalSince1970: timeSta)
        
        //        print(dfmatter.stringFromDate(date))
        return dfmatter.stringFromDate(date)
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
