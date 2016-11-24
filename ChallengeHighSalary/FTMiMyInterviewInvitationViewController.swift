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
    
    override func viewWillAppear(_ animated: Bool) {

        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.title = "面试邀请"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "全部面试", style: .done, target: self, action: #selector(allInterviewBtnClick))
        
//        options.menuItemMargin = 5
//        options.menuItemMode = .Underline(height: 3, color: baseColor, horizontalPadding: 10, verticalPadding: 0)
        
        struct MenuItem1: MenuItemViewCustomizable {
        
            var displayMode: MenuItemDisplayMode {
                let title = MenuItemText(text: "待面试", color: UIColor.lightGray, selectedColor: baseColor, font: UIFont.systemFont(ofSize: 16), selectedFont: UIFont.systemFont(ofSize: 16))
                return .text(title: title)
            }

        }
        struct MenuItem2: MenuItemViewCustomizable {
        
            var displayMode: MenuItemDisplayMode {
                let title = MenuItemText(text: "已结束", color: UIColor.lightGray, selectedColor: baseColor, font: UIFont.systemFont(ofSize: 16), selectedFont: UIFont.systemFont(ofSize: 16))
                return .text(title: title)
            }
        
        }
        
        struct MenuOptions: MenuViewCustomizable {
            
            fileprivate var height: CGFloat = 44
            
            fileprivate var displayMode: MenuDisplayMode = .segmentedControl
            
            fileprivate var itemsOptions: [MenuItemViewCustomizable] = [MenuItem1(), MenuItem2()]
            
            fileprivate var focusMode: MenuFocusMode = .underline(height: 3, color: baseColor, horizontalPadding: 0, verticalPadding: 0)

        }
        
        struct PagingMenuOptions: PagingMenuControllerCustomizable {
            var componentType: ComponentType {
                
                let waitView = FTMiMyInterviewWaitViewController()
                waitView.invitedType = .waitInterview
                // let finishView = FTMiMyInterviewFinishViewController()
                let finishView = FTMiMyInterviewWaitViewController()
                finishView.invitedType = .completed
                
                return .all(menuOptions: MenuOptions(), pagingControllers: [waitView, finishView])
            }
        }
        
        let options = PagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)
        
        pagingMenuController.view.frame.origin.y = 64
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
        
        // Do any additional setup after loading the view.
    }
    
    // MARK:- 全部面试按钮点击事件
    func allInterviewBtnClick() {
        self.navigationController?.pushViewController(FTMiMyInterviewAllViewController(), animated: true)
    }
    
}
