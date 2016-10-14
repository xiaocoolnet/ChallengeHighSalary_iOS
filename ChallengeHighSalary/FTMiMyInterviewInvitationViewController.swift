//
//  FTMiMyInterviewInvitationViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import PagingMenuController

class FTMiMyInterviewInvitationViewController: UIViewController {
    
    let waitView = FTMiMyInterviewWaitViewController()
    let finishView = FTMiMyInterviewFinishViewController()
    
    override func viewWillAppear(animated: Bool) {

        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = true
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))

        self.title = "面试邀请"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "全部面试", style: .Done, target: self, action: #selector(allInterviewBtnClick))
        
        waitView.title = "待面试"
        
        finishView.title = "已结束"
        
        let viewControllers = [waitView,finishView]
        let options = PagingMenuOptions()
        options.menuItemMargin = 5
        options.menuHeight = 44
        options.menuDisplayMode = .SegmentedControl
        options.backgroundColor = UIColor.whiteColor()
        options.selectedBackgroundColor = UIColor.whiteColor()
        options.font = UIFont.systemFontOfSize(18)
        options.selectedFont = UIFont.systemFontOfSize(18)
        options.selectedTextColor = baseColor
        options.menuItemMode = .Underline(height: 3, color: baseColor, horizontalPadding: 10, verticalPadding: 0)
        let pagingMenuController = PagingMenuController(viewControllers: viewControllers, options: options)
        pagingMenuController.view.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-64)
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMoveToParentViewController(self)
        
        // Do any additional setup after loading the view.
    }
    
    // MARK:- 全部面试按钮点击事件
    func allInterviewBtnClick() {
        self.navigationController?.pushViewController(FTMiMyInterviewAllViewController(), animated: true)
    }
    
}
