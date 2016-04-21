//
//  OngoingProjectViewController.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/17/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

private var HeightForRow  = 122.0*AppDefine.ScreenSize.ScreenScale

class OngoingProjectViewController: BaseViewController {
    
    @IBOutlet weak private var tableview: UITableView!
    var titleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        if let myTitle = self.titleString {
            self.title = myTitle
        }
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.registerNib(UINib(nibName: OngoingProjectCell.className, bundle: nil), forCellReuseIdentifier: OngoingProjectCell.className)
    }
}

//MARk: Property Setter, Getter
extension OngoingProjectViewController {
    var dataArray: NSArray? {
        guard let array = ResourcesHelper.readFilePlist("OngingProjectPlist") else {
            return []
        }
        return array as [AnyObject]
    }
}

//MARk: Private
extension OngoingProjectViewController {
    private func openInvestmentDetail(indexPath: NSIndexPath) {
        let investDetailVC = OngoingProjectDetailViewController(nibName: OngoingProjectDetailViewController.className, bundle: nil)
        investDetailVC.titleString = self.dataArray?.objectAtIndex(indexPath.row)["title"] as? String
        self.pushViewController(investDetailVC)
    }
}

//MARK: UITableView DataSources
extension OngoingProjectViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier(OngoingProjectCell.className, forIndexPath: indexPath) as! OngoingProjectCell
        cell.OngoingObject = self.dataArray?.objectAtIndex(indexPath.row)
        return cell
    }
}

//MARK: UITableView Delegate
extension OngoingProjectViewController:UITableViewDelegate {
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(HeightForRow)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
        openInvestmentDetail(indexPath)
    }
}
