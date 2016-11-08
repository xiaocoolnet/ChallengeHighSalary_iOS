//
//  CHSChCompanyHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/19.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSChCompanyHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let rootTableView = UITableView()
    let companyNoteStr = "如果你无法简洁的表达你的想法，那只说明你还不够了解它。64d99164d991       如果你无法简洁的表达你的想法，那只说明你还不够了解它。       如果你无法简洁的表达你的想法，那只说明你还不够了解它。"
    var productNoteStr = "如果你无法简洁的表达你的想法，那只说明你还不够了解它。64d99164d991       如果你无法简洁的表达你的想法，那只说明你还不够了解它。       如果你无法简洁的表达你的想法，那只说明你还不够了解它。"
    
    var jobInfoUserid = ""
    
    var company_infoData = Company_infoDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setSubviews()
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.alpha = 0
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: 加载数据
    func loadData() {
        FTNetUtil().getMyCompany_info(self.jobInfoUserid) { (success, response) in
            if success {
                self.company_infoData = response as! Company_infoDataModel
                self.setHeaderView()
                self.rootTableView.reloadData()
            }else{
                
            }
        }
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        self.title = "公司主页"

        self.view.backgroundColor = UIColor.white
        
        rootTableView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-45)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.separatorStyle = .none
        rootTableView.register(UINib(nibName: "CHSChCompanyPositionTableViewCell", bundle: nil), forCellReuseIdentifier: "CHSChCompanyPositionCell")
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.view.addSubview(rootTableView)
        
//        setHeaderView()
        
        let backBtn = UIButton(frame: CGRect(x: 8, y: 28, width: kHeightScale*25, height: kHeightScale*25))
//        backBtn.backgroundColor = baseColor
        backBtn.setImage(UIImage(named: "ic_返回_green"), for: UIControlState())
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.view.addSubview(backBtn)
        
        let interviewEvaluateBtn = UIButton(frame: CGRect(x: 0, y: screenSize.height-45, width: screenSize.width, height: 45))
        interviewEvaluateBtn.backgroundColor = baseColor
        interviewEvaluateBtn.setTitleColor(UIColor.white, for: UIControlState())
        interviewEvaluateBtn.setTitle("面试评价(2)", for: UIControlState())
        interviewEvaluateBtn.addTarget(self, action: #selector(interviewEvaluateBtnClick), for: .touchUpInside)
        self.view.addSubview(interviewEvaluateBtn)
    }
    
    // MARK:- backBtn 点击事件
    func backBtnClick() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- interviewEvaluateBtn 点击事件
    func interviewEvaluateBtnClick() {
        self.navigationController?.pushViewController(CHSChCompanyInterviewEvaluationViewController(), animated: true)
    }
    
    // MARK:- 设置tableview 头视图
    func setHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*270))
        headerView.backgroundColor = UIColor.white
        
        let headerBgImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*180))
        headerBgImgView.backgroundColor = UIColor.orange
        headerView.addSubview(headerBgImgView)
        
        let headerImgView = UIImageView(frame: CGRect(x: 0, y: kHeightScale*155, width: kHeightScale*60, height: kHeightScale*60))
        headerImgView.layer.cornerRadius = headerImgView.frame.size.width/2.0
        headerImgView.clipsToBounds = true
        headerImgView.backgroundColor = UIColor.gray
        headerImgView.sd_setImage(with: URL(string: kImagePrefix+self.company_infoData.logo), placeholderImage: nil)
        headerImgView.center.x = self.view.center.x
        headerView.addSubview(headerImgView)
        
        let companyNameLab = UILabel(frame: CGRect(x: 0, y: headerImgView.frame.maxY+kHeightScale*15, width: screenSize.width, height: kHeightScale*20))
        companyNameLab.textAlignment = .center
        companyNameLab.textColor = baseColor
        companyNameLab.font = UIFont.systemFont(ofSize: 14)
        companyNameLab.text = self.company_infoData.company_name
        headerView.addSubview(companyNameLab)
        
        let companyNoteLab = UILabel(frame: CGRect(x: 0, y: companyNameLab.frame.maxY, width: screenSize.width, height: kHeightScale*20))
        companyNoteLab.textAlignment = .center
        companyNoteLab.textColor = UIColor(red: 116/255.0, green: 116/255.0, blue: 116/255.0, alpha: 1)
        companyNoteLab.font = UIFont.systemFont(ofSize: 13)
        companyNoteLab.text = "\(self.company_infoData.industry)/\(self.company_infoData.financing)/\(self.company_infoData.count)"
        headerView.addSubview(companyNoteLab)
        
        self.rootTableView.tableHeaderView = headerView
    }
    
    // MARK:- tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return self.company_infoData.jobs?.count ?? 0
        }else{
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as NSIndexPath).section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CHSChCompanyPositionCell") as! CHSChCompanyPositionTableViewCell
            cell.selectionStyle = .none
            
            cell.company_infoJob = (self.company_infoData.jobs![(indexPath as NSIndexPath).row])
            return cell
        }else{
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "companyHomeCell")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "companyHomeCell")
            }
            cell!.selectionStyle = .none
            
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
            if (indexPath as NSIndexPath).section == 0 {
                cell?.textLabel?.text = "\t"+self.company_infoData.com_introduce
            }else if (indexPath as NSIndexPath).section == 1 {
                cell?.textLabel?.text = "\t"+self.company_infoData.produte_info
            }
            
            return cell!
        }
    }
    
    // MARK:- tableview delegate
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
        case (0,0):
            return calculateHeight(self.company_infoData.com_introduce, size: 14, width: screenSize.width-16)+20
        case (1,0):
            return calculateHeight(self.company_infoData.produte_info, size: 14, width: screenSize.width-16)+20
        default:
            return 146
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let sectionHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*35))
            sectionHeaderView.backgroundColor = UIColor.white
            
            let sectionHeaderLab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*35))
            sectionHeaderLab.font = UIFont.systemFont(ofSize: 14)
            sectionHeaderLab.textColor = baseColor
            sectionHeaderLab.text = "公司介绍"
            sectionHeaderLab.sizeToFit()
            sectionHeaderLab.center = sectionHeaderView.center
            sectionHeaderView.addSubview(sectionHeaderLab)
            
            let leftLine = UIView(frame: CGRect(x: 8, y: kHeightScale*17, width: sectionHeaderLab.frame.minX-16, height: 1))
            leftLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
            sectionHeaderView.addSubview(leftLine)
            
            let rightLine = UIView(frame: CGRect(x: sectionHeaderLab.frame.maxX+8, y: kHeightScale*17, width: sectionHeaderLab.frame.minX-16, height: 1))
            rightLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
            sectionHeaderView.addSubview(rightLine)
            
            return sectionHeaderView
        }else if section == 1 {
            let sectionHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*35))
            sectionHeaderView.backgroundColor = UIColor.white
            
            let sectionHeaderLab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*35))
            sectionHeaderLab.font = UIFont.systemFont(ofSize: 14)
            sectionHeaderLab.textColor = baseColor
            sectionHeaderLab.text = "产品介绍"
            sectionHeaderLab.sizeToFit()
            sectionHeaderLab.center = sectionHeaderView.center
            sectionHeaderView.addSubview(sectionHeaderLab)

            let leftLine = UIView(frame: CGRect(x: 8, y: kHeightScale*17, width: sectionHeaderLab.frame.minX-16, height: 1))
            leftLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
            sectionHeaderView.addSubview(leftLine)
            
            let rightLine = UIView(frame: CGRect(x: sectionHeaderLab.frame.maxX+8, y: kHeightScale*17, width: sectionHeaderLab.frame.minX-16, height: 1))
            rightLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
            sectionHeaderView.addSubview(rightLine)
            
            return sectionHeaderView
        }else if section == 2 {
            let sectionHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*35))
            sectionHeaderView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
            
            let sectionHeaderLab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*35))
            sectionHeaderLab.font = UIFont.systemFont(ofSize: 14)
            sectionHeaderLab.textColor = baseColor
            sectionHeaderLab.text = "热招职位"
            sectionHeaderLab.sizeToFit()
            sectionHeaderLab.center = sectionHeaderView.center
            sectionHeaderView.addSubview(sectionHeaderLab)
            
            let leftLine = UIView(frame: CGRect(x: 8, y: kHeightScale*17, width: sectionHeaderLab.frame.minX-16, height: 1))
            leftLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
            sectionHeaderView.addSubview(leftLine)
            
            let rightLine = UIView(frame: CGRect(x: sectionHeaderLab.frame.maxX+8, y: kHeightScale*17, width: sectionHeaderLab.frame.minX-16, height: 1))
            rightLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
            sectionHeaderView.addSubview(rightLine)
            
            return sectionHeaderView
        }
    
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeightScale*35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section == 2 {
            let personalInfoVC = CHSChPersonalInfoViewController()
            personalInfoVC.jobInfo = self.company_infoData.jobs![(indexPath as NSIndexPath).row]
            
            self.navigationController?.pushViewController(personalInfoVC, animated: true)
        }
    }
    
    // MARK: scrollview delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView.contentOffset.y >= 64 {

            UIView.animate(withDuration: 0.5, animations: {
                
                self.navigationController?.navigationBar.alpha = 1
            })
        }else{
            UIView.animate(withDuration: 0.5, animations: {
                
                self.navigationController?.navigationBar.alpha = 0
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.alpha = 1
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
