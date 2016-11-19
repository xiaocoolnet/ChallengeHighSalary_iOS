//
//  CHSMeChatViewController.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2016/10/31.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMeChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    let rootTableView = UITableView()
    
    let inputBgView = UIView()
    
    var keyboardShowState = false
    
    var jobInfo:JobInfoDataModel? {
        didSet {
            self.selfTitle = (self.jobInfo?.realname)!
            self.conversationId = (self.jobInfo?.userid)!
        }
    }
    
    var chatListDataArray = [ChatData]()
    
    var selfTitle = ""
    var conversationId = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setSubView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CHSNetUtil().GetChatData(CHSUserInfo.currentUserInfo.userid, receive_uid: (self.jobInfo?.userid ?? "")!) { (success, response) in
            
            if success {
                self.chatListDataArray = response as! [ChatData]
                self.rootTableView.reloadData()
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
        
        
//        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];

        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height - 64-44)
        rootTableView.delegate = self
        rootTableView.dataSource = self
        
        self.view.addSubview(rootTableView)
        
        rootTableView.register(CHSMeChatTableViewCell.self, forCellReuseIdentifier: "CHSMeChatCell")
        

        inputBgView.frame = CGRect(x: 0, y: screenSize.height-44, width: screenSize.width, height: 44)
        self.view.addSubview(inputBgView)
        
        let inputView = UITextField(frame: CGRect(x: 8, y: 5, width: screenSize.width-50-24, height: 34))
        inputView.backgroundColor = UIColor.cyan
        inputView.delegate = self
        inputBgView.addSubview(inputView)
        
        let sendBtn = UIButton(frame: CGRect(x: screenSize.width-50-8, y: 5, width: 50, height: 34))
        sendBtn.backgroundColor = UIColor.green
        inputBgView.addSubview(sendBtn)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidAppear(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)

        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    // MARK:- 获取键盘信息并改变视图
    func keyboardWillAppear(notification: Notification) {
        
        // 获取键盘信息
        let keyboardheight = notification.keyboard_frameEnd.size.height
        
        UIView.animate(withDuration: 0.3) {
            self.inputBgView.frame.origin.y = screenSize.height-44-keyboardheight
        }
        
    }
    
    func keyboardDidAppear(notification:Notification) {
        keyboardShowState = true
    }
    
    func keyboardWillDisappear(notification:Notification){
        UIView.animate(withDuration: 0.3) {
            self.inputBgView.frame.origin.y = screenSize.height-44

            //            self.myTableView.frame.size.height = HEIGHT-64-1-46
        }
        // print("键盘落下")
    }
    // MARK:-
    
    // MARK: - uitextfield delegate
    
    
    // MARK: - uitableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatListDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CHSMeChatCell", for: indexPath) as! CHSMeChatTableViewCell
        
        cell.chatListData = self.chatListDataArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let contentHeight = calculateHeight((self.chatListDataArray[indexPath.row].content ?? "")!, size: 16, width: screenSize.width-8-50-8-8-50-8)
        
        let headerImgHeight:CGFloat = 50
        
        return max(contentHeight, headerImgHeight)+8+8
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

