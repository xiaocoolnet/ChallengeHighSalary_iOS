//
//  FTMeEvaluateViewController.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2017/1/5.
//  Copyright © 2017年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMeEvaluateViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate {
    
    let rootScrollView = TPKeyboardAvoidingScrollView()
    let textArr = ["综合素质","专业技能","求职意愿"]
    let arr = NSMutableArray()
    let textView = UITextView()
    let placeholder  = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setNavigationBar()
        setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        self.title = "面试详情"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
    }
    
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        //         scrollView
        
        rootScrollView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-20-44)
        rootScrollView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootScrollView.delegate = self
        rootScrollView.showsVerticalScrollIndicator = false
        rootScrollView.contentSize = CGSize(width:screenSize.width, height:screenSize.height)
        self.view.addSubview(rootScrollView)
        
        addHeaderView()
        addTextField()
        addButton()
    }
    
    func addHeaderView(){
        let view = UIView.init(frame: CGRect(x: 10, y: 10, width: screenSize.width - 20, height: 150))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        self.rootScrollView.addSubview(view)
        
        let imgView = UIImageView.init(frame: CGRect(x: 10, y: 7, width: 15, height: 15))
        imgView.image = UIImage.init(named: "ic-geigongsidepingjia")
        view.addSubview(imgView)
        
        let lable = UILabel.init(frame: CGRect(x: 35, y: 0, width: 150, height: 29))
        lable.text = "给面试者评价"
        lable.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(lable)
        
        let line = UILabel.init(frame: CGRect(x: 10, y: 29, width: view.frame.size.width - 20, height: 1))
        line.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        view.addSubview(line)
        
        
        for i in 0...2 {
            let evaView = EvaluateView.init(frame: CGRect(x: 0, y: 30 + CGFloat(40*i), width: screenSize.width - 20, height: 40))
            evaView.nameLab.text = textArr[i]
            view.addSubview(evaView)
            arr.add(evaView)
        }
        
    }
    
    func addTextField(){
        self.textView.frame = CGRect(x: 10, y: 170, width: screenSize.width - 20, height: 120)
        textView.backgroundColor = UIColor.white
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.delegate = self;
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.returnKeyType = .done
        textView.layer.cornerRadius = 5
        rootScrollView.addSubview(textView)
        
        placeholder.frame = CGRect(x: 15, y: 175, width: screenSize.width - 20, height: 20)
        placeholder.text = "您还有什么要说的"
        placeholder.font = UIFont.systemFont(ofSize: 15)
        placeholder.textColor = UIColor.lightGray
        placeholder.isUserInteractionEnabled = true
        rootScrollView.addSubview(placeholder)
        
    }
    
    func addButton(){
        let backBtn = UIButton.init(frame: CGRect(x: 10, y: 310, width: 140, height: 30))
        backBtn.setTitle("不评论,返回消息", for: .normal)
        backBtn.setTitleColor(UIColor.orange, for: .normal)
        backBtn.layer.cornerRadius = 14
        backBtn.layer.borderWidth = 1
        backBtn.layer.borderColor = UIColor.orange.cgColor
        rootScrollView.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(popViewcontroller), for: .touchUpInside)
        
        let sureBtn = UIButton.init(frame: CGRect(x: screenSize.width - 150, y: 310, width: 140, height: 30))
        sureBtn.backgroundColor = baseColor
        sureBtn.setTitle("提交评论", for: .normal)
        sureBtn.setTitleColor(UIColor.white, for: .normal)
        sureBtn.layer.cornerRadius = 14
        rootScrollView.addSubview(sureBtn)
        sureBtn.addTarget(self, action: #selector(clickSureButton), for: .touchUpInside)
    }
    
    func clickSureButton(){
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        if (arr[0] as! EvaluateView).num == 0 {
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请对面试者 综合素质 进行评价"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }
        if (arr[1] as! EvaluateView).num == 0 {
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请对面试者 专业技能 进行评价"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }
        if (arr[2] as! EvaluateView).num == 0 {
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请对面试者 求职意愿 进行评价"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }
        if textView.text!.isEmpty {
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请填写评论内容"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }
        PublicNetUtil().addComments(
        companyid:"",evaluate_id:"",start:"",content:"",choose:"",invite_title:"",useful_num:""){(success, response) in
            if success {
                
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "面试评价成功"
                checkCodeHud.hide(animated: true, afterDelay: 1)
                _ = self.navigationController?.popViewController(animated: true)
            }else{
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "面试评价失败"
                checkCodeHud.hide(animated: true, afterDelay: 1)
                
            }
        }
        
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        placeholder.isHidden = true
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        
        self.view.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        textView.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
