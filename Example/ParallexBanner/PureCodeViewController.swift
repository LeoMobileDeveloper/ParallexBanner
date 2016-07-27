//
//  PureCodeViewController.swift
//  ParallexBanner
//
//  Created by huangwenchen on 16/7/26.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import ParallexBanner
class PureCodeViewController: UIViewController,ParallexBannerDelegate,ParallexBannerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pure code"
        self.view.backgroundColor = UIColor.whiteColor()
        let width = UIScreen.mainScreen().bounds.size.width;
        let height = width * 125.0/200.0;
        let frame = CGRectMake(0, 0, width, height)
        let banner = ParallexBanner(frame: frame)
        self.automaticallyAdjustsScrollViewInsets = false
        
        banner.delegate = self
        banner.dataSource = self
        banner.center = self.view.center
        self.view.addSubview(banner)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func banner(banner: ParallexBanner, urlOrImageAtIndex index: NSInteger) -> AnyObject {
        let image = UIImage(named: "p\(index).jpg")!
        if index == 0{
            return "http://img.blog.csdn.net/20160725214531068"
        }else{
            return image
        }
    }
    func banner(banner: ParallexBanner, placeHolderForIndex index: NSInteger) -> UIImage? {
        return UIImage(named: "placeholder.jpg")
    }
    func numberOfBannersIn(bannner: ParallexBanner) -> NSInteger {
        return 3
    }
    func banner(banner: ParallexBanner, didClickAtIndex index: NSInteger) {
        print("Click \(index)")
    }
    func banner(banner: ParallexBanner, didScrollToIndex index: NSInteger) {
        print("Scroll to \(index)")
    }
}