//
//  ManageInvestmentViewController.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/16/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit


private let HeightForHeader          = 241*AppDefine.ScreenSize.ScreenScale

class ManageInvestmentViewController: BaseViewController {
    
    @IBOutlet weak private var tableview: UITableView!
    
    var HeightForRow             = (UIScreen.mainScreen().bounds.size.height - CGFloat(AppDefine.ScreenSize.Navigation) - HeightForHeader)/4
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = m_local_string("TITLE_MANAGE_INVESTMENT")
        tableview.tableHeaderView = UIView()
        tableview.tableHeaderView = setupHeaderView()
        tableview.registerNib(UINib(nibName: ManageInvestmentCell.className, bundle: nil), forCellReuseIdentifier: ManageInvestmentCell.className)
        tableview.delegate = self
        tableview.dataSource = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
}

//MARK: Property setter, getter
extension ManageInvestmentViewController {
    var dataArray: NSArray? {
        guard let array = ResourcesHelper.readFilePlist("ManageInvestmentPlist") else {
            return []
        }
        return array as [AnyObject]
    }
}

//MARK: Private
extension ManageInvestmentViewController {
    private func setupHeaderView() -> UIView {
        let headerView = UIView.loadFromNibNamed("InvestmentHeaderVIew") as! InvestmentHeaderVIew
        headerView.frame.size.height = CGFloat(HeightForHeader)
        return headerView
    }
    
    private func openProjectListName(indexPath: NSIndexPath) {
        let projectVC = ProjectListViewController(nibName: ProjectListViewController.className, bundle: nil)
        self.pushViewController(projectVC)
    }
    
    private func openFAQPage(indexPath: NSIndexPath) {
        let faqVC = FAQPageViewController(nibName:FAQPageViewController.className, bundle: nil)
        self.pushViewController(faqVC)
    }
    
    private func openClientPage() {
        let clientPageVC = ClientPageViewController(nibName: ClientPageViewController.className, bundle: nil)
        self.pushViewController(clientPageVC)
    }
    
    private func openInvestmentPage(indexPath: NSIndexPath) {
        let investmentMade = InvestmentMadeController(nibName: InvestmentMadeController.className, bundle: nil)
        self.pushViewController(investmentMade)
    }
    
}

//MARK: Action
extension ManageInvestmentViewController {
    override func actionSearch(sender: AnyObject) {
        
    }
    
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.HeightForRow =  (UIScreen.mainScreen().bounds.height - CGFloat(AppDefine.ScreenSize.Navigation) - HeightForHeader)/4
                self.tableview.reloadData()
            })
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.HeightForRow =  (UIScreen.mainScreen().bounds.height - CGFloat(AppDefine.ScreenSize.Navigation) - HeightForHeader)/4
                self.tableview.reloadData()
            })
        }
        
    }
    
}

//MARK: UITableView Datasource
extension ManageInvestmentViewController {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataArray != nil {
            return self.dataArray!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier(ManageInvestmentCell.className, forIndexPath: indexPath) as! ManageInvestmentCell
        cell.dataCell = self.dataArray![indexPath.row]
        return cell
    }
}

//MARK: UITableView Delegate
extension ManageInvestmentViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return  CGFloat(HeightForRow)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == AppDefine.AppEnum.ManageInvestmentType.ProjectListPage.rawValue {
            openProjectListName(indexPath)
        } else if indexPath.row == AppDefine.AppEnum.ManageInvestmentType.FAQPage.rawValue {
            openFAQPage(indexPath)
        } else if indexPath.row == AppDefine.AppEnum.ManageInvestmentType.ClientPage.rawValue {
            openClientPage()
        } else if indexPath.row == AppDefine.AppEnum.ManageInvestmentType.InvestmentPage.rawValue {
            openInvestmentPage(indexPath)
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