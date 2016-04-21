//
//  OfferDetailsController.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/8/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

private let heightTabbar = 50.0*AppDefine.ScreenSize.ScreenScale

class OfferDetailsController: BaseViewController {
    var offerModel = COOfferModel()
    var offerProjectFunInfo: COOfferProjectFunInfo?
    @IBOutlet weak var tabbarView: COTabBarView!
    
    lazy var investView: InvestView! = {
        guard let investView = InvestView.loadFromNibName(InvestView.className)  as? InvestView else {
            return InvestView()
        }
        investView.barItem = COBarItem(title: m_local_string("Detail_Offer_Invest"), tag: 0)
        investView.parentController = self
        return investView
    }()
    lazy var overviewView: OverviewView! = {
        guard let overviewView = OverviewView.loadFromNibName(OverviewView.className) as? OverviewView else {
            return OverviewView()
        }
        overviewView.barItem = COBarItem(title: m_local_string("Detail_Offer_Overview"), tag: 1)
        overviewView.parentController = self
        return overviewView
    }()
    lazy var detailView: ProjectView! = {
        guard let detailView = ProjectView.loadFromNibName(ProjectView.className)  as? ProjectView else {
            return ProjectView()
        }
        detailView.barItem = COBarItem(title: m_local_string("Detail_Offer_Detail"), tag: 2)
        detailView.parentController = self
        return detailView
    }()
    lazy var documentView: DocumentView! = {
        guard let documentView = DocumentView.loadFromNibName(DocumentView.className)  as? DocumentView else {
            return DocumentView()
        }
        documentView.barItem = COBarItem(title: m_local_string("Detail_Offer_Document"), tag: 3)
        documentView.parentController = self
        return documentView
    }()
    
    //MARK:-Override

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNotification()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        checkPermissionUser()
    }
    
    private func setupUI() {
        self.title = m_local_string("TITLE_PROJECT_LIST_DETAIL")
        tabbarView.tabViews = [investView, overviewView, detailView, documentView]
        tabbarView.backgroundSelectedColor = AppDefine.AppColor.CORedColor
        tabbarView.selectedIndex = 0
        tabbarView.barHeight = CGFloat(heightTabbar)
    }
    
    private func setupNotification() {
        kNotification.addObserver(self, selector: "isUserNotLogged", name: AppDefine.NotificationKey.RevokedAccessToken, object: nil)
    }
    
    private func checkPermissionUser() {
        AuthManager.shared.checkPermission(navigationController) { (granted: Bool) -> Void in
            if !granted {
                self.isUserNotLogged()
            } else {
                self.syncData()
            }
        }
    }
    
    func isUserNotLogged() {
        self.popToRootViewController()
    }
    
    private func reloadData() {
        self.overviewView.reloadData()
        self.detailView.reloadData()
        self.documentView.reloadData()
        self.investView.reloadData()
    }
    
    deinit {
        kNotification.removeObserver(self, name: AppDefine.NotificationKey.RevokedAccessToken, object: nil)
    }
}

//CallAPI
extension OfferDetailsController {
    
    func syncData() {
        UIHelper.showLoadingInView()
        let tasks = SynchronizedArray<String>()
        var myError: NSError?
        tasks.completion = {
            UIHelper.hideLoadingFromView()
            if let _ = self.offerProjectFunInfo {
                self.reloadData()
            } else {
                if let _ = myError {
                    UIHelper.showError(myError, actionButton: { () -> Void in
                        self.isUserNotLogged()
                    })
                }
            }
        }
        tasks.append("task1")
        tasks.append("task2")
        OfferService().getOfferDetail(offerModel.offerID) { (data, error) -> Void in
            if let _ = error {
                myError = error
            } else {
                if let myData = data as? COOfferModel {
                    self.offerModel = myData
                }
            }
            tasks.removeLast()
        }
        OfferService().postProjectFullInfo(offerModel.offerID, completion: { (data, error) -> Void in
            if let _ = error {
                myError = error
            } else {
                if let myData = data as? COOfferProjectFunInfo {
                    self.offerProjectFunInfo = myData
                }
            }
            tasks.removeLast()
        })
    }
    
}
