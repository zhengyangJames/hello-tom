//
//  InvestView.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

private enum Row: Int {
    case Status
    case Interested
    case MinInvestment
    case InvestmentHorizon
    case Percent
    case DayAgo
    
    static var count: Int {
        return 6
    }
    
    var icon: String {
        switch self {
        case .Status: return "icon_presaleinvest"
        case .Interested: return "icon_investor"
        case .MinInvestment: return "icon_investmentInvest"
        case .InvestmentHorizon: return "icon_month"
        case .Percent: return "icon_yield"
        case .DayAgo: return "icon_leftday"
        }
    }
}

class InvestView: COTabView {
    weak var parentController: OfferDetailsController!
    @IBOutlet weak private var tableview: UITableView!
    @IBOutlet weak private var interestedButton: COButton!
    weak var interestedPopup: IntrestedPopup?
    
    var hasProgress: Bool {
        if let _ = parentController where parentController.offerProjectFunInfo != nil {
            let goal =  parentController.offerProjectFunInfo?.goal
            if goal == 0.0 {
                return false
            }
            return true
        }
        return false
    }
    lazy var progressIndex = 6
    
    func reloadData() {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.tableview.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        tableview.registerCellNib(InvestViewCell)
        tableview.registerCellNib(InvestProgressCell)
        tableview.dataSource = self
        tableview.delegate  = self
        tableview.tableFooterView = UIView()
        interestedButton.setTitle(m_local_string("BUTTON_I'M_INTERESTED"), forState: UIControlState.Normal)
    }
}

//MARK: Action
extension InvestView {
    
    @IBAction func actionIntrested(sender: AnyObject) {
         let popup: IntrestedPopup = IntrestedPopup.showIntrestedPopup(self) {
            (email, amount) -> Void in
            UIHelper.showLoadingInView()
            OfferService().postOfferSubscribe(offerId: self.parentController.offerModel.offerID,
                email: email, amount: amount,
                completion: { (data, error) -> Void in
                    UIHelper.hideLoadingFromView()
                    if error == nil && data != nil {
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            print(self.parentController.offerModel.offerTitle)
                            let message = NSString(format: m_local_string("Interested_Popup"), self.parentController.offerModel.offerTitle)
                            let alert = UIHelper.alertView(nil, message: message as String)
                            alert.addButtonWithAction(m_local_string("TITLE_DONE")) { (UIMyAlertAction) -> Void in
                                self.interestedPopup?.popView()
                            }
                            alert.show()
                        })
                    } else {
                        // show error
                        print(error)
                    }
            })
        }!
        interestedPopup = popup
    }
}

//MARK: Datasource
extension InvestView: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hasProgress {
            return Row.count + 1
        }
        return Row.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == progressIndex {
            if let cell = tableview.dequeueReusableCellWithIdentifier(InvestProgressCell.className, forIndexPath: indexPath) as? InvestProgressCell {
                cell.offerFunInfo = parentController.offerProjectFunInfo
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            if let cell = tableview.dequeueReusableCellWithIdentifier(InvestViewCell.className, forIndexPath: indexPath) as? InvestViewCell {
                let row = Row(rawValue: indexPath.row)!
                cell.imgIcon.image = UIImage(named: row.icon)
                switch row {
                case .Status:
                    cell.titleLAbel.text = parentController.offerModel.status
                    cell.detailLabel.text = m_local_string("Project_status")
                    
                case .Interested:
                    cell.titleLAbel.text = parentController.offerModel.interectDesc
                    cell.detailLabel.text = m_local_string("Interested_in_project")
                    
                case .MinInvestment:
                    cell.titleLAbel.text = parentController.offerModel.minInvesmentTitle
                    cell.detailLabel.text = parentController.offerModel.minInvesmentDesc
                    
                case .InvestmentHorizon:
                    cell.titleLAbel.text = parentController.offerModel.timeHorizon
                    cell.detailLabel.text = m_local_string("INVESTMENT_HORIZON")
                    
                case .Percent:
                    cell.titleLAbel.text = parentController.offerModel.yieldDesc
                    cell.detailLabel.text = m_local_string("YIELD_(ANNUALIZED)")
                    
                case .DayAgo:
                    cell.titleLAbel.text = parentController.offerModel.dayLeftString
                    cell.detailLabel.text = m_local_string("DaysToGo")
                }
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
}

//MARK: DeleGate
extension InvestView: UITableViewDelegate {
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
