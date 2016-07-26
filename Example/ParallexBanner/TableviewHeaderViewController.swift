//
//  TableviewHeaderViewController.swift
//  ParallexBanner
//
//  Created by huangwenchen on 16/7/26.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import ParallexBanner

class TableviewHeaderViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "As tableview header"
        self.view.backgroundColor = UIColor.whiteColor()
        let width = UIScreen.mainScreen().bounds.size.width;
        let height = width * 125.0/200.0;
        let frame = CGRectMake(0, 0, width, height)
        let banner = ParallexBanner(frame: frame)
        banner.delegate = self
        banner.dataSource = self
        self.tableView.tableHeaderView = banner
        // Do any additional setup after loading the view, typically from a nib.
    }
    // MARK: - TableView related -
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0;
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
}
extension TableviewHeaderViewController:ParallexBannerDelegate,ParallexBannerDataSource{
    // MARK: - Banner related -
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
