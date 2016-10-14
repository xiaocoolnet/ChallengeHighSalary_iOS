//
//  FTTaRetrievalViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/18.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaRetrievalViewController: UIViewController {

    let retrievalNameArray = ["推荐","最近","最热","最新","好评","在线"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))

        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "检索"
        
        let btnBgView = UIView(frame: CGRectMake(0, 0, 0, 0))
        self.view.addSubview(btnBgView)
        
        var cateBtnMaxX:CGFloat = 0
        var cateBtnMaxY:CGFloat = 0
        
        let shareBtnWidth:CGFloat = kWidthScale*80
        let shareBtnCount:Int = 2 // 每行的按钮数
        let margin_x_mid = kWidthScale*30
        let margin_y_mid = kHeightScale*30
        
        for (i,retrievalName) in retrievalNameArray.enumerate() {
            
            let cateBtn = UIButton(frame: CGRectMake(
                (shareBtnWidth+margin_x_mid)*CGFloat(i%shareBtnCount),
                (shareBtnWidth+margin_y_mid)*CGFloat(i/shareBtnCount),
                shareBtnWidth,
                shareBtnWidth))
            cateBtn.layer.cornerRadius = shareBtnWidth/2.0
            cateBtn.layer.borderWidth = 2
            cateBtn.layer.borderColor = baseColor.CGColor
            cateBtn.backgroundColor = UIColor.whiteColor()
            cateBtn.setTitleColor(baseColor, forState: .Normal)
            cateBtn.setTitle(retrievalName, forState: .Normal)
            cateBtn.tag = 1000+i
            //            shareBtn_1.addTarget(self, action: #selector(shareBtnClick(_:)), forControlEvents: .TouchUpInside)
            btnBgView.addSubview(cateBtn)
//            print(cateBtn.frame)
            
            cateBtnMaxX = CGRectGetMaxX(cateBtn.frame)
            cateBtnMaxY = CGRectGetMaxY(cateBtn.frame)
        }
        
        btnBgView.frame.size = CGSizeMake(cateBtnMaxX, cateBtnMaxY)
        
        btnBgView.center = self.view.center
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
