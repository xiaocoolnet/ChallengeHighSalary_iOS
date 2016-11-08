//
//  CHSMeChatViewController.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2016/10/31.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMeChatViewController: UIViewController {

    var jobInfo:JobInfoDataModel? {
        didSet {
            self.selfTitle = (self.jobInfo?.realname)!
            self.conversationId = (self.jobInfo?.userid)!
        }
    }
    
    var selfTitle = ""
    var conversationId = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setSubView()
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
