//
//  ProjectListCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/29/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import PureLayout

private let heightFooterView = 48*AppDefine.ScreenSize.ScreenScale
private let heightHeaderView = 155*AppDefine.ScreenSize.ScreenScale
private let heightForRowProjectListHightCell = 130*AppDefine.ScreenSize.ScreenScale
private let heightForRowProjectPriceRangeCell = 98*AppDefine.ScreenSize.ScreenScale
private let heightForRowProjectProjectCell = 60*AppDefine.ScreenSize.ScreenScale

protocol ProjectListCellDelegate {
    func projectListCell(projectListCell: ProjectListCell)
}

class ProjectListCell: UICollectionViewCell {
    
    var objectButton: AnyObject? {
        didSet {
            if let myObject = objectButton {
                loadDataButtom(myObject)
            }
        }
    }
    
    @IBOutlet weak private var tableview: UITableView!
    @IBOutlet weak private var footerButton: COIconLeftButton!
    
    var delegate: ProjectListCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        tableview.dataSource  = self
        tableview.delegate  = self
        tableview.tableHeaderView = setupHeaderView()
        tableview.tableFooterView = UIView()
        tableview.registerNib(UINib(nibName: ProjectListTableObjectHightCell.className, bundle: nil), forCellReuseIdentifier: ProjectListTableObjectHightCell.className)
        
        tableview.registerNib(UINib(nibName: ProjectListTablePriceRangeCell.className, bundle: nil), forCellReuseIdentifier: ProjectListTablePriceRangeCell.className)
        
        tableview.registerNib(UINib(nibName: ProjectListTableProjectCell.className, bundle: nil), forCellReuseIdentifier: ProjectListTableProjectCell.className)
    }
}


//MARK: Private
extension ProjectListCell {
    private func setupHeaderView() -> UIView {
        if let headerView =  UIView.awakeFromNib(ProjectListTableHeaderView.className) as? ProjectListTableHeaderView {
            let tap = UITapGestureRecognizer(target: self, action: "actionPushDetail:")
            headerView.addGestureRecognizer(tap)
            headerView.frame.size.height = CGFloat(heightHeaderView)
            return headerView
        }
        return UIView()
    }
    
    private func loadDataButtom(object: AnyObject) {
        if let type = object["type"] as? String, typeInt = Int(type) {
            footerButton.backgroundColor = loadBackgroundColor(typeInt)
        }
        if let nameIcon = object["icon"] as? String {
            footerButton.icon = UIImage(named:nameIcon )
        }
        footerButton.titleButton = object["title"] as? String
    }
}

//MARK: Action
extension ProjectListCell {
    func actionPushDetail(sender: AnyObject) {
        self.delegate.projectListCell(self)
    }
    
    func actionPreSale(sender: AnyObject) {
        
    }
}

//MARK: UITableviewDataSource
extension ProjectListCell: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == AppDefine.AppEnum.ProjectListType.ProjectListHighligh.rawValue {
            
            return tableViewList(tableView, projectListTableObjectHightCellForRowAtIndexPath: indexPath)
            
        } else if indexPath.row == AppDefine.AppEnum.ProjectListType.ProjectListProject.rawValue {
            return tableViewList(tableView, projectListTableProjectCellForRowAtIndexPath: indexPath)
        }
        return tableViewList(tableView, projectListTablePriceRangeCellForRowAtIndexPath: indexPath)
    }
}

//MARK: UITableviewDelegate
extension ProjectListCell: UITableViewDelegate {
    
    private func loadBackgroundColor(type: Int) -> UIColor {
        //        if type == AppDefine.AppEnum.ProjectList.ProjectListBulk.rawValue {
        //            return AppDefine.AppColor.CORedListColor
        //        } else if type == AppDefine.AppEnum.ProjectList.ProjectListCroudFunding.rawValue {
        //            return AppDefine.AppColor.COYellowListColor
        //        }
        return AppDefine.AppColor.COBlueListColor
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == AppDefine.AppEnum.ProjectListType.ProjectListHighligh.rawValue {
            return CGFloat(heightForRowProjectListHightCell)
        } else if indexPath.row == AppDefine.AppEnum.ProjectListType.ProjectListProject.rawValue {
            return CGFloat(heightForRowProjectPriceRangeCell)
        }
        return CGFloat(heightForRowProjectProjectCell)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate.projectListCell(self)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
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

//MARK: Cells
extension ProjectListCell {
    private func tableViewList(tableView: UITableView, projectListTableObjectHightCellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCellWithIdentifier(ProjectListTableObjectHightCell.className, forIndexPath: indexPath) as? ProjectListTableObjectHightCell {
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    private func tableViewList(tableView: UITableView, projectListTablePriceRangeCellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCellWithIdentifier(ProjectListTablePriceRangeCell.className, forIndexPath: indexPath) as? ProjectListTablePriceRangeCell {
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    private func tableViewList(tableView: UITableView, projectListTableProjectCellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCellWithIdentifier(ProjectListTableProjectCell.className, forIndexPath: indexPath) as? ProjectListTableProjectCell {
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
