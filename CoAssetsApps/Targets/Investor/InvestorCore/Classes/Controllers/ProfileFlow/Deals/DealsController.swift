//
//  DealsController.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/4/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class DealsController: BaseViewController {
    
    @IBOutlet weak private var segmentController: UISegmentedControl!
    @IBOutlet weak private var introductionLabel: BaseLabel!
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var greatLabel: BaseLabel!
    @IBOutlet weak private var greatButton: COButtonIconDeal!
    @IBOutlet weak private var actionSegment: BaseButton!
    
    var investorDealData: COInvestorDealModel?
    var selectedSegment: Int?
    var isHighLighted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        callAPIGetInvestorDeal()
    }
    
    //setupUI
    private func setupUI() {
        title = m_local_string("DEALS")
        segmentController.selectedSegmentIndex = 0
        (segmentController.subviews[1] as UIView).tintColor = UIColor.blackColor()
        (segmentController.subviews[0] as UIView).tintColor = UIColor.blackColor()
        segmentController.setTitle(m_local_string("Ongoing"), forSegmentAtIndex: 0)
        segmentController.setTitle(m_local_string("Funded"), forSegmentAtIndex: 1)
        segmentController.setTitle(m_local_string("Completed"), forSegmentAtIndex: 2)
        setupTableview()
        setTilerLabelAndButton()
    }
    
}

//MARK: Setter, Getter
extension DealsController {
    var dataDealArray: [COInvestorDealDetailModel] {
        set {
            
        }
        get {
            var array = [COInvestorDealDetailModel]()
            if segmentController.selectedSegmentIndex == 0 {
                if let investorDealModel = investorDealData {
                    array = investorDealModel.ongoingArray
                }
                introductionLabel.text = m_local_string("ON_GOING")
            } else if segmentController.selectedSegmentIndex == 1 {
                if let investorDealModel = investorDealData {
                    array = investorDealModel.fundedArray
                }
                introductionLabel.text = m_local_string("FUNDED")
            } else {
                if let investorDealModel = investorDealData {
                    array = investorDealModel.completedArray
                }
                introductionLabel.text = m_local_string("COMPLETED")
            }
            return array
        }
    }
}

//MARK: Private
extension DealsController {
    private func setupTableview() {
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.registerNib(UINib(nibName: DealsCell.className, bundle: nil),
            forCellReuseIdentifier: DealsCell.className)
        tableView.tableFooterView = UIView()
        setTitlerLabelAndButton(dataDealArray.isEmpty)
    }
    
    private func setTilerLabelAndButton() {
        greatLabel.text = m_local_string("TITLE_LABEL")
        greatButton.title = m_local_string("TITLE_BUTTON")
    }
    
    private func setTitlerLabelAndButton(hidden: Bool) {
        tableView.hidden = hidden
        actionSegment.hidden = !hidden
        greatLabel.hidden = !hidden
        
    }
}

//MARK: ReloadData
extension DealsController {
    private func reloadDataDeal() {
        if NSThread.isMainThread() {
            updateInMainThread()
        } else {
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                self.updateInMainThread()
            }
        }
    }
    
    private func updateInMainThread() {
        self.dataDealArray.removeAll()
        self.tableView.reloadData()
        self.setTitlerLabelAndButton(self.dataDealArray.isEmpty)
    }
    
}

//MARK: Action
extension DealsController {
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        segmentController = sender
        reloadDataDeal()
        let sortedViews = sender.subviews.sort({ $0.frame.origin.x < $1.frame.origin.x })
        for (index, view) in sortedViews.enumerate() {
            if index == sender.selectedSegmentIndex {
                view.tintColor = AppDefine.AppColor.CORedColor
            } else {
                view.tintColor = UIColor.blackColor()
            }
        }
    }
    
    @IBAction func actionButtonGetStart(sender: COButtonIconDeal) {
        FlowManager.shared.openHomeFlow()
    }
}

//MARK: UItableviewDatasource
extension DealsController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDealArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(DealsCell.className,
            forIndexPath: indexPath) as? DealsCell {
                cell.dealDetail = dataDealArray[indexPath.row]
                return cell
        } else {
            return UITableViewCell()
        }
    }
}

//MARK: UITableviewDelegate
extension DealsController: UITableViewDelegate {
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

//MARK: API
extension DealsController {
    private func callAPIGetInvestorDeal() {
        let deal = ProfileService()
        UIHelper.showLoadingInView(m_local_string("please_wait"))
        deal.getInvestorDeal { (data, error) -> Void in
            UIHelper.hideLoadingFromView()
            if let _ = error {
                UIHelper.showError(error, actionButton: nil)
            } else {
                if let myData = data as? COInvestorDealModel {
                    self.investorDealData = myData
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        self.reloadDataDeal()
                    })
                }
            }
        }
    }
    
}
