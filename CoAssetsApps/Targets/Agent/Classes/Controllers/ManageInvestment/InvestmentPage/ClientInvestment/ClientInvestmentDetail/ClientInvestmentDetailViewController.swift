//
//  ClientInvestmentViewController.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/18/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

private var HeightForRow       = 180*AppDefine.ScreenSize.ScreenScale

class ClientInvestmentDetailViewController: BaseViewController {
    
    @IBOutlet weak private var tableview: UITableView!
    var titleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        if let myTiTle = self.titleString {
            self.title = myTiTle
        }
        tableview.tableFooterView = UIView()
        tableview.separatorStyle = UITableViewCellSeparatorStyle.None
        tableview.registerNib(UINib(nibName: ClientInvestmentDetailCell.className, bundle: nil), forCellReuseIdentifier: ClientInvestmentDetailCell.className)

        tableview.dataSource = self
        tableview.delegate = self
    }
}

//MARK: Property
extension ClientInvestmentDetailViewController {
    private var dataArray: NSArray? {
        return ResourcesHelper.readFilePlist("ClientInvestmentDetail")
    }
}

//MARK: Datasource
extension ClientInvestmentDetailViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.clientInvestmentDetailCell(tableview, cellForRowAtIndexPath: indexPath)
    }
}

//MARK: Cells
extension ClientInvestmentDetailViewController {
    private func clientInvestmentDetailCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ClientInvestmentDetailCell.className, forIndexPath: indexPath) as! ClientInvestmentDetailCell
        cell.object = dataArray![indexPath.row]
        return cell
    }
    
}

//MARK: Delegate
extension ClientInvestmentDetailViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(HeightForRow)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
