//
//  InVestmentDetailViewController.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/17/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import PureLayout

private let HeightForRow     = 42.5*AppDefine.ScreenSize.ScreenScale

class OngoingProjectDetailViewController: BaseViewController {
    
    @IBOutlet weak private var tableview: UITableView!
    var titleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        if let mytitle = self.titleString {
            self.title = mytitle
        }
        tableview.tableFooterView = UIView()
        tableview.separatorStyle = UITableViewCellSeparatorStyle.None
        tableview.registerNib(UINib(nibName: OngoingProjectDetailCell.className, bundle: nil), forCellReuseIdentifier: OngoingProjectDetailCell.className)
        tableview.delegate = self
        tableview.dataSource = self
    }
}

//MARK: Property
extension OngoingProjectDetailViewController {
    private var dataArray: NSArray? {
        guard let array = ResourcesHelper.readFilePlist("NaThaiEstatePlist") else {
            return []
        }
        return array as [AnyObject]
    }
}

//MARK: UITableView DataSource
extension OngoingProjectDetailViewController:UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return ongoingProjectDetailCell(tableview, cellForRowAtIndexPath: indexPath)
    }
}

//MARK: UITableView Delegate
extension OngoingProjectDetailViewController:UITableViewDelegate {
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(HeightForRow)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

//MARK: UITableView Cells
extension OngoingProjectDetailViewController {
    private func ongoingProjectDetailCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(OngoingProjectDetailCell.className, forIndexPath: indexPath) as! OngoingProjectDetailCell
        cell.object = dataArray![indexPath.row]
        return cell
    }
    
}

