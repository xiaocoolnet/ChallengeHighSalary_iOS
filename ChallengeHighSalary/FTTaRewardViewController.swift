//
//  FTTaRewardViewController.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2017/1/17.
//  Copyright © 2017年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaRewardViewController: UIViewController, UITextFieldDelegate {

    let moneyTF = UITextField()// 单个红包金额
    let countTF = UITextField()// 红包个数
    let validityTF = UITextField()// 红包有效期
    
    let redEnvelopeBtn1 = UIButton()
    let redEnvelopeBtn2 = UIButton()
    let redEnvelopeBtn3 = UIButton()
    
    var redTypeArray = ["职位红包","面试红包","就职红包"]
    var selectedArray = [true,false,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setSubviews()
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.title = "悬赏招聘"
        
        let rootScrollView = TPKeyboardAvoidingScrollView(frame: CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64))
        rootScrollView.backgroundColor = UIColor(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1)
        self.view.addSubview(rootScrollView)
        
        // MARK: 单个红包金额
        let moneyBgView = UIView(frame: CGRect(x: 20, y: 20, width: rootScrollView.frame.width-40, height: 44))
        moneyBgView.backgroundColor = UIColor.white
        moneyBgView.layer.cornerRadius = 6
        rootScrollView.addSubview(moneyBgView)
        
        let moneyTagLab = UILabel()
        moneyTagLab.font = UIFont.systemFont(ofSize: 16)
        moneyTagLab.text = "单个红包金额"
        moneyTagLab.sizeToFit()
        moneyTagLab.frame.origin = CGPoint(x: 8, y: 22-moneyTagLab.frame.height/2.0)
        moneyBgView.addSubview(moneyTagLab)
        
        moneyTF.frame = CGRect(
            x: moneyTagLab.frame.maxX,
            y: 0,
            width: moneyBgView.frame.width-8-calculateWidth("元", size: 16, height: 44)-8-moneyTagLab.frame.maxX,
            height: 44)
        moneyTF.delegate = self
        moneyTF.keyboardType = .numberPad
        moneyTF.placeholder = "填写金额"
        moneyTF.font = UIFont.systemFont(ofSize: 16)
        moneyTF.textAlignment = .right
        moneyTF.text = redMoney == 0 ? "":String(redMoney)
        moneyBgView.addSubview(moneyTF)
        
        let moneyUnitLab = UILabel(frame: CGRect(x: moneyTF.frame.maxX+8, y: 0, width: calculateWidth("元", size: 16, height: 44), height: 44))
        moneyUnitLab.font = UIFont.systemFont(ofSize: 16)
        moneyUnitLab.text = "元"
        moneyBgView.addSubview(moneyUnitLab)
        
        // MARK: 红包个数
        let countBgView = UIView(frame: CGRect(x: moneyBgView.frame.minX, y: moneyBgView.frame.maxY+10, width: moneyBgView.frame.width, height: moneyBgView.frame.height))
        countBgView.backgroundColor = UIColor.white
        countBgView.layer.cornerRadius = 6
        rootScrollView.addSubview(countBgView)
        
        let countTagLab = UILabel()
        countTagLab.font = UIFont.systemFont(ofSize: 16)
        countTagLab.text = "红包个数"
        countTagLab.sizeToFit()
        countTagLab.frame.origin = CGPoint(x: 8, y: 22-countTagLab.frame.height/2.0)
        countBgView.addSubview(countTagLab)
        
        countTF.frame = CGRect(
            x: countTagLab.frame.maxX,
            y: 0,
            width: countBgView.frame.width-8-calculateWidth("元", size: 16, height: 44)-8-countTagLab.frame.maxX,
            height: 44)
        countTF.delegate = self
        countTF.keyboardType = .numberPad
        countTF.placeholder = "填写个数"
        countTF.font = UIFont.systemFont(ofSize: 16)
        countTF.textAlignment = .right
        countTF.text = redCount == 0 ? "":String(redCount)
        countBgView.addSubview(countTF)
        
        let countUnitLab = UILabel(frame: CGRect(x: countTF.frame.maxX+8, y: 0, width: calculateWidth("个", size: 16, height: 44), height: 44))
        countUnitLab.font = UIFont.systemFont(ofSize: 16)
        countUnitLab.text = "个"
        countBgView.addSubview(countUnitLab)
        
        // MARK: 红包有效期
        let validityBgView = UIView(frame: CGRect(x: moneyBgView.frame.minX, y: countBgView.frame.maxY+10, width: moneyBgView.frame.width, height: moneyBgView.frame.height))
        validityBgView.backgroundColor = UIColor.white
        validityBgView.layer.cornerRadius = 6
        rootScrollView.addSubview(validityBgView)
        
        let validityTagLab = UILabel()
        validityTagLab.font = UIFont.systemFont(ofSize: 16)
        validityTagLab.text = "红包有效期"
        validityTagLab.sizeToFit()
        validityTagLab.frame.origin = CGPoint(x: 8, y: 22-validityTagLab.frame.height/2.0)
        validityBgView.addSubview(validityTagLab)
        
        validityTF.frame = CGRect(
            x: validityTagLab.frame.maxX,
            y: 0,
            width: validityBgView.frame.width-8-calculateWidth("元", size: 16, height: 44)-8-validityTagLab.frame.maxX,
            height: 44)
        validityTF.delegate = self
        validityTF.keyboardType = .numberPad
        validityTF.placeholder = "填写有效期"
        validityTF.font = UIFont.systemFont(ofSize: 16)
        validityTF.textAlignment = .right
        validityTF.text = redValidity == 0 ? "":String(redValidity)

        validityBgView.addSubview(validityTF)
        
        let validityUnitLab = UILabel(frame: CGRect(x: validityTF.frame.maxX+8, y: 0, width: calculateWidth("天", size: 16, height: 44), height: 44))
        validityUnitLab.font = UIFont.systemFont(ofSize: 16)
        validityUnitLab.text = "天"
        validityBgView.addSubview(validityUnitLab)
        
        // MARK: 红包类型
        let typeBgView = UIView(frame: CGRect(x: moneyBgView.frame.minX, y: validityBgView.frame.maxY+10, width: moneyBgView.frame.width, height: moneyBgView.frame.height*4))
        typeBgView.backgroundColor = UIColor.white
        typeBgView.layer.cornerRadius = 6
        rootScrollView.addSubview(typeBgView)
        
        let typeTagLab = UILabel(frame: CGRect(x: 8, y: 0, width: typeBgView.frame.width-16, height: 44))
        typeTagLab.textAlignment = .left
        typeTagLab.font = UIFont.systemFont(ofSize: 16)
        typeTagLab.text = "红包类型"
        typeBgView.addSubview(typeTagLab)
        
        let line1 = UIView(frame: CGRect(x: 0, y: typeTagLab.frame.maxY, width: typeBgView.frame.width, height: 1/UIScreen.main.scale))
        line1.backgroundColor = UIColor(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1)
        typeBgView.addSubview(line1)
        
        // 职位红包
        let redEnvelopeTag1 = UILabel()
        redEnvelopeTag1.font = UIFont.systemFont(ofSize: 16)
        redEnvelopeTag1.text = redTypeArray[0]
        redEnvelopeTag1.sizeToFit()
        redEnvelopeTag1.frame.origin = CGPoint(x: 8, y: 44+22-moneyTagLab.frame.height/2.0)
        typeBgView.addSubview(redEnvelopeTag1)
        
        redEnvelopeBtn1.frame = CGRect(x: typeBgView.frame.width-8-20, y: 44+12, width: 20, height: 20)
        redEnvelopeBtn1.setImage(#imageLiteral(resourceName: "ic_点_nor"), for: .normal)
        redEnvelopeBtn1.setImage(#imageLiteral(resourceName: "ic_点_sel"), for: .selected)
        redEnvelopeBtn1.addTarget(self, action: #selector(redEnvelopeBtnClick(redEnvelopeBtn:)), for: .touchUpInside)
        typeBgView.addSubview(redEnvelopeBtn1)
        
        drawLine(typeBgView, color: UIColor(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1), fromPoint: CGPoint(x: 0, y: 88), toPoint: CGPoint(x: typeBgView.frame.maxX, y: 88), lineWidth: 1, pattern: [2,2])
        
        // 面试红包
        let redEnvelopeTag2 = UILabel()
        redEnvelopeTag2.font = UIFont.systemFont(ofSize: 16)
        redEnvelopeTag2.text = redTypeArray[1]
        redEnvelopeTag2.sizeToFit()
        redEnvelopeTag2.frame.origin = CGPoint(x: 8, y: 88+22-moneyTagLab.frame.height/2.0)
        typeBgView.addSubview(redEnvelopeTag2)
        
        redEnvelopeBtn2.frame = CGRect(x: typeBgView.frame.width-8-20, y: 88+12, width: 20, height: 20)
        redEnvelopeBtn2.setImage(#imageLiteral(resourceName: "ic_点_nor"), for: .normal)
        redEnvelopeBtn2.setImage(#imageLiteral(resourceName: "ic_点_sel"), for: .selected)
        redEnvelopeBtn2.addTarget(self, action: #selector(redEnvelopeBtnClick(redEnvelopeBtn:)), for: .touchUpInside)
        typeBgView.addSubview(redEnvelopeBtn2)
        
        drawLine(typeBgView, color: UIColor(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1), fromPoint: CGPoint(x: 0, y: 132), toPoint: CGPoint(x: typeBgView.frame.maxX, y: 132), lineWidth: 1, pattern: [2,2])
        
        // 就职红包
        let redEnvelopeTag3 = UILabel()
        redEnvelopeTag3.font = UIFont.systemFont(ofSize: 16)
        redEnvelopeTag3.text = redTypeArray[2]
        redEnvelopeTag3.sizeToFit()
        redEnvelopeTag3.frame.origin = CGPoint(x: 8, y: 132+22-moneyTagLab.frame.height/2.0)
        typeBgView.addSubview(redEnvelopeTag3)
        
        redEnvelopeBtn3.frame = CGRect(x: typeBgView.frame.width-8-20, y: 132+12, width: 20, height: 20)
        redEnvelopeBtn3.setImage(#imageLiteral(resourceName: "ic_点_nor"), for: .normal)
        redEnvelopeBtn3.setImage(#imageLiteral(resourceName: "ic_点_sel"), for: .selected)
        redEnvelopeBtn3.addTarget(self, action: #selector(redEnvelopeBtnClick(redEnvelopeBtn:)), for: .touchUpInside)
        typeBgView.addSubview(redEnvelopeBtn3)
        
        let sureBtn = UIButton(frame: CGRect(x: moneyBgView.frame.minX, y: typeBgView.frame.maxY+20, width: moneyBgView.frame.width, height: moneyBgView.frame.height))
        sureBtn.backgroundColor = baseColor
        sureBtn.layer.cornerRadius = 6
        sureBtn.setTitleColor(UIColor.white, for: .normal)
        sureBtn.setTitle("确 认", for: .normal)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        rootScrollView.addSubview(sureBtn)
        
        rootScrollView.contentSize = CGSize(width: 0, height: sureBtn.frame.maxY+20)
        
        for (i,subRedType) in redTypeArray.enumerated() {
            if redType == subRedType {
                self.selectedArray = [false,false,false]

                self.selectedArray[i] = true
                break
            }
        }
        
        redEnvelopeBtn1.isSelected = self.selectedArray[0]
        redEnvelopeBtn2.isSelected = self.selectedArray[1]
        redEnvelopeBtn3.isSelected = self.selectedArray[2]
        
    }
    
    func redEnvelopeBtnClick(redEnvelopeBtn:UIButton) {
        self.selectedArray = [false,false,false]
        
        if redEnvelopeBtn == redEnvelopeBtn1 {
            self.selectedArray[0] = true
        }else if redEnvelopeBtn == redEnvelopeBtn2 {
            self.selectedArray[1] = true
        }else if redEnvelopeBtn == redEnvelopeBtn3 {
            self.selectedArray[2] = true
        }
        
        redEnvelopeBtn1.isSelected = self.selectedArray[0]
        redEnvelopeBtn2.isSelected = self.selectedArray[1]
        redEnvelopeBtn3.isSelected = self.selectedArray[2]
        
    }
    
    func sureBtnClick() {
        
        if (moneyTF.text?.isEmpty)! {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.removeFromSuperViewOnHide = true
            hud.mode = .text
            hud.label.text = "请填写红包金额"
            hud.hide(animated: true, afterDelay: 1)
            return
        }else if (countTF.text?.isEmpty)! {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.removeFromSuperViewOnHide = true
            hud.mode = .text
            hud.label.text = "请填写红包个数"
            hud.hide(animated: true, afterDelay: 1)
            return
        }else if (validityTF.text?.isEmpty)! {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.removeFromSuperViewOnHide = true
            hud.mode = .text
            hud.label.text = "请填写红包有效期"
            hud.hide(animated: true, afterDelay: 1)
            return
        }
        
        
        print("")
        print("单个红包金额：\(moneyTF.text!) 元")
        print("红包个数：\(countTF.text!) 个")
        print("红包有效期：\(validityTF.text!) 天")
        
        let typeArray = ["职位红包","面试红包","就职红包"]
        
        if moneyTF.text == "0" || countTF.text == "0" {
            redCount = 0
            redMoney = 0
            redValidity = 0
            redType = ""
            
            var FTPublishJobSelectedNameArray = UserDefaults.standard.array(forKey: FTPublishJobSelectedNameArray_key) as! [Array<String>]
            FTPublishJobSelectedNameArray[4][0] = "悬赏招聘"
            UserDefaults.standard.setValue(FTPublishJobSelectedNameArray, forKey: FTPublishJobSelectedNameArray_key)
            
            _ = self.navigationController?.popViewController(animated: true)
        }else{
            
            for (i,selected) in self.selectedArray.enumerated() {
                if selected {
                    
                    redCount = NSString(string: countTF.text!).integerValue
                    redMoney = NSString(string: moneyTF.text!).integerValue
                    redValidity = NSString(string: validityTF.text!).integerValue
                    redType = typeArray[i]
                    
                    var FTPublishJobSelectedNameArray = UserDefaults.standard.array(forKey: FTPublishJobSelectedNameArray_key) as! [Array<String>]
                    FTPublishJobSelectedNameArray[4][0] = "\(redType) \(redMoney)元*\(redCount)个"
                    UserDefaults.standard.setValue(FTPublishJobSelectedNameArray, forKey: FTPublishJobSelectedNameArray_key)
                    
                    _ = self.navigationController?.popViewController(animated: true)                    
                    
                    print("红包类型：\(typeArray[i])")
                    break
                }
            }
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text?.characters.count)! >= 3 && string != "" {
            return false
        }
        return self.validateNumber(string)
    }
    
    func validateNumber(_ validateNumber:String) -> Bool {
        if validateNumber.characters.count == 0 {
            return true
        }
        let mobile = "^[0-9]$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluate(with: validateNumber) == true {
            return true
        }else
        {
            return false
        }
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
