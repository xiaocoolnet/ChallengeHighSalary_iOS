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
    let retrievalImageArray = [#imageLiteral(resourceName: "ic_检索_推荐"),#imageLiteral(resourceName: "ic_检索_最近"),#imageLiteral(resourceName: "ic_检索_最热"),#imageLiteral(resourceName: "ic_检索_最新"),#imageLiteral(resourceName: "ic_检索_好评"),#imageLiteral(resourceName: "ic_检索_在线")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
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
            cateBtn.addTarget(self, action: #selector(cateBtnClick(cateBtn:)), for: .touchUpInside)
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
        
    }
    // 调整 button 图片和文字
    func initButton(_ btn:UIButton) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center//使图片和文字水平居中显示
        btn.titleEdgeInsets = UIEdgeInsetsMake((btn.imageView!.frame.size.height+btn.titleLabel!.bounds.size.height)/2+8, -btn.imageView!.frame.size.width, 0.0,0.0)//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0,(btn.imageView!.frame.size.height+btn.titleLabel!.bounds.size.height)/2+5, -btn.titleLabel!.bounds.size.width)//图片距离右边框距离减少图片的宽度，其它不边
    }
    
    // MARK: 分类 按钮 点击事件
    func cateBtnClick(cateBtn:UIButton) {
        
        ftSortType = cateBtn.tag-1000
        
        _ = self.navigationController?.popViewController(animated: true)
        
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
