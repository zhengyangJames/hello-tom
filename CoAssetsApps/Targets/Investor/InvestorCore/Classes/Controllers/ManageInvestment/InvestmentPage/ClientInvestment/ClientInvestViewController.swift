//
//  ClientInvestViewController.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/18/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

private var heightForRow = 92*AppDefine.ScreenSize.ScreenScale

class ClientInvestViewController: BaseViewController {
    
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
        tableview.tableFooterView = UIView()
        tableview.registerNib(UINib(nibName: ClientInvestmentCell.className, bundle: nil), forCellReuseIdentifier: ClientInvestmentCell.className)
        tableview.delegate = self
        tableview.dataSource = self
    }
}

//MARk: Property Setter, Getter
extension ClientInvestViewController {
    var dataArray: NSArray? {
        guard let array = ResourcesHelper.readPlistFile("ClientInvestment") else {
            return []
        }
        return array as [AnyObject]
    }
}

//MARK: Datasource
extension ClientInvestViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let mydata = dataArray {
            return mydata.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCellWithIdentifier(ClientInvestmentCell.className, forIndexPath: indexPath) as? ClientInvestmentCell {
        cell.ongoingObject = self.dataArray?.objectAtIndex(indexPath.row)
        return cell
        } else {
            return UITableViewCell()
        }
    }
}

//MARK: Delegate
extension ClientInvestViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(heightForRow)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
        let clientDetaiVC = ClientInvestmentDetailViewController(nibName: ClientInvestmentDetailViewController.className, bundle: nil)
        clientDetaiVC.titleString = self.dataArray?.objectAtIndex(indexPath.row)["title"] as? String
        self.pushViewController(clientDetaiVC)
    }
}
