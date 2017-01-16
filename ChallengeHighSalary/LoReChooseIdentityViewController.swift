//
//  LoReChooseIdentityViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/10.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class LoReChooseIdentityViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        // Do any additional setup after loading the view.
        
        // 挑战高薪 头部
        let topBgImg = UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: screenSize.width,
            height: screenSize.height*0.4185))
        topBgImg.image = UIImage(named: "ic_身份选择_背景")
        self.view.addSubview(topBgImg)
        
        let textImg = UIImageView(image: UIImage(named: "ic_appNameImg"))
        textImg.center = topBgImg.center
        self.view.addSubview(textImg)
        
        let margin:CGFloat = 8
        
        // 抢人才按钮
        let forTalentBtn = UIButton(frame: CGRect(
            x: 0,
            y: screenSize.height*0.5,
            width: screenSize.width*0.858,
            height: screenSize.height*0.066))
        forTalentBtn.backgroundColor = baseColor
        forTalentBtn.layer.cornerRadius = 8
        forTalentBtn.setTitleColor(UIColor.white, for: UIControlState())
        forTalentBtn.setImage(UIImage(named: "ic_身份选择_抢人才"), for: UIControlState())
        forTalentBtn.setTitle("抢人才", for: UIControlState())
        forTalentBtn.addTarget(self, action: #selector(forTalentBtnClick), for: .touchUpInside)
        forTalentBtn.center.x = self.view.center.x
        forTalentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -margin/2.0, 0, margin/2.0)
        forTalentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin/2.0, 0, -margin/2.0)
        self.view.addSubview(forTalentBtn)
        
        // 挑战高薪 按钮
        let cHSalaryBtn = UIButton(frame: CGRect(
            x: 0,
            y: screenSize.height*0.6,
            width: screenSize.width*0.858,
            height: screenSize.height*0.066))
        cHSalaryBtn.backgroundColor = baseColor
        cHSalaryBtn.layer.cornerRadius = 8
        cHSalaryBtn.setTitleColor(UIColor.white, for: UIControlState())
        cHSalaryBtn.setImage(UIImage(named: "ic_身份选择_挑战高薪"), for: UIControlState())
        cHSalaryBtn.setTitle("挑战高薪", for: UIControlState())
        cHSalaryBtn.addTarget(self, action: #selector(chSalaryBtnClick), for: .touchUpInside)
        cHSalaryBtn.center.x = self.view.center.x
        cHSalaryBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -margin/2.0, 0, margin/2.0)
        cHSalaryBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin/2.0, 0, -margin/2.0)
        self.view.addSubview(cHSalaryBtn)
        
    }
    
    // MARK: 找人才 按钮 点击事件
    func forTalentBtnClick() {
        
        self.navigationController?.pushViewController(LoReFTPersonalInfoViewController(), animated: true)
    }
    
    // MARK: 挑战高薪 按钮 点击事件
    func chSalaryBtnClick() {
        
        self.navigationController?.pushViewController(LoReCHSPersonalInfoViewController(), animated: true)
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
