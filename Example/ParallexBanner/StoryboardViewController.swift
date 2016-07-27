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

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

class StoryboadViewController: UIViewController,ParallexBannerDelegate,ParallexBannerDataSource {
    
    @IBOutlet weak var banner: ParallexBanner!
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Auto reload after 3 seconds"
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false

        banner.delegate = self
        banner.dataSource = self
        banner.autoScrollTimeInterval = 2.0
//        banner.enableScrollForSinglePage = true
//        banner.pageControl.hidesForSinglePage = false
        delay(3.0) {
            self.count = 3
            self.banner.reloadData()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func banner(banner: ParallexBanner, urlOrImageAtIndex index: NSInteger) -> AnyObject {
        let image = UIImage(named: "p\(index).jpg")!
        return image
    }
    func numberOfBannersIn(bannner: ParallexBanner) -> NSInteger {
        return count
    }
    func banner(banner: ParallexBanner, didClickAtIndex index: NSInteger) {
        print("Click \(index)")
    }
    func banner(banner: ParallexBanner, didScrollToIndex index: NSInteger) {
        print("Scroll to \(index)")
    }
}
