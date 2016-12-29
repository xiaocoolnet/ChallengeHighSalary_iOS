//
//  CHSWelcomeViewController.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2016/12/22.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSWelcomeViewController: UIViewController {
    
    let retrievalNameArray = ["职位红包","面试红包","就职红包","好评企业","最近企业","高薪企业","最热企业","最新企业"]
    let retrievalImageArray = [#imageLiteral(resourceName: "ic_检索_职位红包"),#imageLiteral(resourceName: "ic_检索_面试红包"),#imageLiteral(resourceName: "ic_检索_就职红包"),#imageLiteral(resourceName: "ic_检索_好评企业"),#imageLiteral(resourceName: "ic_检索_最近企业"),#imageLiteral(resourceName: "ic_检索_高薪企业"),#imageLiteral(resourceName: "ic_检索_最热企业"),#imageLiteral(resourceName: "ic_检索_最新企业")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "进入首页", style: .done, target: self, action: #selector(comeinBtnClick))
        
        self.view.backgroundColor = UIColor.white
        self.title = "检索"
        
        let btnBgView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.view.addSubview(btnBgView)
        
        var cateBtnMaxX:CGFloat = 0
        var cateBtnMaxY:CGFloat = 0
        
        let shareBtnWidth:CGFloat = kWidthScale*80
        let shareBtnHeight:CGFloat = kWidthScale*80+30
        let shareBtnCount:Int = 2 // 每行的按钮数
        let margin_x_mid = kWidthScale*30
        let margin_y_mid = kHeightScale*30
        
        for (i,retrievalName) in retrievalNameArray.enumerated() {
            
            let cateBtn = UIButton(frame: CGRect(
                x: (shareBtnWidth+margin_x_mid)*CGFloat(i%shareBtnCount),
                y: (shareBtnWidth+margin_y_mid)*CGFloat(i/shareBtnCount),
                width: shareBtnWidth,
                height: shareBtnHeight))
//            cateBtn.layer.cornerRadius = shareBtnWidth/2.0
//            cateBtn.layer.borderWidth = 2
//            cateBtn.layer.borderColor = baseColor.cgColor
            cateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            cateBtn.backgroundColor = UIColor.white
            cateBtn.setImage(retrievalImageArray[i], for: .normal)
            cateBtn.setTitleColor(baseColor, for: UIControlState())
            cateBtn.setTitle(retrievalName, for: UIControlState())
            cateBtn.tag = 1000+i
            cateBtn.addTarget(self, action: #selector(comeinBtnClick), for: .touchUpInside)
            btnBgView.addSubview(cateBtn)
            //            print(cateBtn.frame)
            initButton(cateBtn)
            
            cateBtnMaxX = cateBtn.frame.maxX
            cateBtnMaxY = cateBtn.frame.maxY
        }
        
        btnBgView.frame.size = CGSize(width: cateBtnMaxX, height: cateBtnMaxY)
        
        btnBgView.center = self.view.center

//        btnBgView.center.x = self.view.center.x
//        btnBgView.center.y = self.view.center.y-screenSize.height*0.066
        
        let margin:CGFloat = 8
        
        // 退出登录 按钮
        let logOutBtn = UIButton(frame: CGRect(
            x: 0,
            y: screenSize.height*0.934,
            width: screenSize.width,
            height: screenSize.height*0.066))
        logOutBtn.backgroundColor = UIColor(white: 0.95, alpha: 1)
        logOutBtn.setTitleColor(baseColor, for: UIControlState())
        logOutBtn.setImage(UIImage(named: "ic_身份选择_退出"), for: UIControlState())
        logOutBtn.setTitle("退出登录", for: UIControlState())
        logOutBtn.addTarget(self, action: #selector(logOutBtnClick), for: .touchUpInside)
        logOutBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -margin/2.0, 0, margin/2.0)
        logOutBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin/2.0, 0, -margin/2.0)
        self.view.addSubview(logOutBtn)
    }
    // 调整 button 图片和文字
    func initButton(_ btn:UIButton) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center//使图片和文字水平居中显示
        btn.titleEdgeInsets = UIEdgeInsetsMake((btn.imageView!.frame.size.height+btn.titleLabel!.bounds.size.height)/2+8, -btn.imageView!.frame.size.width, 0.0,0.0)//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0,(btn.imageView!.frame.size.height+btn.titleLabel!.bounds.size.height)/2+5, -btn.titleLabel!.bounds.size.width)//图片距离右边框距离减少图片的宽度，其它不边
    }
    // MARK: 进入首页 按钮 点击事件
    func comeinBtnClick() {
        
        self.present(CHRoHomeViewController(), animated: false, completion: nil)
        
    }
    // MARK: 退出 按钮 点击事件
    func logOutBtnClick() {
        
        let signOutAlert = UIAlertController(title: "", message: "确定退出登录？", preferredStyle: .alert)
        self.present(signOutAlert, animated: true, completion: nil)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        signOutAlert.addAction(cancelAction)
        
        let sureAction = UIAlertAction(title: "确定", style: .default, handler: { (sureAction) in
            
            UserDefaults.standard.set(false, forKey: isLogin_key)
            UserDefaults.standard.removeObject(forKey: logInfo_key)
            //                self.presentViewController(UINavigationController(rootViewController: LoHomeViewController()), animated: true, completion: nil)
            
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LoHomeViewController())
        })
        signOutAlert.addAction(sureAction)
        
    }
    
    // MARK: - 检索按钮点击事件
    func cateBtnClick(cateBtn:UIButton) {
        
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
