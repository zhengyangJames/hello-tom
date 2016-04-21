//
//  InvestmentMadeController.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/16/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import PureLayout


private let HeightHeaderView  = 194.0*AppDefine.ScreenSize.ScreenScale
private let HeightForRow      = 56.0*AppDefine.ScreenSize.ScreenScale
private let HeightForSection  = 47.0*AppDefine.ScreenSize.ScreenScale

class InvestmentMadeController: BaseViewController {
    
    @IBOutlet weak private var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = m_local_string("TITLE_INVESTMENT_MADE")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.tableHeaderView = setupHeaderView()
        tableview.registerNib(UINib(nibName: InvestmentMadeCell.className, bundle: nil), forCellReuseIdentifier: InvestmentMadeCell.className)
    }
}

//MARK: Property setter, getter
extension InvestmentMadeController {
    private var dataArray: NSArray? {
        guard let array = ResourcesHelper.readFilePlist("InvestmentMode") else {
            return []
        }
        return array as [AnyObject]
    }
}

//MARK: Private
extension InvestmentMadeController {
    private func setupHeaderView() -> UIView {
        let headerView = UIView.loadFromNibNamed("InvestmentMadeHeader") as! InvestmentMadeHeader
        headerView.frame.size.height = CGFloat(HeightHeaderView)
        return headerView
    }
    
    private func viewForHeaderinSection(section: Int) -> UIView {
        let HeaderView = UIView()
        HeaderView.backgroundColor = AppDefine.AppColor.COCurrentColor
        let header = UIView()
        header.backgroundColor = AppDefine.AppColor.COGrayColor
        HeaderView.addSubview(header)
        header.autoSetDimension(ALDimension.Height, toSize: 0.5*AppDefine.ScreenSize.ScreenScale)
        header.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 0)
        header.autoPinEdgeToSuperviewEdge(ALEdge.Trailing, withInset: 0)
        header.autoPinEdgeToSuperviewEdge(ALEdge.Leading, withInset: 0)
        
        let footer = UIView()
        footer.backgroundColor = AppDefine.AppColor.COGrayColor
        HeaderView.addSubview(footer)
        footer.autoSetDimension(ALDimension.Height, toSize: 0.5*AppDefine.ScreenSize.ScreenScale)
        footer.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 0)
        footer.autoPinEdgeToSuperviewEdge(ALEdge.Trailing, withInset: 0)
        footer.autoPinEdgeToSuperviewEdge(ALEdge.Leading, withInset: 0)

        
        let title_ = UILabel()
        title_.font = UIFont(name: AppDefine.AppFontName.COAvenirRoman, size: 17.55*AppDefine.ScreenSize.ScreenScale)
        HeaderView.addSubview(title_)
        title_.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: HeaderView)
        title_.autoPinEdgeToSuperviewEdge(ALEdge.Leading, withInset: 16*AppDefine.ScreenSize.ScreenScale)
        title_.autoPinEdgeToSuperviewEdge(ALEdge.Trailing, withInset: 8*AppDefine.ScreenSize.ScreenScale)
        let object = self.dataArray![section]
        title_.text = object["title"] as? String
        return HeaderView
    }
    
    private func openClientInvestment(arr: NSArray,indexPath: NSIndexPath) {
        let clientInvestmentVC = ClientInvestViewController(nibName: ClientInvestViewController.className, bundle: nil)
        clientInvestmentVC.titleString = arr[indexPath.row]["title"] as? String
        self.pushViewController(clientInvestmentVC)
    }
    
    private func openOngoing(arr: NSArray, indexPath: NSIndexPath) {
        let ongoingVC = OngoingProjectViewController(nibName: OngoingProjectViewController.className, bundle: nil)
        ongoingVC.titleString = arr[indexPath.row]["title"] as? String
        self.pushViewController(ongoingVC)
    }
}

//MARK: UITableView DataSource
extension InvestmentMadeController:UITableViewDataSource  {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataArray!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let object = self.dataArray![section] as! NSDictionary
        return object["items"]!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier(InvestmentMadeCell.className, forIndexPath: indexPath) as! InvestmentMadeCell
        let object = self.dataArray![indexPath.section] as! NSDictionary
        let arr = object["items"] as? NSArray
        
        cell.object = arr![indexPath.row]
        return cell
    }
}

//MARK: UITableView Delegate
extension InvestmentMadeController: UITableViewDelegate {
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewForHeaderinSection(section)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(HeightForSection)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(HeightForRow)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
        let object = self.dataArray![indexPath.section] as! NSDictionary
        let itemArr = object["items"] as? NSArray
        if indexPath.section == AppDefine.AppEnum.InvestmentPageSectionType.Client.rawValue {
            openClientInvestment(itemArr!, indexPath: indexPath)
        } else {
            if indexPath.row == 0 {
                openOngoing(itemArr!, indexPath: indexPath)
            }
        }
    }
    
    func tableView(_tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset = UIEdgeInsetsZero
        }
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins = UIEdgeInsetsZero
        }
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            cell.preservesSuperviewLayoutMargins = false
        }
    }
}

