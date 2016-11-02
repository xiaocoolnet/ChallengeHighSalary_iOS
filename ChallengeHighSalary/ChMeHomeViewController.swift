//
//  ChMeHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/5.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChMeHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EMChatManagerDelegate {
    
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
    
    var conversations = [EMConversation]()
    
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
        
        //消息回调:EMChatManagerChatDelegate
        
        //移除消息回调
        EMClient.sharedClient().chatManager.removeDelegate(self)
        
        //注册消息回调
        EMClient.sharedClient().chatManager.addDelegate(self, delegateQueue: nil)
        
        conversations = (EMClient.sharedClient().chatManager.getAllConversations() as! [EMConversation]) ?? [EMConversation]()
        
        
        self.dataArray.removeRange(Range(4 ..< self.dataArray.count))
        for conversation in conversations {
//            [
//                "title":"王小妞",
//                "description":"",
//                "time":"07月20日",
//                "type":"5"
//            ],
            
            if conversation.conversationId == "admin" {
                var description = ""
                switch conversation.latestMessage.body.type {
                case EMMessageBodyTypeText:
                    description = (conversation.latestMessage.body as! EMTextMessageBody).text
                default:
                    description = "[其他]"
                }
                
                let dic:[String:String] = [
                    "conversationId":conversation.conversationId,
                    "title":"系统消息",
                    "description":description,
                    "time":self.timeStampToString(String(conversation.latestMessage.timestamp/1000)),
                    "image":"ic_message_home_系统",
                    "type":"5"]
                
                self.dataArray.append(dic)
                self.rootTableView.reloadData()
            }else{
                
                FTNetUtil().getMyCompany_info(conversation.conversationId, handle: { (success, response) in
                    if success {
                        let company_infoData = response as! Company_infoDataModel
                        
                        var description = ""
                        switch conversation.latestMessage.body.type {
                        case EMMessageBodyTypeText:
                            description = (conversation.latestMessage.body as! EMTextMessageBody).text
                        default:
                            description = "[其他]"
                        }
                        
                        let dic:[String:String] = [
                            "conversationId":conversation.conversationId,
                            "title":company_infoData.company_name,
                            "description":description,
                            "time":self.timeStampToString(String(conversation.latestMessage.timestamp/1000)),
                            "image":kImagePrefix+company_infoData.logo,
                            "type":"5"]
                        
                        self.dataArray.append(dic)
                        self.rootTableView.reloadData()
                    }
                })
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
            let chatController = CHSMeChatViewController(conversationChatter: self.conversations[indexPath.row-4].conversationId, conversationType: EMConversationTypeChat)
            chatController.hidesBottomBarWhenPushed = true
            
            chatController.selfTitle = self.dataArray[indexPath.row]["title"]!
            chatController.conversationId = self.conversations[indexPath.row-4].conversationId
            
            
            self.navigationController?.pushViewController(chatController, animated: true)

        default:
            let chatController = CHSMeChatViewController(conversationChatter: self.conversations[indexPath.row-4].conversationId, conversationType: EMConversationTypeChat)
            chatController.hidesBottomBarWhenPushed = true
            
            chatController.selfTitle = self.dataArray[indexPath.row]["title"]!
            chatController.conversationId = self.conversations[indexPath.row-4].conversationId
            
            
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
    
    /*!
     @method
     @brief 接收到一条及以上非cmd消息
     */
    func didReceiveMessages(aMessages: [AnyObject]!) {
        print("接收到一条及以上非cmd消息")
        
        for msg in aMessages {
            let message = msg as! EMMessage
            
            if message.conversationId == "admin" {
                self.analysisMessage(message, isSystemMessage: true, company_infoData: nil)
            }else{
                
                FTNetUtil().getMyCompany_info(message.conversationId, handle: { (success, response) in
                    if success {
                        let company_infoData = response as! Company_infoDataModel
                        self.analysisMessage(message, isSystemMessage: false, company_infoData: company_infoData)
                    }
                })
            }
            
        }
        
    }
    
    func analysisMessage(message:EMMessage, isSystemMessage:Bool, company_infoData:Company_infoDataModel?) {
        var description = ""
        
        let msgBody = message.body as EMMessageBody
        switch msgBody.type {
        case EMMessageBodyTypeText:
            
            // 收到的文字消息
            let textBody = msgBody as! EMTextMessageBody
            let txt = textBody.text
            print("收到的文字是 txt -- %@",txt)
            
            description = txt
            
        case EMMessageBodyTypeImage:
            
            // 得到一个图片消息body
            let body = msgBody as! EMImageMessageBody
            print("大图remote路径 -- %@"   ,body.remotePath)
            print("大图local路径 -- %@"    ,body.localPath) // // 需要使用sdk提供的下载方法后才会存在
            print("大图的secret -- %@"    ,body.secretKey)
            print("大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height)
            print("大图的下载状态 -- %lu",body.downloadStatus)
            
            
            // 缩略图sdk会自动下载
            print("小图remote路径 -- %@"   ,body.thumbnailRemotePath)
            print("小图local路径 -- %@"    ,body.thumbnailLocalPath)
            print("小图的secret -- %@"    ,body.thumbnailSecretKey)
            print("小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height)
            print("小图的下载状态 -- %lu",body.thumbnailDownloadStatus)
            
            description = "[图片]"
            
        case EMMessageBodyTypeLocation:
            
            let body = msgBody as! EMLocationMessageBody
            print("纬度-- %f",body.latitude)
            print("经度-- %f",body.longitude)
            print("地址-- %@",body.address)
            
            description = "[位置]"
            
        case EMMessageBodyTypeVoice:
            
            // 音频sdk会自动下载
            let body = msgBody as! EMVoiceMessageBody
            print("音频remote路径 -- %@"      ,body.remotePath)
            print("音频local路径 -- %@"       ,body.localPath) // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
            print("音频的secret -- %@"        ,body.secretKey)
            print("音频文件大小 -- %lld"       ,body.fileLength)
            print("音频文件的下载状态 -- %lu"   ,body.downloadStatus)
            print("音频的时间长度 -- %lu"      ,body.duration)
            
            description = "[音频]"
            
        case EMMessageBodyTypeVideo:
            
            let body = msgBody as! EMVideoMessageBody
            
            print("视频remote路径 -- %@"      ,body.remotePath)
            print("视频local路径 -- %@"       ,body.localPath) // 需要使用sdk提供的下载方法后才会存在
            print("视频的secret -- %@"        ,body.secretKey)
            print("视频文件大小 -- %lld"       ,body.fileLength)
            print("视频文件的下载状态 -- %lu"   ,body.downloadStatus)
            print("视频的时间长度 -- %lu"      ,body.duration)
            print("视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
            
            // 缩略图sdk会自动下载
            print("缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath)
            print("缩略图的local路径 -- %@"      ,body.thumbnailLocalPath)
            print("缩略图的secret -- %@"        ,body.thumbnailSecretKey)
            print("缩略图的下载状态 -- %lu"      ,body.thumbnailDownloadStatus)
            
            description = "[视频]"
            
        case EMMessageBodyTypeFile:
            
            let body = msgBody as! EMFileMessageBody
            print("文件remote路径 -- %@"      ,body.remotePath)
            print("文件local路径 -- %@"       ,body.localPath) // 需要使用sdk提供的下载方法后才会存在
            print("文件的secret -- %@"        ,body.secretKey)
            print("文件文件大小 -- %lld"       ,body.fileLength)
            print("文件文件的下载状态 -- %lu"   ,body.downloadStatus)
            
            description = "[文件]"
        default:
            break
        }
        
        var dic = [String:String]()
        if isSystemMessage {
            
            dic = [
                "conversationId":message.conversationId,
                "title":message.conversationId,
                "description":description,
                "time":self.timeStampToString(String(message.timestamp/1000)),
                "image":"",
                "type":"5"]
            
        }else{
            
            dic = [
                "conversationId":message.conversationId,
                "title":(company_infoData?.company_name ?? "公司名")!,
                "description":description,
                "time":self.timeStampToString(String(message.timestamp/1000)),
                "image":kImagePrefix+(company_infoData?.logo ?? "")!,
                "type":"5"]
            
        }
        
        var flag = true
        for (i,dict) in self.dataArray.enumerate() {
            if dict["conversationId"]! == "admin" {
                self.dataArray[i] = dic
                flag = false
                self.rootTableView.reloadData()
            }
        }
        
        if flag {
            self.dataArray.append(dic)
            self.rootTableView.reloadData()
        }

    }

    /*!
     @method
     @brief 接收到一条及以上cmd消息
     */
    func didReceiveCmdMessages(aCmdMessages: [AnyObject]!) {
        print("接收到一条及以上cmd消息")
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
