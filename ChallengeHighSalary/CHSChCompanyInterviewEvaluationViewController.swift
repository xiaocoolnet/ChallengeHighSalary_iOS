//
//  CHSChCompanyInterviewEvaluationViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/21.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSChCompanyInterviewEvaluationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-20-44-49-37), style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
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
    
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        
        self.title = "面试评价(2)"
        
        // tableView
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-20-44)
        rootTableView.register(UINib.init(nibName: "CHSChInterviewEvaHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "CHSChInterviewHeaderCell")
        rootTableView.register(UINib.init(nibName: "CHSChInterviewEvaTableViewCell", bundle: nil), forCellReuseIdentifier: "CHSChInterviewCell")
        rootTableView.rowHeight = 140
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
    }
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return 10
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as NSIndexPath).section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CHSChInterviewHeaderCell") as! CHSChInterviewEvaHeaderTableViewCell
            cell.selectionStyle = .none
            rootTableView.rowHeight = 61
            
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CHSChInterviewCell") as! CHSChInterviewEvaTableViewCell
            cell.selectionStyle = .none
            rootTableView.rowHeight = cell.usefulBtn.frame.maxY + 20
            
            return cell
        }
    }
    
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if (indexPath as NSIndexPath).section == 0 {
//            return 61
//        }else{
    
//            let evaTagArray = ["面试官很nice","面试效率高","聊得很开心"]
//            let evaContent = "面试过程：公司人员配置目测完善，希望能获得这份工作"
//            
//            let cityBtnMargin:CGFloat = 10
//            var cityBtnX:CGFloat = cityBtnMargin
//            var cityBtnY:CGFloat = cityBtnMargin
//            var cityBtnWidth:CGFloat = 0
//            let cityBtnHeight:CGFloat = 25
//            
//            for (i,city) in evaTagArray.enumerated() {
//                cityBtnWidth = calculateWidth(city, size: 14, height: cityBtnHeight)+cityBtnMargin*4
//                
//                
//                if i+1 < evaTagArray.count {
//                    
//                    let nextBtnWidth = calculateWidth(evaTagArray[i+1], size: 14, height: cityBtnHeight)+cityBtnMargin*4
//                    
//                    if cityBtnWidth + cityBtnX + cityBtnMargin + nextBtnWidth >= screenSize.width - 20 {
//                        cityBtnX = cityBtnMargin
//                        cityBtnY = cityBtnHeight + cityBtnY + cityBtnMargin
//                    }else{
//                        
//                        cityBtnX = cityBtnWidth + cityBtnX + cityBtnMargin
//                    }
//                }
//            }
//            
//            let evaContentHeight = calculateHeight(evaContent, size: 13, width: screenSize.width-10)
//
//    
//            return cityBtnY+cityBtnHeight+2*cityBtnMargin+evaContentHeight+86//8+40+cityBtnY+cityBtnHeight+cityBtnMargin+evaContentHeight+cityBtnMargin+30+8
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.navigationController?.pushViewController(CHSChPersonalInfoViewController(), animated: true)
    }
    
    // MARK:- companyBtnClick
    func companyBtnClick() {
        self.navigationController?.pushViewController(CHSChCompanyHomeViewController(), animated: true)
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
