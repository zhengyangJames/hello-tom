//
//  PortfolioViewController.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 03/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

let heightForRowPortFolioCell: CGFloat = 50 * AppDefine.ScreenSize.ScreenScale

class PortfolioViewController: BaseViewController {

    @IBOutlet weak private var tableView: UITableView!
    private var balancesArray: [COPortfolioBalanceModel]?
    private var completedArray: [COPortfolioCompletedModel]?
    private var typeArray = [AnyObject]()
    
    lazy var userName: String = {
       return ""
    }()
    var multiPortfolio: COMultiPortfolioModel?
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshTypeArray()
        synDataPortfolio()
    }
    
    //MARK: - Setup
    private func setupUI() {
        title = m_local_string("PORTFOLIO")
        setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.registerCellNib(PortfolioCell.self)
        self.tableView.registerCellNib(AvailableBalanceCell.self)
        self.tableView.registerCellNib(CompletedCell.self)
        self.tableView.registerCellNib(FormCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    private func refreshTypeArray() {
        let resultTypeArray = NSMutableArray(array: [AppDefine.PortfolioSection.Portfolio.rawValue, AppDefine.PortfolioSection.Portfolio.rawValue])
        if completedArray != nil && completedArray!.isEmpty == false {
            resultTypeArray.addObject(AppDefine.PortfolioSection.Completed.rawValue)
        }
        if balancesArray != nil && balancesArray!.isEmpty == false {
            resultTypeArray.addObject(AppDefine.PortfolioSection.AvailableBalance.rawValue)
            resultTypeArray.addObject(AppDefine.PortfolioSection.Form.rawValue)
        }
        typeArray = resultTypeArray as [AnyObject]
    }
}

//MARK: - API
extension PortfolioViewController {
    
    private func synDataPortfolio() {
        UIHelper.showLoadingInView(m_local_string("please_wait"))
        let tasks = SynchronizedArray<String>()
        tasks.completion = {() in
            UIHelper.hideLoadingFromView()
            self.refreshTypeArray()
            kMainQueue.addOperationWithBlock({ () -> Void in
                self.tableView.reloadData()
            })
        }
        tasks.append("Tasks1")
        tasks.append("Tasks2")
        tasks.append("Tasks3")
        let profilePortfolio = ProfileService()
        let username = ProfileContainer.userProfileModel.userName
        profilePortfolio.getMultiFortfolio({ (data, error) -> Void in
            if let _ = error {
                print(error)
            } else {
                if let data = data as? COMultiPortfolioModel {
                    self.multiPortfolio = data
                }
            }
            tasks.removeLast()
        })
        profilePortfolio.getPortfolioCompletedWithdrawal(username) { (data, error) -> Void in
            if let array = data as? [COPortfolioCompletedModel] {
                self.completedArray = array
            }
            tasks.removeLast()
        }
        profilePortfolio.getPortfolioAllBalance(username) { (data, error) -> Void in
            if let array = data as? [COPortfolioBalanceModel] {
                let arraysFilter = array.filter({
                        $0.currency.isEmpty == false
                    })
                self.balancesArray = arraysFilter.isEmpty == true ? nil : arraysFilter
            }
            tasks.removeLast()
        }
    }
}

//MARK: - TableView Datasource
extension PortfolioViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let type = typeArray[indexPath.row] as? NSInteger
        if type == AppDefine.PortfolioSection.Portfolio.rawValue {
            return self.tableView(tableView, portfolioCellForRowAtIndexPath: indexPath)
        } else if type == AppDefine.PortfolioSection.Completed.rawValue {
            return self.tableView(tableView, completedCellForRowAtIndexPath: indexPath)
        } else if type == AppDefine.PortfolioSection.AvailableBalance.rawValue {
            return self.tableView(tableView, availableBalanceCellForRowAtIndexPath: indexPath)
        } else if type == AppDefine.PortfolioSection.Form.rawValue {
            return self.tableView(tableView, formCellForRowAtIndexPath: indexPath)
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, portfolioCellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(PortfolioCell.className,
            forIndexPath: indexPath) as? PortfolioCell {
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.indexpath = indexPath
            cell.multiPortfolio = multiPortfolio
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, availableBalanceCellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(AvailableBalanceCell.className, forIndexPath: indexPath) as? AvailableBalanceCell {
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.availableBalanceArray = balancesArray
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, completedCellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(CompletedCell.className,
            forIndexPath: indexPath) as? CompletedCell {
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.completeArray = completedArray
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, formCellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(FormCell.className,
            forIndexPath: indexPath) as? FormCell {
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.availableBalanceArray = balancesArray
            cell.controller = self.navigationController
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: TableView Delegate
extension PortfolioViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return heightForRowPortFolioCell
    }
}
