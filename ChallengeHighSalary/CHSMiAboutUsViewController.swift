//
//  CHSMiAboutUsViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/21.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiAboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        self.title = "关于我们"
        
        let aboutUsImg = UIImageView(frame: CGRect(x: screenSize.width*0.35, y: kHeightScale*75+64, width: screenSize.width*0.3, height: screenSize.width*0.3))
        aboutUsImg.image = #imageLiteral(resourceName: "appLogo")
        aboutUsImg.contentMode = .scaleAspectFill
        aboutUsImg.clipsToBounds = true
        self.view.addSubview(aboutUsImg)
        
        let aboutUsLab = UILabel(frame: CGRect(x: 0, y: aboutUsImg.frame.maxY+10, width: screenSize.width, height: 40))
        aboutUsLab.textColor = baseColor
        aboutUsLab.textAlignment = .center
        aboutUsLab.font = UIFont.boldSystemFont(ofSize: 24)
        aboutUsLab.text = "挑 战 高 薪"
        self.view.addSubview(aboutUsLab)
        
        // tip Label
        let tipLab = UILabel()
        tipLab.font = UIFont.systemFont(ofSize: 13)
        tipLab.text = "某某科技公司推出"
        tipLab.textAlignment = .center
        tipLab.sizeToFit()
        tipLab.center.x = self.view.center.x
        tipLab.frame.origin.y = screenSize.height*0.95
        tipLab.textColor = UIColor(red: 152/255.0, green: 151/255.0, blue: 152/255.0, alpha: 1)
        self.view.addSubview(tipLab)
        
        // tip前 线
        let frontTipLine = UIView(frame: CGRect(
            x: screenSize.width*0.024,
            y: 0,
            width: tipLab.frame.origin.x-screenSize.width*0.048,
            height: 1))
        frontTipLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
        frontTipLine.center.y = tipLab.center.y
        self.view.addSubview(frontTipLine)
        
        // tip后 线
        let behindTipLine = UIView(frame: CGRect(
            x: tipLab.frame.maxX+screenSize.width*0.024,
            y: 0,
            width: tipLab.frame.origin.x-screenSize.width*0.048,
            height: 1))
        behindTipLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
        behindTipLine.center.y = tipLab.center.y
        self.view.addSubview(behindTipLine)
        
        
//        let aboutUsImg = UILabel(frame: CGRect(x: kWidthScale*90, y: kHeightScale*75+64, width: screenSize.width-kWidthScale*180, height: kHeightScale*160))
//        aboutUsImg.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
//        aboutUsImg.textAlignment = .center
//        aboutUsImg.numberOfLines = 0
//        aboutUsImg.text = "挑战高薪，既能找到高薪工作又能抢到红包和面试费用安家费用的专业APP。\n是全国唯一一个 帮助人才就业并找到高薪工作的专业APP。\n随着您的资料的不断完善，系统和专家会对您综合评价。能够 针对人才特点做出专业分析把您介绍给更高待遇更适合您的企业，并使您人尽其才，找到更适合您，更 高待遇的工作。\n在您挑选工作的同时还会抽取到系统以及企业发放的红包。让您得到意外的收获。另外 还可能抽取到报销面试费用，就业安家费用等更多意外惊喜。\n在找工作的同时提高了娱乐性实用性。\n网站www.nzrc.com.cn\n电话：400-676-5009"
//        aboutUsImg.sizeToFit()
//        aboutUsImg.center = self.view.center
//        self.view.addSubview(aboutUsImg)
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
