//
//  ProjectListDetailController.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/18/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

private let heightTabbar = 50.0*AppDefine.ScreenSize.ScreenScale

class ProjectListDetailController: BaseViewController {
    
    @IBOutlet var tabbarView: COTabBarView!
    
    var titleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = m_local_string("TITLE_PROJECT_LIST_DETAIL")
        
        let overviewView = OverviewView.loadFromNibName(OverviewView.className) as? OverviewView
        let investView = InvestView.loadFromNibName(InvestView.className)  as? InvestView
        let projectView = InvestView.loadFromNibName(ProjectView.className)  as? ProjectView
        let documentView = InvestView.loadFromNibName(DocumentView.className)  as? DocumentView
        let eventView = InvestView.loadFromNibName(EventView.className)  as? EventView
        
        if let myOverView = overviewView, myInvestView = investView,
            myProjectView =  projectView, myDocumentView = documentView, myEventView = eventView {
            myOverView.barItem = COBarItem(title: "Overview")
            myInvestView.barItem = COBarItem(title: "Invest")
            myProjectView.barItem = COBarItem(title: "Project")
            myDocumentView.barItem = COBarItem(title: "Document")
            myEventView.barItem = COBarItem(title: "Event", tag: 1000)
            
            tabbarView.tabViews = [myOverView, myInvestView, myProjectView, myDocumentView, myEventView]
            tabbarView.backgroundSelectedColor = AppDefine.AppColor.CORedColor
            tabbarView.selectedIndex = 0
            tabbarView.barHeight = CGFloat(heightTabbar)
            tabbarView.delegate = self
        }
    }
}

// MARK: COTabBarViewDelegate
extension ProjectListDetailController: COTabBarViewDelegate {
    func tabBarView(tabBarView: COTabBarView, didSelectTabView tabView: COTabView) {
        
    }
    
    override func actionSearch(sender: AnyObject) {
        
    }
}
