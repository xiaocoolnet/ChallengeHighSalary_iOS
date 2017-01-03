//
//  CHSMeChatViewController.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2016/10/31.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMeChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    let rootTableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    let inputBgView = UIView()
    
    let inputTF = UITextField()
    
    let sendBtn = UIButton()
    
    var keyboardShowState = false
    
    var jobInfo:JobInfoDataModel? {
        didSet {
            self.selfTitle = (self.jobInfo?.realname)!
            self.conversationId = (self.jobInfo?.userid)!
            
            self.setTableViewHeaderView()
        }
    }
    
    var chatListDataArray = [ChatData]()
    
    var selfTitle = ""
    var otherId = ""
    var conversationId = ""
    
    var timeArray = [Float]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setSubView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(newMessageRecived(noti:)), name: NSNotification.Name(rawValue: "NewMessageRecivedNotification"), object: nil)
    }
    
    func newMessageRecived(noti:Notification) {
//        let userInfo = noti.userInfo
        
        
        
//        let chatData = ChatData()
        
//        chatData.send_uid = userInfo?["extras"] ["v"] as! String
//        chatData.content = userInfo?["alert"] as! String
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CHSNetUtil().GetChatData(CHSUserInfo.currentUserInfo.userid, receive_uid: (self.jobInfo?.userid ?? otherId)!) { (success, response) in
            
            if success {
                self.chatListDataArray = response as! [ChatData]
                
//                self.timeArray.append(NSString(string: (self.chatListDataArray.first!.create_time ?? "")!).floatValue)
                
                for chatdata in self.chatListDataArray {
                    
                    let nowTime:Float = NSString(string: (chatdata.create_time ?? "")!).floatValue

                    if nowTime-(self.timeArray.last ?? 0)! > 60*5 {
                        
                        self.timeArray.append(nowTime)
                        
                    }else{
                        self.timeArray.append(self.timeArray.last!)
                    }
                    
                }
                
                self.rootTableView.reloadData()
                
                if self.rootTableView.contentSize.height-self.rootTableView.frame.size.height >= 0 {
                    self.rootTableView.contentOffset = CGPoint(x: 0, y: self.rootTableView.contentSize.height-self.rootTableView.frame.size.height)

                }else{
                    self.rootTableView.contentOffset = CGPoint(x: 0, y: 0)

                }

            }
        }
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK:- 设置子视图
    func setSubView() {
        
        self.title = self.selfTitle
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        self.view.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
        
//        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];

        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height - 64-44)
        rootTableView.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
        rootTableView.separatorStyle = .none
        rootTableView.delegate = self
        rootTableView.dataSource = self
        
        self.view.addSubview(rootTableView)
        
        rootTableView.register(CHSMeChatTableViewCell.self, forCellReuseIdentifier: "CHSMeChatCell")
        rootTableView.register(UINib(nibName: "CHSChCompanyPositionTableViewCell", bundle: nil), forCellReuseIdentifier: "CHSMeChatCompanyPositionCell")

        inputBgView.frame = CGRect(x: 0, y: screenSize.height-44, width: screenSize.width, height: 44)
        inputBgView.backgroundColor = UIColor(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1)
        self.view.addSubview(inputBgView)
        
        inputTF.frame = CGRect(x: 8, y: 5, width: screenSize.width-50-24, height: 34)
//        inputView.backgroundColor = UIColor.cyan
        inputTF.borderStyle = .roundedRect
        inputTF.returnKeyType = .send
        inputTF.delegate = self
        inputTF.addTarget(self, action: #selector(inputTFEditChanged(textField:)), for: .editingChanged)
        inputBgView.addSubview(inputTF)
        
        sendBtn.frame = CGRect(x: screenSize.width-50-8, y: 5, width: 50, height: 34)
        sendBtn.backgroundColor = UIColor.lightGray
        sendBtn.layer.cornerRadius = 8
        sendBtn.setTitleColor(UIColor.white, for: .normal)
        sendBtn.setTitle("发送", for: .normal)
        sendBtn.addTarget(self, action: #selector(sendBtnClick), for: .touchUpInside)
        inputBgView.addSubview(sendBtn)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidAppear(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)

        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    var keyboardheight:CGFloat = 0
    // MARK: - 点击发送按钮
    func sendBtnClick() {
        if self.inputTF.text!.isEmpty {
            return
        }else{
            
            let chatData = ChatData()
            chatData.content = self.inputTF.text
            chatData.create_time = String(NSDate().timeIntervalSince1970)
            chatData.receive_uid = self.jobInfo?.userid
            chatData.receive_face = self.jobInfo?.photo
            chatData.receive_nickname = self.jobInfo?.realname
            chatData.send_uid = CHSUserInfo.currentUserInfo.userid
            chatData.send_face = CHSUserInfo.currentUserInfo.avatar
            chatData.send_nickname = CHSUserInfo.currentUserInfo.realName
            self.chatListDataArray.append(chatData)
            
            let nowTime:Float = NSString(string: (chatData.create_time ?? "")!).floatValue
            
            if nowTime-(self.timeArray.last ?? 0)! > 60*5 {
                
                self.timeArray.append(nowTime)
                
            }else{
                self.timeArray.append(self.timeArray.last!)
            }
            self.rootTableView.reloadData()
            
//            abs(self.rootTableView.contentSize.height-self.rootTableView.frame.size.height)
//            if abs(self.rootTableView.contentSize.height-self.rootTableView.frame.size.height)+self.keyboardheight >= 0 {
//                
//                if self.rootTableView.contentSize.height-self.rootTableView.frame.size.height >= 0 {
//                    self.rootTableView.frame.origin.y = 64-self.keyboardheight
//                }else{
//                    self.rootTableView.frame.origin.y = 64-(self.rootTableView.contentSize.height-(self.rootTableView.frame.size.height-self.keyboardheight))
//                }
//                
//            }else{
//                self.rootTableView.frame.origin.y = 64
//                
//            }
//            
//            if self.rootTableView.contentSize.height-self.rootTableView.frame.size.height+keyboardheight >= 0 {
//                self.rootTableView.contentOffset = CGPoint(x: 0, y: self.rootTableView.contentSize.height-self.rootTableView.frame.size.height)
//                
//            }else{
//                self.rootTableView.contentOffset = CGPoint(x: 0, y: 0)
//                
//            }
//            if self.rootTableView.contentSize.height < self.rootTableView.frame.size.height {
//                
//                if self.rootTableView.contentSize.height < self.rootTableView.frame.size.height-keyboardheight {
//                    
//                }else{
//                    self.rootTableView.frame.origin.y = 64-self.keyboardheight
//                    self.rootTableView.contentOffset = CGPoint(x: 0, y: self.rootTableView.contentSize.height-self.rootTableView.frame.size.height)
//                }
//            }
            if self.rootTableView.contentSize.height >= self.rootTableView.frame.size.height-keyboardheight {
                self.rootTableView.frame.origin.y = 64-self.keyboardheight
                self.rootTableView.contentOffset = CGPoint(x: 0, y: self.rootTableView.contentSize.height-self.rootTableView.frame.size.height)
            }
//            if self.rootTableView.contentSize.height < self.rootTableView.frame.size.height {
//                
//                if self.rootTableView.contentSize.height < self.rootTableView.frame.size.height-keyboardheight {
//                    
//                }else{
//                    self.rootTableView.frame.origin.y = 64-self.keyboardheight
//                    self.rootTableView.contentOffset = CGPoint(x: 0, y: self.rootTableView.contentSize.height-self.rootTableView.frame.size.height)
//                }
//            }else{
//                self.rootTableView.frame.origin.y = 64-self.keyboardheight
//                self.rootTableView.contentOffset = CGPoint(x: 0, y: self.rootTableView.contentSize.height-self.rootTableView.frame.size.height)
//            }
//            self.rootTableView.contentOffset = CGPoint(x: 0, y: self.rootTableView.contentSize.height-self.rootTableView.frame.size.height)
            
            inputTF.text = nil
            
            self.inputTFEditChanged(textField: inputTF)
            
            CHSNetUtil().SendChatData(CHSUserInfo.currentUserInfo.userid, receive_uid: (self.jobInfo?.userid ?? otherId)!, content: chatData.content!, handle: { (success, response) in
                
                if success {
                    
//                    let chatData = response as! ChatData
//                    self.chatListDataArray[self.chatListDataArray.count-1] = chatData
//                    self.rootTableView.reloadData()
                }else{
                    
                }
            })
        }
        
    }
    
    // MARK: - 设置头视图
    func setTableViewHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 25))
        
        // 您正在与企业沟通 Label
        let tagLab = UILabel()
        tagLab.font = UIFont.systemFont(ofSize: 14)
        tagLab.text = "您正在与企业沟通"
        tagLab.textAlignment = .center
        tagLab.sizeToFit()
        tagLab.center = headerView.center
        tagLab.textColor = UIColor(red: 152/255.0, green: 151/255.0, blue: 152/255.0, alpha: 1)
        headerView.addSubview(tagLab)
        
        // 您正在与企业沟通 前 线
        let frontOrLine = UIView(frame: CGRect(
            x: screenSize.width*0.024,
            y: 0,
            width: tagLab.frame.origin.x-screenSize.width*0.048,
            height: 1))
        frontOrLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
        frontOrLine.center.y = tagLab.center.y
        headerView.addSubview(frontOrLine)
        
        // 您正在与企业沟通 后 线
        let behindOrLine = UIView(frame: CGRect(
            x: tagLab.frame.maxX+screenSize.width*0.024,
            y: 0,
            width: tagLab.frame.origin.x-screenSize.width*0.048,
            height: 1))
        behindOrLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
        behindOrLine.center.y = tagLab.center.y
        headerView.addSubview(behindOrLine)
        
        self.rootTableView.tableHeaderView = headerView
    }
    
    // MARK: - 获取键盘信息并改变视图
    func keyboardWillAppear(notification: Notification) {
        
        // 获取键盘信息
        keyboardheight = notification.keyboard_frameEnd.size.height
        
        UIView.animate(withDuration: 0.3) {
            self.inputBgView.frame.origin.y = screenSize.height-44-self.keyboardheight

            if self.rootTableView.contentSize.height-(self.rootTableView.frame.size.height-self.keyboardheight) >= 0 {
                
                if self.rootTableView.contentSize.height-self.rootTableView.frame.size.height >= 0 {
                    self.rootTableView.frame.origin.y = 64-self.keyboardheight
                }else{
                    self.rootTableView.frame.origin.y = 64-(self.rootTableView.contentSize.height-(self.rootTableView.frame.size.height-self.keyboardheight))
                }
                
            }else{
                self.rootTableView.frame.origin.y = 64
                
            }
        }
        
    }
    
    func keyboardDidAppear(notification:Notification) {
        keyboardShowState = true
    }
    
    func keyboardWillDisappear(notification:Notification){
        keyboardheight = 0
        UIView.animate(withDuration: 0.3) {
            self.inputBgView.frame.origin.y = screenSize.height-44
            self.rootTableView.frame.origin.y = 64

            //            self.myTableView.frame.size.height = HEIGHT-64-1-46
        }
        // print("键盘落下")
    }
    // MARK:-
    
    // MARK: - uitextfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.sendBtnClick()
        return true
    }
    
    // MARK: - 正在编辑文字
    func inputTFEditChanged(textField: UITextField) {
        
        if (textField.text?.characters.count ?? 0)! > 0 {
            self.sendBtn.backgroundColor = baseColor
        }else{
            self.sendBtn.backgroundColor = UIColor.lightGray
        }
    }
    
    // MARK: - uitableview datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.chatListDataArray.count+1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && self.jobInfo != nil {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CHSMeChatCompanyPositionCell") as! CHSChCompanyPositionTableViewCell
            cell.selectionStyle = .none
            cell.contentView.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)

            cell.company_infoJob = self.jobInfo
            return cell
        }else if indexPath.section > 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CHSMeChatCell", for: indexPath) as! CHSMeChatTableViewCell
            cell.selectionStyle = .none
            cell.contentView.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
            
            
            cell.chatListData = self.chatListDataArray[indexPath.section-1]
            
            cell.btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)

            
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    // MARK: - uitableview delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 146
        }else{
            
            let contentHeight = calculateHeight((self.chatListDataArray[indexPath.section-1].content ?? "")!, size: 16, width: screenSize.width-8-40-8-8-40-8)
            
            let headerImgHeight:CGFloat = 40
            
            return max(contentHeight, headerImgHeight)+8+8
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0.001
        }else if section == 1 {
            return 25
        }else{
            if self.timeArray[section-1] == self.timeArray[section-2] {
                return 0.001
            }else{
                return 25
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let timeLab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 25))
        timeLab.textAlignment = .center
        timeLab.textColor = UIColor.gray
        timeLab.font = UIFont.systemFont(ofSize: 14)
        
        if section == 0 {
            timeLab.text = nil
        }else if section == 1 {
            timeLab.text = self.timeStampToString((self.chatListDataArray[section-1].create_time ?? "")!)
        }else {
            
            if self.timeArray[section-1] == self.timeArray[section-2] {
                timeLab.text = nil
            }else{
                timeLab.text = self.timeStampToString((self.chatListDataArray[section-1].create_time ?? "")!)
            }
            
        }
        return timeLab
    }
    
    func clickBtn(){
        print(111)
        
        let vc = CHSMePositionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if keyboardShowState == true {
            
            inputTF.resignFirstResponder()
            keyboardShowState = false
        }
    }
    
    // Linux时间戳转标准时间
    func timeStampToString(_ timeStamp:String)->String {
        
        let string = NSString(string: timeStamp)
        
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd hh:mm"
        
        let date = Date(timeIntervalSince1970: timeSta)
        
        //        print(dfmatter.stringFromDate(date))
        return dfmatter.string(from: date)
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

extension Notification
{
    var keyboard_frameEnd : CGRect
    {
        if let val = self.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
        {
            return val.cgRectValue
        }
        return CGRect.zero
    }
    
    var keyboard_frameBegin : CGRect
    {
        if let val = self.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue
        {
            return val.cgRectValue
        }
        return CGRect.zero
    }
}

