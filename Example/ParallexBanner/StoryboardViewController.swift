//
//  StoryboardViewController.swift
//  ParallexBanner
//
//  Created by huangwenchen on 16/7/26.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import ParallexBanner

class StoryboadViewController: UIViewController,ParallexBannerDelegate,ParallexBannerDataSource {
    
    @IBOutlet weak var banner: ParallexBanner!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false

        banner.delegate = self
        banner.dataSource = self
        banner.transitionMode = .Normal
        banner.autoScroll = false
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
