//
//  CHSChRetrievalViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/18.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSChRetrievalViewController: UIViewController {

    let retrievalNameArray = ["职位红包","面试红包","就职红包","好评企业","最近企业","高薪企业","最热企业","最新企业"]
    let retrievalImageArray = [#imageLiteral(resourceName: "ic_检索_职位红包"),#imageLiteral(resourceName: "ic_检索_面试红包"),#imageLiteral(resourceName: "ic_检索_就职红包"),#imageLiteral(resourceName: "ic_检索_好评企业"),#imageLiteral(resourceName: "ic_检索_最近企业"),#imageLiteral(resourceName: "ic_检索_高薪企业"),#imageLiteral(resourceName: "ic_检索_最热企业"),#imageLiteral(resourceName: "ic_检索_最新企业")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
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
        
    }
    // 调整 button 图片和文字
    func initButton(_ btn:UIButton) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center//使图片和文字水平居中显示
        btn.titleEdgeInsets = UIEdgeInsetsMake((btn.imageView!.frame.size.height+btn.titleLabel!.bounds.size.height)/2+8, -btn.imageView!.frame.size.width, 0.0,0.0)//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0,(btn.imageView!.frame.size.height+btn.titleLabel!.bounds.size.height)/2+5, -btn.titleLabel!.bounds.size.width)//图片距离右边框距离减少图片的宽度，其它不边
    }
    // MARK: 进入首页 按钮 点击事件
    func comeinBtnClick(sender:UIButton) {
//        let vc = CHRoHomeViewController()
        var dic = NSDictionary()
        
        switch sender.tag {
        case 1000:
            dic = ["num":"5"]
        case 1001:
            dic = ["num":"6"]
        case 1002:
            dic = ["num":"7"]
        case 1003:
            dic = ["num":"3"]
        case 1004:
            dic = ["num":"2"]
        case 1005:
            dic = ["num":"4"]
        case 1006:
            dic = ["num":"1"]
        case 1007:
            dic = ["num":"0"]
        default:
            break
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: dic)
        
        self.popViewcontroller()
        
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
