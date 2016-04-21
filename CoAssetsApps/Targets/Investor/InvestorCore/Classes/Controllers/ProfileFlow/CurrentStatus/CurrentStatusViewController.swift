//
//  CurrentStatusViewController.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 04/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class CurrentStatusViewController: BaseViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    private var statusArray: NSArray?
    lazy var investmentDashboard: COInvestmentDashboardModel = {
        return COInvestmentDashboardModel()
    }()
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        refreshData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        callAPIGetInvestmentDashBoard()
    }
    
    //MARK: - Setup
    private func setupUI() {
        title = m_local_string("CURRENTSTATUS")
        setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.registerCellNib(CurrentStatusCell.self)
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    private func refreshData() {
        let investmentOngoing   = [kCurrentStatusTitle: m_local_string("Ongoing Investment"), kCurrentStatusValue: investmentDashboard.ongoing]
        let investmentFunded    = [kCurrentStatusTitle: m_local_string("Funded Investment"), kCurrentStatusValue: investmentDashboard.funded]
        let investmentCompleted = [kCurrentStatusTitle: m_local_string("Completed Investment"), kCurrentStatusValue: investmentDashboard.completed]
        let payoutsRealised     = [kCurrentStatusTitle: m_local_string("Realised Payouts"), kCurrentStatusValue: investmentDashboard.realised]
        let payoutsPotential    = [kCurrentStatusTitle: m_local_string("Potential Payouts"), kCurrentStatusValue: investmentDashboard.potential]
        statusArray = [investmentOngoing, investmentFunded, investmentCompleted, payoutsRealised, payoutsPotential]
        self.tableView.reloadData()
        if self.tableView.contentSize.height > self.tableView.bounds.size.height {
            self.tableView.scrollEnabled = true
        } else {
            self.tableView.scrollEnabled = false
        }
    }
}


//MARK: - UITableViewDataSource
extension CurrentStatusViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let myData = statusArray {
            return myData.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(CurrentStatusCell.className, forIndexPath: indexPath) as? CurrentStatusCell {
            if statusArray != nil && indexPath.row < statusArray?.count {
                cell.data = statusArray?.objectAtIndex(indexPath.row) as? NSDictionary
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
}

//MARK: - API
extension CurrentStatusViewController {
    func callAPIGetInvestmentDashBoard() {
        UIHelper.showLoadingInView()
        let profileService = ProfileService()
        profileService.getInvestmentDashboard { (data, error) -> Void in
            UIHelper.hideLoadingFromView()
            if error == nil {
                if let investmentDashboard = data as? COInvestmentDashboardModel {
                    self.investmentDashboard = investmentDashboard
                    self.refreshData()
                }
            } else {
                UIHelper.showError(error, actionButton: nil)
            }
        }
    }
}
