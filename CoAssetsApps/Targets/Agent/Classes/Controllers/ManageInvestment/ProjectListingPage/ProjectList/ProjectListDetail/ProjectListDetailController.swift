//
//  ProjectListDetailController.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/18/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

private let HeightTabbar = 50.0*AppDefine.ScreenSize.ScreenScale

class ProjectListDetailController: BaseViewController {
    
    @IBOutlet var tabbarView: COTabBarView!
    
    var titleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = m_local_string("TITLE_PROJECT_LIST_DETAIL")
     
        let overviewView = OverviewView.loadFromNibName(OverviewView.className) as! OverviewView
        overviewView.barItem = COBarItem(title: "Overview")
        
        let investView = InvestView.loadFromNibName(InvestView.className)  as! InvestView
        investView.barItem = COBarItem(title: "Invest")
        
        let projectView = InvestView.loadFromNibName(ProjectView.className)  as! ProjectView
        projectView.barItem = COBarItem(title: "Project")
        
        let documentView = InvestView.loadFromNibName(DocumentView.className)  as! DocumentView
        documentView.barItem = COBarItem(title: "Document")
        
        let eventView = InvestView.loadFromNibName(EventView.className)  as! EventView
        eventView.barItem = COBarItem(title: "Event", tag: 1000)
        
        tabbarView.tabViews = [overviewView, investView, projectView, documentView, eventView]
        tabbarView.backgroundSelectedColor = AppDefine.AppColor.CORedColor
        tabbarView.selectedIndex = 0
        tabbarView.barHeight = CGFloat(HeightTabbar);
        tabbarView.delegate = self
        
    }
}

// MARK: COTabBarViewDelegate
extension ProjectListDetailController: COTabBarViewDelegate {
    func tabBarView(tabBarView: COTabBarView, didSelectTabView tabView: COTabView) {
       
    }
    
    override func actionSearch(sender: AnyObject) {
        
    }
}