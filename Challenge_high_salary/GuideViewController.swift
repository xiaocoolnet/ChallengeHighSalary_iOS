//
//  GuideViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/9/24.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {
    
    var pageControl = UIPageControl()
    var startButton = UIButton()
    
    private var scrollView = UIScrollView()
    
    private var numOfPages = 3
    
    var guideImageArray = Array<String>() {
        didSet {
            self.setSubviews()
        }
    }
    
    private func setSubviews() {
        
        self.numOfPages = guideImageArray.count
        
        let frame = self.view.bounds
        
        scrollView = UIScrollView(frame: frame)
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPointZero
        // 将 scrollView 的 contentSize 设为屏幕宽度的3倍(根据实际情况改变)
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(numOfPages), height: frame.size.height)
        
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        for index  in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: guideImageArray[index]))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height)
            scrollView.addSubview(imageView)
        }
        
        //        self.view.insertSubview(scrollView, atIndex: 0)
        
        pageControl.frame = CGRectMake(screenSize.width/2.0-kWidthScale*39/2.0, screenSize.height-kHeightScale*37, kWidthScale*39, kHeightScale*37)
        pageControl.numberOfPages = 3
        self.view.addSubview(pageControl)
        
        startButton.frame = CGRectMake(screenSize.width/2.0-kWidthScale*80/2.0, screenSize.height-kHeightScale*30-kHeightScale*37, kWidthScale*80, kHeightScale*30)
        // 给开始按钮设置圆角
        startButton.layer.cornerRadius = 15.0
        startButton.backgroundColor = UIColor.blueColor()
        // 隐藏开始按钮
        startButton.alpha = 0
        startButton.setTitle("立即体验", forState: .Normal)
        startButton.addTarget(self, action: #selector(startButtonAction(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(startButton)
    }
    
    // 隐藏状态栏
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func startButtonAction (button : UIButton) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window!.rootViewController = FTRoHomeViewController()
        
    }
    
}


// MARK: - UIScrollViewDelegate
extension GuideViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 随着滑动改变pageControl的状态
        pageControl.currentPage = Int(offset.x / view.bounds.width)
        
        // 因为currentPage是从0开始，所以numOfPages减1
        if pageControl.currentPage == numOfPages - 1 {
            UIView.animateWithDuration(0.5) {
                self.startButton.alpha = 1.0
            }
        } else {
            UIView.animateWithDuration(0.2) {
                self.startButton.alpha = 0.0
            }
        }
    }
}
