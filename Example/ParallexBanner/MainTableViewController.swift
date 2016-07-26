//
//  ViewController.swift
//  ParallexBanner
//
//  Created by Leo on 07/23/2016.
//  Copyright (c) 2016 Leo. All rights reserved.
//

import UIKit
import ParallexBanner

class MainTableViewController:UITableViewController{
    let titles = ["Pure code","Storyboard","As TableView Header"]
    // MARK: - Delegate and dataSource -
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 0{
            let dvc = PureCodeViewController()
            self.navigationController?.pushViewController(dvc, animated: true)
        }else if(indexPath.row == 1){
            self.performSegueWithIdentifier("segue", sender: nil)
        }else if(indexPath.row == 2){
            let dvc = TableviewHeaderViewController()
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
}


