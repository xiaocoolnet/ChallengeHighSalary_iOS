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
    var money:Double = 0
    var red_type = ""
    var validity = 0
    
    let rootTableView = UITableView()
    
    var nameArray = [[String]]()
    let imageArray = [[nil],[#imageLiteral(resourceName: "ic_支付宝"),#imageLiteral(resourceName: "ic_微信")]]
    var selectedArray = [[true],[true,false]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        nameArray = [["\(count)个*\(money)元 \(Double(count)*money)元"],["支付宝支付","微信支付"]]
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
            doAlipayPay_2()
        }else{
            doWXPay()
        }
    }
    
    // 支付宝支付
    func doAlipayPay_2()
    {
        //重要说明
        //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
        //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
        //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
        /*============================================================================*/
        /*=======================需要填写商户app申请的===================================*/
        /*============================================================================*/
        let appID = alipay_app_id
        
        // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
        // 如果商户两个都设置了，优先使用 rsa2PrivateKey
        // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
        // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
        // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
        let rsa2PrivateKey = alipay_privateKey
        /*============================================================================*/
        /*============================================================================*/
        /*============================================================================*/
        
        //partner和seller获取失败,提示
        if (appID.characters.count == 0 ||
            (rsa2PrivateKey.characters.count == 0))
        {
            print("缺少appId或者私钥。")
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//            message:@"缺少appId或者私钥。"
//            delegate:self
//            cancelButtonTitle:@"确定"
//            otherButtonTitles:nil];
//            [alert show];
            return;
        }
        
        /*
         *生成订单信息及签名
         */
        //将商品信息赋予AlixPayOrder的成员变量
        let order = Order()
        
        // NOTE: app_id设置
        order.app_id = appID
        
        // NOTE: 支付接口名称
        order.method = "alipay.trade.app.pay"
        
        // NOTE: 参数编码格式
        order.charset = "utf-8"
        
        // NOTE: 当前时间点
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        order.timestamp = formatter.string(from: Date())
        
        // NOTE: 支付版本
        order.version = "1.0"
        
        // NOTE: sign_type 根据商户设置的私钥来决定
        order.sign_type = "RSA2"
        
        // NOTE: 商品数据
        order.biz_content = BizContent()
        order.biz_content.body = "\(red_type)-\(money)元 * \(count)个"
        order.biz_content.subject = "\(red_type)-\(money)元 * \(count)个"
        order.biz_content.out_trade_no = self.generateTradeNO()//订单ID（由商家自行制定）
        order.biz_content.timeout_express = "30m" //超时时间设置
        let total_amount:Double = Double(count) * money
        order.biz_content.total_amount = String(format: "%.2f", total_amount) //商品价格
        
        //将商品信息拼接成字符串
        let orderInfo = order.orderInfoEncoded(false)
        let orderInfoEncoded = order.orderInfoEncoded(true)
        print("orderSpec = \(orderInfo)")
        
        // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
        //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
        
        let signer = RSADataSigner(privateKey: rsa2PrivateKey)
        let signedString = signer?.sign(orderInfo, withRSA2: true)
        
        // NOTE: 如果加签成功，则继续执行支付
        if (signedString != nil) {
            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
            let appScheme = "alipay_nzrc_tzgx"
            
            // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
            let orderString = "\(orderInfoEncoded!)&sign=\(signedString!)";
            
            // NOTE: 调用支付结果开始支付
            AlipaySDK.defaultService().payOrder(orderString, fromScheme: appScheme, callback: { (resultDic) in
                
                print("reslut = \(resultDic)")
                if resultDic != nil {
                    let Alipayjson = resultDic! as NSDictionary
                    
                    let resultStatus = Alipayjson.value(forKey: "resultStatus") as! String
                    if resultStatus == "9000"{
                        print("OK")
                    }else if resultStatus == "8000" {
                        print("正在处理中")
                    }else if resultStatus == "4000" {
                        print("订单支付失败");
                    }else if resultStatus == "6001" {
                        print("用户中途取消")
                    }else if resultStatus == "6002" {
                        print("网络连接出错")
                    }
                }
                
            })

        }
    
    }
    
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
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        order.timestamp = formatter.string(from: Date())
        
        // NOTE: 支付版本
        order.version = "1.0"
        
        // NOTE: sign_type设置
        order.sign_type = "RSA2"
        
        // NOTE: 商品数据
        order.biz_content = BizContent()
        order.biz_content.body = "\(money)元 * \(count)个"
        order.biz_content.subject = red_type
        order.biz_content.out_trade_no = self.generateTradeNO()//订单ID（由商家自行制定）
        order.biz_content.timeout_express = "30m" //超时时间设置
        order.biz_content.total_amount = String(format: "%.2f", Double(count)*money) //商品价格
        
        
        //将商品信息拼接成字符串
        let orderInfo = order.orderInfoEncoded(false)
        let orderInfoEncoded = order.orderInfoEncoded(true)
        print("orderSpec = \(orderInfo)")
        
        // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
        //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
        
        let privateKey = alipay_privateKey
        let signer = RSADataSigner(privateKey: privateKey)
        let signedString = signer?.sign(orderInfo, withRSA2: true)
        
        // NOTE: 如果加签成功，则继续执行支付
        if (signedString != nil) {
            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
            let appScheme = "alipay_nzrc_tzgx"
            
            // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
            let orderString = "\(orderInfoEncoded!)&sign=\(signedString!)"
//            ( [NSString stringWithFormat:@"%@&sign=%@", orderInfoEncoded, signedString];
            
            
            // NOTE: 调用支付结果开始支付
            AlipaySDK.defaultService().payOrder(orderString, fromScheme: appScheme, callback: { (resultDic) in
                
                print("reslut = \(resultDic)")
                if resultDic != nil {
                    let Alipayjson = resultDic! as NSDictionary

                    let resultStatus = Alipayjson.value(forKey: "resultStatus") as! String
                    if resultStatus == "9000"{
                        print("OK")
                    }else if resultStatus == "8000" {
                        print("正在处理中")
                    }else if resultStatus == "4000" {
                        print("订单支付失败");
                    }else if resultStatus == "6001" {
                        print("用户中途取消")
                    }else if resultStatus == "6002" {
                        print("网络连接出错")
                    }
                }
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
    
    // 微信支付
    func doWXPay() {
        //微信支付
        let aa = FZJWeiXinPayMainController()
//        if body.length == 0 || body.length>30{
//            body = "无效商品名称"
//        }
//        if price == 0{
//            alert("金额不能为0", delegate: self)
//            return
//        }
//        if  self.numForGoodS.characters.count < 1{
//            alert("订单错误", delegate: self)
//            return
//        }
        aa.testStart(String(Double(count)*money*100), orderName: red_type, numOfGoods: self.generateTradeNO())
        //            aa.testStart("1" ,orderName: body as String,numOfGoods:self.numForGoodS);
        
        //            let vc = MyBookDan()
        //            self.navigationController?.pushViewController(vc, animated: true)
        
        //            //随机数
        //            let orderNO   = CommonUtil.genOutTradNo()
        //            //随机数串
        //            let noncestr  = CommonUtil.genNonceStr()
        //            //ip地址
        //            let addressIP = CommonUtil.getIPAddress(true)
        //            //回调地址
        //            let urlStr = "http://www.weixin.qq.com/wxpay/pay.php"
        //
        //            let genTimeStamp = CommonUtil.genTimeStamp() + "51bang"
        //
        //
        //
        //
        //
        //
        //            //声称签名
        //            let signParams = NSMutableDictionary()
        //            signParams.setObject(WXAppId as String, forKey: "appid")
        //            signParams.setObject(WXPartnerId as String, forKey: "mch_id")
        //            signParams.setObject(noncestr as String, forKey: "nonce_str")
        //            signParams.setObject(body as String, forKey: "body")
        //            signParams.setObject(subject as String, forKey: "detail")
        //            signParams.setObject(genTimeStamp as String, forKey: "attach")
        //            signParams.setObject(String(price), forKey: "total_fee")
        //            signParams.setObject(addressIP as String, forKey: "spbill_create_ip")
        //            signParams.setObject(urlStr as String, forKey: "notify_url")
        //            signParams.setObject("APP", forKey: "trade_type")
        ////            signParams.setObject(WXAPIKey as String, forKey: "key")
        //            var str1 = NSString()
        ////            let array = NSMutableArray()
        //            for key in signParams.allKeys {
        //
        //                str1 = str1 as String + String(key as! String) + "=" + String(signParams.valueForKey(key as! String)) + "&"
        //            }
        //            print(str1)
        //
        //
        //            let sign1 = CommonUtil.genSign(signParams as [NSObject : AnyObject])
        //
        ////            print(sign1)
        ////            let sign = CommonUtil.md5(sign1)
        //
        //            let xmlData = XMLHelper()
        //            let url = "https://api.mch.weixin.qq.com/pay/unifiedorder"
        //
        //
        //            let  aa = xmlData.genPackage(NSMutableDictionary(dictionary: signParams))
        //
        //            let data = xmlData.httpSend(url, method: "POST", data: aa)
        //            xmlData.startParse(data)
        //            let dict = xmlData.getDict()
        //            print(dict)
        //
        //            if dict != nil{
        //                let retcode = dict.objectForKey("retcode") as! NSString
        //
        //                if retcode.intValue == 0{
        //                    let stamp = dict.objectForKey("timestamp") as! NSString
        //
        //
        //                    //调起微信支付
        //                    let req = PayReq.init()
        //                    req.partnerId = dict.objectForKey("partnerid") as! String
        //                    req.prepayId = dict.objectForKey("prepayid") as! String
        //                    req.nonceStr = dict.objectForKey("noncestr") as! String
        //                    req.timeStamp = UInt32(stamp as String)!
        //                    req.package = dict.objectForKey("package") as! String
        //                    req.sign = dict.objectForKey("sign") as! String
        //
        //                    WXApi.sendReq(req)
        //                    //日志输出
        //
        //
        //                }else{
        //
        //                }
        //            }else{
        //
        //            }
        //
        //
        //            shopHelper.getWeixinDingdan(WXAppId, mch_id: WXPartnerId, device_info: "", nonce_str: orderNO, sign: sign1, body: body as String, detail:subject as String, attach: "", out_trade_no: genTimeStamp, fee_type: "", total_fee: price, spbill_create_ip: addressIP, time_start: "", time_expire: "", goods_tag: "", notify_url: urlStr, trade_type: "trade_type", limit_pay: "", handle: { (success, response) in
        //
        //
        //
        //            })
        //
        //
        //            let payred = PayReq.init()
        //            payred.partnerId = WXPartnerId as NSString as String
        //            payred.prepayId = "wx201608251458218270593b310274371597"
        //            payred.nonceStr = "0dabdecff46177f8e214fd1facdeb72d"
        //
        
        
        
        //            WXApi.registerApp:"wxd930ea5d5a258f4f" withDescription:"demo 2.0"
        //
        //
        //            self.getWeChatPayWithOrderName("我的订单", price: "1")
        //              self.payForWechat()
        //              let req = payRequsestHandler
        //              req.payForWechat()
    }
    func doWeChatPay() {
        
        let request = PayReq()
        /** 商家向财付通申请的商家id */
        request.partnerId = "10000100"
        /** 预支付订单 */
        request.prepayId = "1101000000140415649af9fc314aa427"
        /** 商家根据财付通文档填写的数据和签名 */
        request.package = "Sign=WXPay"
        /** 随机串，防重发 */
        request.nonceStr = "a462b76e7436e98e0ed6e13c64b4fd1c"
        /** 时间戳，防重发 */
        request.timeStamp = UInt32(NSDate().timeIntervalSince1970 * 1000)
        /** 商家根据财付通文档填写的数据和签名 */
        request.sign = "582282D72DD2B03AD892830965F428CB16E7A256"
        
        WXApi.send(request)
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
