//
//  GYCustomEmoticonsViewController.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2017/1/18.
//  Copyright © 2017年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class GYCustomEmoticonsViewController: UIViewController {

    fileprivate lazy var collectionView : UICollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: EmoticonCollectionViewFlowLayout())
    
    fileprivate lazy var toolbar : UIToolbar = UIToolbar()
    
    fileprivate lazy var manager = EmoticonManager()
    
    var emoticonCallBack : ((_ emoticon : Emoticon) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setKeyBoard() {
        
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

// MARK:- ui设置
extension GYCustomEmoticonsViewController {
    func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(toolbar)
        
        collectionView.backgroundColor = UIColor.gray
        toolbar.backgroundColor = UIColor.green
        
        // 设置视图的约束
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["toolbar" : toolbar,"collectionView" : collectionView] as [String : Any]
        // 水平方向的约束 toolbar 离左边和右边的约束都为0
        var constraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[toolbar]-0-|", options: [], metrics: nil, views: views)
        // 垂直方向的约束 相距0 左边和右边对齐
        constraint += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-[toolbar]-0-|", options: [.alignAllLeft,.alignAllRight], metrics: nil, views: views)
        view.addConstraints(constraint)
        
        setupCollectionView()
        setupToolbar()
    }
    
    func setupCollectionView() {
        collectionView.register(EmoticonCollectionViewCell.self, forCellWithReuseIdentifier: "EmoticonCollectionViewCell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupToolbar() {
        let toolbarTitles = ["最近","默认","emoji","浪小花","星星"]
        
        var toolbarItems = [UIBarButtonItem]()
        
        for index in 0..<toolbarTitles.count {
            
            let barButton = UIBarButtonItem(title: toolbarTitles[index], style: .plain, target: self, action: #selector(EmoticonViewController.toolbarBarButtonItemClick(barButton:)))
            barButton.tag = 100 + index
            
            toolbarItems.append(barButton)
            toolbarItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
            
        }
        toolbarItems.removeLast()
        toolbar.tintColor = UIColor.orange
        toolbar.items = toolbarItems
    }
}

// MARK:- UICollectionViewDataSource--UICollectionViewDelegate
extension GYCustomEmoticonsViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.packages[section].emoticons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmoticonCollectionViewCell", for: indexPath) as! EmoticonCollectionViewCell
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.blue : UIColor.brown
        
        cell.emoticon = manager.packages[indexPath.section].emoticons[indexPath.item];
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emoticon = manager.packages[indexPath.section].emoticons[indexPath.item]
        
        guard !emoticon.isEmpty else {
            return
        }
        
        insertEmoticonToLately(emoticon)
        
        if let emoticonCallBack = emoticonCallBack {
            emoticonCallBack(emoticon)
        }
        
    }
}

// MARK:- 事件处理
extension GYCustomEmoticonsViewController {
    func toolbarBarButtonItemClick(barButton : UIBarButtonItem) {
        print(barButton.tag)
        
        collectionView.scrollToItem(at: IndexPath(item: 0, section: barButton.tag-100), at: .left, animated: true)
    }
    // 插入表情到最近
    func insertEmoticonToLately(_ emoticon : Emoticon) {
        
        guard !emoticon.isRemove else {
            return
        }
        
        if manager.packages.first!.emoticons.contains(emoticon) {
            manager.packages.first?.emoticons.remove(at: (manager.packages.first?.emoticons.index(of: emoticon))!)
        } else {
            manager.packages.first?.emoticons.remove(at: 22)
        }
        manager.packages.first?.emoticons.insert(emoticon, at: 0)
    }
}

// MARK:- 自定义流水布局
class EmoticonCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        let itemW = UIScreen.main.bounds.width / 8
        
        itemSize = CGSize(width: itemW, height: itemW)
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        let topMargin = (collectionView!.bounds.height - itemW * 3)/2
        collectionView?.contentInset = UIEdgeInsetsMake(topMargin, 0, topMargin, 0)
    }
}
