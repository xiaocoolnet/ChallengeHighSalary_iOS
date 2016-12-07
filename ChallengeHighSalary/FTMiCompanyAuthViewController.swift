//
//  FTMiCompanyAuthViewController.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2016/11/25.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMiCompanyAuthViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let authImgArray = [#imageLiteral(resourceName: "ic_comAuth_工牌"),#imageLiteral(resourceName: "ic_comAuth_营业执照")]
    let authImgTagArray = ["工牌","营业执照"]
        
    let rootScrollview = UIScrollView()
    
    let leftBtn = UIButton()
    let rightBtn = UIButton()
    let sureBtn = UIButton()
    
    let instructionBgImg = UIImageView()
    let instructionBgImg_2 = UIImageView()
    
    let instructionLab_2 = UILabel()
    
    let leftDotImg = UIButton()
    let rightDotImg = UIButton()
    
    
    let tagLabel = UILabel()
    
    var selectedImg = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "ic_clear"), for: .default)
        
        dotBtnClick(leftDotImg)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)

    }
    
    // MARK: - 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.layer.contents = #imageLiteral(resourceName: "FT_companyAuth_background").cgImage
        
        self.title = "认证公司身份"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        let bgView = UIView(frame: CGRect(x: screenSize.width*0.225, y: 100, width: screenSize.width*0.55, height: 0))
        bgView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        bgView.layer.cornerRadius = 8
        self.view.addSubview(bgView)
        
        rootScrollview.frame = CGRect(x: 0, y: 0, width: screenSize.width*0.55, height: screenSize.width*0.33)
        rootScrollview.isPagingEnabled = true
        rootScrollview.showsHorizontalScrollIndicator = false
        rootScrollview.showsVerticalScrollIndicator = false
        rootScrollview.delegate = self
        rootScrollview.contentSize = CGSize(width: rootScrollview.frame.width*CGFloat(authImgArray.count), height: 0)
        bgView.addSubview(rootScrollview)
        
        for (i,image) in self.authImgArray.enumerated() {
            
            let img = UIImageView(frame: CGRect(
                x: 8+CGFloat(i)*rootScrollview.frame.width,
                y: 8,
                width: rootScrollview.frame.width-16,
                height: rootScrollview.frame.height-16))
            img.contentMode = .scaleAspectFit
            img.clipsToBounds = true
            img.image = image
            rootScrollview.addSubview(img)
            
        }
        tagLabel.frame = CGRect(x: 0, y: rootScrollview.frame.maxY, width: 0, height: 0)
        tagLabel.textAlignment = .center
        tagLabel.textColor = baseColor
        tagLabel.font = UIFont.systemFont(ofSize: 16)
        tagLabel.text = authImgTagArray[Int(rootScrollview.contentOffset.x/rootScrollview.frame.width)]
        tagLabel.sizeToFit()
        tagLabel.center.x = bgView.frame.width/2.0
        bgView.addSubview(tagLabel)
        
        sureBtn.frame = CGRect(x: bgView.frame.width/2.0-40, y: tagLabel.frame.maxY+8, width: 80, height: 25)
        sureBtn.layer.cornerRadius = 12.5
        sureBtn.layer.borderColor = baseColor.cgColor
        sureBtn.layer.borderWidth = 1
        sureBtn.setTitleColor(baseColor, for: .normal)
        sureBtn.setTitle("确认", for: .normal)
        sureBtn.addTarget(self, action: #selector(sureBtnClick(_:)), for: .touchUpInside)
        bgView.addSubview(sureBtn)
        
        bgView.frame.size.height = sureBtn.frame.maxY+8
        
        leftBtn.frame = CGRect(x: (bgView.frame.minX-16)/2.0, y: 0, width: 16, height: 29)
        leftBtn.setImage(#imageLiteral(resourceName: "ic_comAuth_箭头_左_白"), for: .normal)
        leftBtn.setImage(#imageLiteral(resourceName: "ic_comAuth_箭头_左_绿"), for: .disabled)
        leftBtn.center.y = bgView.center.y
        leftBtn.addTarget(self, action: #selector(directionBtnClick(_:)), for: .touchUpInside)
        self.view.addSubview(leftBtn)
        
        rightBtn.frame = CGRect(x: screenSize.width-(bgView.frame.minX-16)/2.0-16, y: 0, width: 16, height: 29)
        rightBtn.setImage(#imageLiteral(resourceName: "ic_comAuth_箭头_右_白"), for: .normal)
        rightBtn.setImage(#imageLiteral(resourceName: "ic_comAuth_箭头_右_绿"), for: .disabled)
        rightBtn.center.y = bgView.center.y
        rightBtn.addTarget(self, action: #selector(directionBtnClick(_:)), for: .touchUpInside)
        self.view.addSubview(rightBtn)
        
        if rootScrollview.contentOffset.x == 0 {
            leftBtn.isEnabled = false
        }else if rootScrollview.contentOffset.x == rootScrollview.contentSize.width-rootScrollview.frame.width {
            rightBtn.isEnabled = false
        }
        
        let advantageBtn = UIButton(frame: CGRect(x: self.view.frame.width/2.0-75, y: screenSize.height-20-25, width: 150, height: 25))
        advantageBtn.layer.cornerRadius = 12.5
        advantageBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        advantageBtn.layer.borderColor = baseColor.cgColor
        advantageBtn.layer.borderWidth = 1
        advantageBtn.setTitleColor(baseColor, for: .normal)
        advantageBtn.setTitle("认证有啥好处？", for: .normal)
        advantageBtn.addTarget(self, action: #selector(advantageBtnClick), for: .touchUpInside)
        self.view.addSubview(advantageBtn)
        
        let timerShaftImg = UIView(frame: CGRect(x: 35, y: advantageBtn.frame.minY-35, width: screenSize.width-70, height: 1))
        timerShaftImg.backgroundColor = UIColor.lightGray
        self.view.addSubview(timerShaftImg)
        
        leftDotImg.frame = CGRect(x: kWidthScale*133.5-7.5, y: timerShaftImg.center.y-7.5, width: 15, height: 15)
        leftDotImg.setImage(#imageLiteral(resourceName: "ic_comAuth_时间点_灰"), for: .normal)
        leftDotImg.setImage(#imageLiteral(resourceName: "ic_comAuth_时间点_绿"), for: .selected)
        leftDotImg.addTarget(self, action: #selector(dotBtnClick(_:)), for: .touchUpInside)
        self.view.addSubview(leftDotImg)
        leftDotImg.isSelected = true
        
        rightDotImg.frame = CGRect(x: kWidthScale*240-7.5, y: timerShaftImg.center.y-7.5, width: 15, height: 15)
        rightDotImg.setImage(#imageLiteral(resourceName: "ic_comAuth_时间点_灰"), for: .normal)
        rightDotImg.setImage(#imageLiteral(resourceName: "ic_comAuth_时间点_绿"), for: .selected)
        rightDotImg.addTarget(self, action: #selector(dotBtnClick(_:)), for: .touchUpInside)
        self.view.addSubview(rightDotImg)
        
        // 一 说明背景
        instructionBgImg.frame = CGRect(x: screenSize.width/2.0-kWidthScale*135, y: kHeightScale*440, width: kWidthScale*270, height: kHeightScale*150)
        instructionBgImg.image = #imageLiteral(resourceName: "ic_comAuth_说明背景_left")
        instructionBgImg.isUserInteractionEnabled = true
        self.view.addSubview(instructionBgImg)
        
        let instructionLab = UILabel(frame: CGRect(x: 8, y: 8, width: instructionBgImg.frame.width, height: instructionBgImg.frame.height*0.5))
        instructionLab.numberOfLines = 0
        instructionLab.textAlignment = .center
        instructionLab.textColor = UIColor.gray
        instructionLab.text = "第一步：选择认证材料的类型\n（2选1）"
        instructionBgImg.addSubview(instructionLab)
        
        let instructionBtn = UIButton(frame: CGRect(
            x: instructionBgImg.frame.width/2.0-45,
            y: instructionLab.frame.maxY,
            width: 90,
            height: 25))
        instructionBtn.layer.cornerRadius = 12.5
        instructionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        instructionBtn.backgroundColor = baseColor
        instructionBtn.setTitleColor(UIColor.white, for: .normal)
        instructionBtn.setTitle("认证须知", for: .normal)
        instructionBtn.addTarget(self, action: #selector(instructionBtnClick(_:)), for: .touchUpInside)
        instructionBgImg.addSubview(instructionBtn)
        
        // 二 说明背景
        instructionBgImg_2.frame = CGRect(x: screenSize.width/2.0-kWidthScale*135, y: kHeightScale*440, width: kWidthScale*270, height: kHeightScale*150)
        instructionBgImg_2.image = #imageLiteral(resourceName: "ic_comAuth_说明背景_right")
        //instructionBgImg.backgroundColor = UIColor.cyan
        instructionBgImg_2.isHidden = true
        instructionBgImg_2.isUserInteractionEnabled = true
        self.view.addSubview(instructionBgImg_2)
        
        instructionLab_2.frame = CGRect(x: 8, y: 8, width: instructionBgImg_2.frame.width, height: instructionBgImg_2.frame.height*0.5)
        instructionLab_2.numberOfLines = 0
        instructionLab_2.textAlignment = .center
        instructionLab_2.textColor = UIColor.gray
        instructionLab_2.text = "第二步：拍摄提交认证资料\n（您选择提交XX）"
        instructionBgImg_2.addSubview(instructionLab_2)
        
        let instructionBtn_2_left = UIButton(frame: CGRect(
            x: instructionBgImg_2.frame.width/2.0-90-20,
            y: instructionLab_2.frame.maxY,
            width: 90,
            height: 25))
        instructionBtn_2_left.layer.cornerRadius = 12.5
        instructionBtn_2_left.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        instructionBtn_2_left.backgroundColor = baseColor
        instructionBtn_2_left.setTitleColor(UIColor.white, for: .normal)
        instructionBtn_2_left.setTitle("拍摄照片", for: .normal)
        instructionBtn_2_left.addTarget(self, action: #selector(cameraBtnClick), for: .touchUpInside)
        instructionBgImg_2.addSubview(instructionBtn_2_left)
        
        let instructionBtn_2_right = UIButton(frame: CGRect(
            x: instructionBgImg_2.frame.width/2.0+20,
            y: instructionLab_2.frame.maxY,
            width: 90,
            height: 25))
        instructionBtn_2_right.layer.cornerRadius = 12.5
        instructionBtn_2_right.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        instructionBtn_2_right.backgroundColor = baseColor
        instructionBtn_2_right.setTitleColor(UIColor.white, for: .normal)
        instructionBtn_2_right.setTitle("相册照片", for: .normal)
        instructionBtn_2_right.addTarget(self, action: #selector(albumBtnClick), for: .touchUpInside)
        instructionBgImg_2.addSubview(instructionBtn_2_right)
        
    }
 
    // MARK:- popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 点击方向按钮
    func directionBtnClick(_ btn:UIButton) {
        
        if btn == leftBtn {
            self.rootScrollview.contentOffset.x -= self.rootScrollview.frame.width
        }else if btn == rightBtn {
            self.rootScrollview.contentOffset.x += self.rootScrollview.frame.width
        }
        
        tagLabel.text = authImgTagArray[Int(round(rootScrollview.contentOffset.x/rootScrollview.frame.width))]
        tagLabel.sizeToFit()
        tagLabel.center.x = (tagLabel.superview?.frame.width ?? 0)!/2.0
        
        if round(rootScrollview.contentOffset.x/rootScrollview.frame.width) <= 0 {
            leftBtn.isEnabled = false
            rightBtn.isEnabled = true
        }else if round(rootScrollview.contentOffset.x/rootScrollview.frame.width)  >= CGFloat(authImgArray.count)-1 {
            rightBtn.isEnabled = false
            leftBtn.isEnabled = true
        }

    }
    
    // MARK: - 点击确认按钮
    func sureBtnClick(_ sureBtn:UIButton) {
        
        sureBtn.isHidden = true
        leftBtn.isEnabled = false
        rightBtn.isEnabled = false
        rootScrollview.isScrollEnabled = false
        
        instructionLab_2.text = "第二步：拍摄提交认证资料\n（您选择提交\(authImgTagArray[Int(round(rootScrollview.contentOffset.x/rootScrollview.frame.width))])）"

        instructionBgImg.isHidden = true
        instructionBgImg_2.isHidden = false
        
        leftDotImg.isSelected = false
        rightDotImg.isSelected = true
    }
    
    // MARK: - 认真须知按钮 点击事件
    let tipTextArray = [
        "1.上传工牌正面，保证Boss姓名、职务、头像与个人信息一致\n2.确保公章的公司全称，与您个人信息的公司全称一致\n3.确保所有信息清晰可辨认",
        "1.上传营业执照正面，确保所有信息清晰可见\n2.确保营业执照上的公司全称，与您个人信息中的公司全称一致"
    ]
    func instructionBtnClick(_ instructionBtn:UIButton) {
        
        let bgView = UIButton(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        bgView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        bgView.tag = 101
        bgView.addTarget(self, action: #selector(alertViewHide(_:)), for: .touchUpInside)
        UIApplication.shared.keyWindow!.addSubview(bgView)
        
        let alertView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width*0.7, height: 0))
        alertView.backgroundColor = UIColor(red: 222/255.0, green: 246/255.0, blue: 231/255.0, alpha: 1)
        alertView.layer.cornerRadius = 8
        alertView.center.x = bgView.center.x
        bgView.addSubview(alertView)
        
        // 图片
        let iconImg1 = UIImageView(frame: CGRect(x: 8, y: 8, width: alertView.frame.width-16, height: screenSize.height*0.3))
        iconImg1.contentMode = .scaleAspectFit
        iconImg1.clipsToBounds = true
        iconImg1.image = authImgArray[Int(round(rootScrollview.contentOffset.x/rootScrollview.frame.width))]
//        iconImg1.backgroundColor = UIColor(red: 222/255.0, green: 246/255.0, blue: 231/255.0, alpha: 1)
        alertView.addSubview(iconImg1)
        
        let tipLabel1 = UILabel(frame: CGRect(x: 10, y: iconImg1.frame.maxY+8+8, width: alertView.frame.width - 20, height: calculateHeight(tipTextArray[Int(round(rootScrollview.contentOffset.x/rootScrollview.frame.width))], size: 14, width: alertView.frame.width - 16)))
        tipLabel1.numberOfLines = 0
        tipLabel1.textColor = UIColor.darkGray
        tipLabel1.font = UIFont.systemFont(ofSize: 14)
        tipLabel1.textAlignment = .left
        tipLabel1.adjustsFontSizeToFitWidth = true
        tipLabel1.text = tipTextArray[Int(round(rootScrollview.contentOffset.x/rootScrollview.frame.width))]
        alertView.addSubview(tipLabel1)
        
        let cancelBtn = UILabel(frame: CGRect(
            x: 0,
            y: tipLabel1.frame.maxY+10,
            width: alertView.frame.width,
            height: 30))
        cancelBtn.textAlignment = .center
        cancelBtn.layer.backgroundColor = baseColor.cgColor
        cancelBtn.textColor = UIColor.white
        cancelBtn.font = UIFont.systemFont(ofSize: 16)
        cancelBtn.text = "工牌"
        alertView.addSubview(cancelBtn)
//        let cancelBtn = UIButton(frame: CGRect(
//            x: 10,
//            y: tipLabel1.frame.maxY+10,
//            width: alertView.frame.width*0.4,
//            height: 30))
//        cancelBtn.tag = 102
//        cancelBtn.setTitleColor(UIColor.blue, for: .normal)
//        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        cancelBtn.setTitle("取消", for: .normal)
//        cancelBtn.addTarget(self, action: #selector(alertViewHide(_:)), for: .touchUpInside)
//        alertView.addSubview(cancelBtn)
        
        
        alertView.frame.size.height = cancelBtn.frame.maxY
        alertView.center.y = bgView.center.y
        
    }
    
    // MARK: - 分享视图取消事件
    func alertViewHide(_ alertView:UIButton) {
        if alertView.tag == 102 {
            alertView.superview!.superview!.removeFromSuperview()
        }else{
            alertView.removeFromSuperview()
        }
    }
    
    // MARK: - 点击 点
    func dotBtnClick(_ dotBtn:UIButton) {
        
        if dotBtn == rightDotImg && rightDotImg.isSelected == false {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud?.mode = .text
            hud?.removeFromSuperViewOnHide = true
            hud?.labelText = "请 确认 认证类型"
            hud?.hide(true, afterDelay: 1)
            return
        }else if dotBtn == rightDotImg {
            return
        }
        
        if leftDotImg.isSelected {
            return
        }
        
        if round(rootScrollview.contentOffset.x/rootScrollview.frame.width) <= 0 {
            leftBtn.isEnabled = false
            rightBtn.isEnabled = true
        }else if round(rootScrollview.contentOffset.x/rootScrollview.frame.width)  >= CGFloat(authImgArray.count)-1 {
            rightBtn.isEnabled = false
            leftBtn.isEnabled = true
        }
        rootScrollview.isScrollEnabled = true
        
        sureBtn.isHidden = false
        
        
        instructionBgImg.isHidden = false
        instructionBgImg_2.isHidden = true
        
        leftDotImg.isSelected = true
        rightDotImg.isSelected = false
    }
    
    // MARK: - 点击拍摄照片按钮
    func cameraBtnClick() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        }else{
            print("无法打开相机")
        }
    }
    
    // MARK: - 点击相册按钮
    func albumBtnClick() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    // MARK: - 认证有啥好处 点击事件
    func advantageBtnClick() {
        
        let bgView = UIButton(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        bgView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        bgView.tag = 101
        bgView.addTarget(self, action: #selector(alertViewHide(_:)), for: .touchUpInside)
        UIApplication.shared.keyWindow!.addSubview(bgView)
        
//        let alertImg = UIButton(frame: CGRect(x: 0, y: screenSize.height*0.15, width: screenSize.width, height: screenSize.height*0.7))
//        alertImg.setImage(#imageLiteral(resourceName: "ic_企业认证_认证好处"), for: .normal)
//        alertImg.imageView?.contentMode = UIViewContentMode(rawValue: UIViewContentMode.scaleAspectFit.rawValue|UIViewContentMode.scaleAspectFill.rawValue)!
//        alertImg.imageView?.clipsToBounds = true
//        bgView.addSubview(alertImg)
        
        let alertImg = UIImageView(frame: CGRect(x: 0, y: screenSize.height*0.15, width: screenSize.width, height: screenSize.height*0.7))
        alertImg.isUserInteractionEnabled = true
        alertImg.image = #imageLiteral(resourceName: "ic_企业认证_认证好处")
//        alertImg.contentMode = UIViewContentMode(rawValue: UIViewContentMode.scaleAspectFit.rawValue|UIViewContentMode.scaleAspectFill.rawValue)!
        alertImg.contentMode = UIViewContentMode.scaleAspectFit
        alertImg.clipsToBounds = true
        bgView.addSubview(alertImg)
        
        let lookBtn = UIButton(frame: CGRect(x: 0, y: alertImg.frame.size.height*0.9, width: calculateWidth("我知道了", size: 15, height: 30)+30, height: alertImg.frame.size.height*0.05))
        lookBtn.tag = 102
        lookBtn.layer.cornerRadius = alertImg.frame.size.height*0.025
        lookBtn.backgroundColor = baseColor
        lookBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        lookBtn.setTitleColor(UIColor.white, for: .normal)
        lookBtn.setTitle("我知道了", for: .normal)
        lookBtn.frame.origin.x = (alertImg.frame.width-lookBtn.frame.width)/2.0
        lookBtn.addTarget(self, action: #selector(alertViewHide(_:)), for: .touchUpInside)
        alertImg.addSubview(lookBtn)
        
    }

    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        tagLabel.text = authImgTagArray[Int(round(rootScrollview.contentOffset.x/rootScrollview.frame.width))]
        tagLabel.sizeToFit()
        tagLabel.center.x = (tagLabel.superview?.frame.width ?? 0)!/2.0
        
        if round(rootScrollview.contentOffset.x/rootScrollview.frame.width) <= 0 {
            leftBtn.isEnabled = false
            rightBtn.isEnabled = true
        }else if round(rootScrollview.contentOffset.x/rootScrollview.frame.width)  >= CGFloat(authImgArray.count)-1 {
            rightBtn.isEnabled = false
            leftBtn.isEnabled = true
        }
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let type = info[UIImagePickerControllerMediaType] as! String
        if type != "public.image" {
            return
        }
        
        //裁剪后图片
        selectedImg = (info[UIImagePickerControllerEditedImage] as! UIImage)
        
        //headerImg.image = selectedImage
        
        let sureController = FTMiCompanyAuthSureViewController()
        sureController.authImage = selectedImg
        sureController.authType = companyAuthType(rawValue: Int(round(rootScrollview.contentOffset.x/rootScrollview.frame.width)))!

        self.navigationController?.pushViewController(sureController, animated: true)
        
        picker.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
