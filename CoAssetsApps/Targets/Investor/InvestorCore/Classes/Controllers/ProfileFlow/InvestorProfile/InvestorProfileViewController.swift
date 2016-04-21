//
//  InvestorProfileViewController.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 04/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class InvestorProfileViewController: BaseViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    private var investorArray: NSArray?
    var userInvestor: COInvestorProfileModel {
        return ProfileContainer.investorProfileModel
    }
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        proccessData()
        setupUI()
    }
    
    //MARK: - Setup
    private func setupUI() {
        title = m_local_string("INVESTOR")
        setupTableView()
    }
    
    private func setupTableView() {
        if NSThread.isMainThread() {
            updateDataInMainThread()
        } else {
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                self.updateDataInMainThread()
            }
        }
    }
    
    private func updateDataInMainThread() {
        self.tableView.registerCellNib(InvestorProfileCell.self)
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        if self.tableView.contentSize.height > self.tableView.bounds.size.height {
            self.tableView.scrollEnabled = true
        } else {
            self.tableView.scrollEnabled = false
        }
    }
    
    private func proccessData() {
        let investor = userInvestor.getNameForCode(ServiceDefine.InvestorListType.TypeInvestor)
        let investorPrference = userInvestor.getNameForCode(ServiceDefine.InvestorListType.TypeProject)
        let amount =  userInvestor.currencyPrference + " " + String(userInvestor.investmentBudget)
        let taget = userInvestor.targetAnnualizeReturn == 0 ? m_local_string("TITLE_UNKNOWN") : String(userInvestor.targetAnnualizeReturn) + "%"
        let duration = userInvestor.duration == 0 ? m_local_string("TITLE_UNKNOWN") : String(userInvestor.duration) + " " + "mth"
        let country = userInvestor.countryPreference as String
        let investorType = [kInvestorProfileTitle: m_local_string("INVESTOR_TYPE"), kInvestorProfileValue: investor]
        let investorPrefeRence = [kInvestorProfileTitle: m_local_string("INVESTOR_PREFERENCE"), kInvestorProfileValue: investorPrference ]
        let investorAmount = [kInvestorProfileTitle: m_local_string("INVESTOR_AMOUNT"), kInvestorProfileValue: amount  ]
        let investorTarget = [kInvestorProfileTitle: m_local_string("INVESTOR_TARGET"), kInvestorProfileValue: taget]
        let investorDuration = [kInvestorProfileTitle: m_local_string("INVESTOR_DURATION"), kInvestorProfileValue: duration]
        let investorCountries = [kInvestorProfileTitle: m_local_string("INVESTOR_COUNTRIES"), kInvestorProfileValue: country]
        investorArray = [investorType, investorPrefeRence, investorAmount, investorTarget, investorDuration, investorCountries]
    }
}

extension InvestorProfileViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let myData = investorArray {
            return myData.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(InvestorProfileCell.className, forIndexPath: indexPath) as? InvestorProfileCell {
            if investorArray != nil && indexPath.row < investorArray?.count {
                cell.data = investorArray?.objectAtIndex(indexPath.row) as? NSDictionary
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
