//
//  ProfileController.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/2/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

let kHeightProfileHeaderView: CGFloat = 345 * AppDefine.ScreenSize.ScreenScale

let kHeightForCell = AppDefine.DeviceType.IsIphone6 ? 48 : 43

class ProfileController: BaseViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    private var itemArray: NSArray? = [m_local_string("PORTFOLIO"), m_local_string("CURRENTSTATUS"), m_local_string("INVESTOR"), m_local_string("COASSETSSTOCK"), m_local_string("DEALS")]
    
    var userProfile: COUserProfileModel {
        return ProfileContainer.userProfileModel
    }
    
    var companyProfile: COCompanyProfileModel {
        return ProfileContainer.companyProfileModel
    }
    
    var userInvestProfile: COInvestorProfileModel {
        return ProfileContainer.investorProfileModel
    }

    //MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.refreshHeaderUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
        setNavigationBarItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        syncData()
    }
    
    //MARK: - Setup
    private func setupUI() {
        title = m_local_string("TITLE_PROFILE")
        self.setupTableView()
    }
    
    private func setupTableView() {
        tableView.registerCellNib(ProfileCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = CGFloat(kHeightForCell) * AppDefine.ScreenSize.ScreenScale
        tableView.tableHeaderView = headerTableView
        let h = tableView.tableHeaderView != nil ? tableView.tableHeaderView!.bounds.height : 340
        if self.tableView.contentSize.height + h > self.tableView.bounds.size.height {
            self.tableView.scrollEnabled = true
        } else {
            self.tableView.scrollEnabled = false
        }
    }
    
    lazy var headerTableView: ProfileHeaderView = {
        guard let view = ProfileHeaderView.nibView() as? ProfileHeaderView else {
            return ProfileHeaderView()
        }
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: kHeightProfileHeaderView)
        view.delegate = self
        return view
    }()
    
    func refreshHeaderUI() {
        if NSThread.isMainThread() {
            self.headerTableView.refreshUI()
        } else {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.headerTableView.refreshUI()
            })
        }
    }
}

//MARK: - API
extension ProfileController {
    
    func syncData() {
        UIHelper.showNetworkActivityIndicator()
        FlowManager.shared.syncUserData { (success, error) -> Void in
            UIHelper.hideNetworkActivityIndicator()
            self.refreshHeaderUI()
        }
    }
    
}

//MARK: tableview datasource
extension ProfileController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if itemArray != nil {
            return itemArray!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(ProfileCell.className, forIndexPath: indexPath) as? ProfileCell {
            if let myData = itemArray where indexPath.row < self.itemArray?.count {
                cell.stringTitle = myData.objectAtIndex(indexPath.row) as? String
            }
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
}

//MARK: tableview delegate
extension ProfileController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 0 {
            let vc = PortfolioViewController(nibName: PortfolioViewController.className, bundle: nil)
            vc.userName = self.userProfile.userName
            self.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = CurrentStatusViewController(nibName: CurrentStatusViewController.className, bundle: nil)
            self.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = InvestorProfileViewController(nibName: InvestorProfileViewController.className, bundle: nil)
            self.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            let vc = CoAssetsStockViewController(nibName: CoAssetsStockViewController.className, bundle: nil)
            self.pushViewController(vc, animated: true)
        } else {
            let vc = DealsController(nibName: DealsController.className, bundle: nil)
            self.pushViewController(vc, animated: true)
        }
    }
}

//MARK: header delegate
extension ProfileController: ProfileHeaderViewDelegate {
    func headerView(view: ProfileHeaderView, actionUpdateProfile sender: UIButton) {
        UIHelper.showActionSheetWithTitle(m_local_string("APP_NAME"),
            delegate: self,
            cancelTitle: m_local_string("TITLE_BUTTON_CANCEL"),
            destructTitle: nil,
            otherButtons: [m_local_string("KEY_ACTION_UPDATEPROFILE"), m_local_string("KEY_ACTION_UPDATECOMPANY"), m_local_string("KEY_ACTION_UPDATEINVESTOR")],
            tag: 1,
            controller: self)
        
    }
    
    func headerView(view: ProfileHeaderView, actionUpdatePassword sender: UIButton) {
        // Goto Update Password
        let vc = UpdatePasswordViewController(nibName:UpdatePasswordViewController.className, bundle: nil)
        self.pushViewController(vc)
    }
}

//MARK: actionsheet delegate
extension ProfileController: UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        //Update Profile
        if actionSheet.tag == 1 {
            actionSheet.dismissWithClickedButtonIndex(buttonIndex, animated: true)
            if buttonIndex == 1 {
                // Update Profile
                let vc = UpdateProfileViewController(nibName:UpdateProfileViewController.className, bundle: nil)
                self.pushViewController(vc)
            } else if buttonIndex == 2 {
                // Update Company Profile
                let vc = UpdateCompanyViewController(nibName:UpdateCompanyViewController.className, bundle: nil)
                self.pushViewController(vc)
            } else if buttonIndex == 3 {
                // Update Investor Profile
                let vc = UpdateInvestorViewController(nibName:UpdateInvestorViewController.className, bundle: nil)
                self.pushViewController(vc)
            }
        }
    }
}
