//
//  FTTaRewardPayViewController.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2017/1/17.
//  Copyright © 2017年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaRewardPayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {
    
    var count = 0
    var money = 0
    var red_type = ""
    var validity = 0
    
    let rootTableView = UITableView()
    
    var nameArray = [[String]]()
    let imageArray = [[nil],[#imageLiteral(resourceName: "ic_支付宝"),#imageLiteral(resourceName: "ic_微信")]]
    var selectedArray = [[true],[true,false]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        nameArray = [["\(count)个*\(money)元 \(count*money)元"],["支付宝支付","微信支付"]]
        self.setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        //        self.rootTableView.reloadData()
        self.setHeaderView()
        self.loadData()
    }
    
    // MARK: 加载数据
    func loadData() {
        
        
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        self.title = "支付确认"
        
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64-44)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.register(FTTaPayTableViewCell.self, forCellReuseIdentifier: "FTTaPayCell")
        
        rootTableView.rowHeight = 44
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.view.addSubview(rootTableView)
        
        setHeaderView()
        
        let payBtn = UIButton(frame: CGRect(x: 0, y: screenSize.height-44, width: screenSize.width, height: 44))
        payBtn.backgroundColor = baseColor
        payBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        payBtn.setTitleColor(UIColor.white, for: UIControlState())
        payBtn.setTitle("立即支付", for: UIControlState())
        payBtn.addTarget(self, action: #selector(payBtnClick), for: .touchUpInside)
        self.view.addSubview(payBtn)
    }
    
    // MARK: - 点击立即支付按钮
    func payBtnClick() {
        print("点击立即支付按钮")
        
        for (i,selectedArr) in selectedArray.enumerated() {
            for (j,selected) in selectedArr.enumerated() {
                if selected {
                    print(nameArray[i][j])
                }
            }
        }
        
        if selectedArray[1][0] == true {
            doAlipayPay()
        }
    }
    
    // 支付宝支付
    func doAlipayPay() {
        
        //将商品信息赋予AlixPayOrder的成员变量
        let order = Order()
        
        // NOTE: app_id设置
        order.app_id = alipay_app_id
        
        // NOTE: 支付接口名称
        order.method = "alipay.trade.app.pay"
        
        // NOTE: 参数编码格式
        order.charset = "utf-8"
        
        order.notify_url = alipay_notify_url
        
        // NOTE: 当前时间点
        let formatter = DateFormatter()
        formatter.date(from: "yyyy-MM-dd HH:mm:ss")
        order.timestamp = formatter.string(from: Date())
        
        // NOTE: 支付版本
        order.version = "1.0"
        
        // NOTE: sign_type设置
        order.sign_type = "RSA"
        
        // NOTE: 商品数据
        order.biz_content = BizContent()
        order.biz_content.body = "\(money)元 * \(count)个"
        order.biz_content.subject = red_type
        order.biz_content.out_trade_no = self.generateTradeNO()//订单ID（由商家自行制定）
        order.biz_content.timeout_express = "30m" //超时时间设置
        order.biz_content.total_amount = String(format: "%.2f", count*money) //商品价格
        
        
        //将商品信息拼接成字符串
        let orderInfo = order.orderInfoEncoded(false)
        let orderInfoEncoded = order.orderInfoEncoded(true)
        print("orderSpec = \(orderInfo)")
        
        // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
        //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
        
        let privateKey = alipay_privateKey
        let signer = RSADataSigner(privateKey: privateKey)
        let signedString = signer?.sign(orderInfo, withRSA2: false)
        
        // NOTE: 如果加签成功，则继续执行支付
        if (signedString != nil) {
            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
            let appScheme = "ChallengeHighSalary"
            
            // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
            let orderString = "\(orderInfoEncoded!)&sign=\(signedString!)"
//            ( [NSString stringWithFormat:@"%@&sign=%@", orderInfoEncoded, signedString];
            
            
            // NOTE: 调用支付结果开始支付
            AlipaySDK.defaultService().payOrder(orderString, fromScheme: appScheme, callback: { (resultDic) in
                print("reslut = \(resultDic)")
            })

        }
    }
    
    
    func generateTradeNO() -> String
    {
        let kNumber = 15
        
        let sourceStr = NSString(string: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        var resultStr = ""
        arc4random()
        for _ in 0 ..< kNumber {
            
            let index = Int(arc4random()) % sourceStr.length
            
            let oneStr = sourceStr.substring(with: NSMakeRange(index, 1))
            resultStr.append(oneStr)
            
        }

        return resultStr
    }
    
    // MARK:- 设置tableview 头视图
    func setHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 0))
        headerView.backgroundColor = UIColor.white
        
        let headerImg = UIImageView(frame: CGRect(x: 10, y: 0, width: 50, height: 50))
        headerImg.image = UIImage(named: "")
        headerImg.backgroundColor = baseColor
        headerImg.layer.cornerRadius = 25
        headerImg.clipsToBounds = true
        headerView.addSubview(headerImg)
        
        let nameLab = UILabel(frame: CGRect(x: headerImg.frame.maxX+10, y: 10, width: screenSize.width-(headerImg.frame.maxX+10)-10, height: UIFont.systemFont(ofSize: 16).lineHeight))
        nameLab.font = UIFont.systemFont(ofSize: 16)
        nameLab.textColor = UIColor.black
        nameLab.text = "北京校酷网络科技有限公司"
        headerView.addSubview(nameLab)
        
        let jobLab = UILabel(frame: CGRect(x: nameLab.frame.minX, y: nameLab.frame.maxY+8, width: screenSize.width-(nameLab.frame.minX)-10, height: UIFont.systemFont(ofSize: 14).lineHeight))
        jobLab.font = UIFont.systemFont(ofSize: 14)
        jobLab.textColor = UIColor.lightGray
        jobLab.text = "发放红包吸引更多人才"
        
        headerView.addSubview(jobLab)
        
        headerView.frame.size.height = jobLab.frame.maxY+10
        
        headerImg.center.y = headerView.center.y
        
        self.rootTableView.tableHeaderView = headerView
    }
    
    // MARK:- tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FTTaPayCell") as! FTTaPayTableViewCell
        
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
            
            let str = red_type+"："+nameArray[indexPath.section][indexPath.row]
            
            let nsStr = NSString(string: str)
            let attStr = NSMutableAttributedString(string: str)
            
            if str.contains(" ") {
                
                attStr.addAttributes([NSForegroundColorAttributeName: UIColor.orange], range: NSMakeRange(nsStr.range(of: " ").location, nsStr.length-nsStr.range(of: " ").location))
            }
            
            cell.setInfo(with: imageArray[indexPath.section][indexPath.row], text: attStr, selectedDot: selectedArray[indexPath.section][indexPath.row])
        }else{
            
            let str = nameArray[indexPath.section][indexPath.row]
            
            cell.setInfo(with: imageArray[indexPath.section][indexPath.row], text: NSMutableAttributedString(string: str), selectedDot: selectedArray[indexPath.section][indexPath.row])
        }
        
        return cell
    }
    
    // MARK:- tableview delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 25))
        let headerLab = UILabel(frame: CGRect(x: 20, y: 0, width: screenSize.width-40, height: 25))
        headerLab.font = UIFont.systemFont(ofSize: 14)
        headerLab.textColor = UIColor.gray
        
        
        if section == 0 {
            headerLab.text = "支付详情(有效期：\(validity)天)"
        }else{
            headerLab.text = "支付方式"
        }
        
        headerView.addSubview(headerLab)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            self.selectedArray[indexPath.section] = [false,false]
            self.selectedArray[indexPath.section][indexPath.row] = true
        }
        
        self.rootTableView.reloadData()
        
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
