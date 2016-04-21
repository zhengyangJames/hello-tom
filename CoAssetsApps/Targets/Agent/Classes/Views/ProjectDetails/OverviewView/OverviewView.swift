//
//  OverviewView.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

private let HeightHeader     = 200*AppDefine.ScreenSize.ScreenScale
private let HeightForRowMap  = 64*AppDefine.ScreenSize.ScreenScale
private let HeightForRowHightlight = 106.5*AppDefine.ScreenSize.ScreenScale
private let HeightForRowProject    = 113*AppDefine.ScreenSize.ScreenScale
private let HeightForRowPriceRange = 69*AppDefine.ScreenSize.ScreenScale

class OverviewView: COTabView {
    @IBOutlet weak private var tableview: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        tableview.dataSource = self
        tableview.delegate   = self
        tableview.tableFooterView = UIView()
        tableview.tableHeaderView = setupHeaderView()
        tableview.registerNib(UINib(nibName: OverviewMapCell.className, bundle: nil), forCellReuseIdentifier: OverviewMapCell.className)
        tableview.registerNib(UINib(nibName: OverviewObjectHighlightCell.className, bundle: nil), forCellReuseIdentifier: OverviewObjectHighlightCell.className)
        tableview.registerNib(UINib(nibName: OverviewProjectCell.className, bundle: nil), forCellReuseIdentifier: OverviewProjectCell.className)
        tableview.registerNib(UINib(nibName: OverViewPriceRangeCell.className, bundle: nil), forCellReuseIdentifier: OverViewPriceRangeCell.className)
    }
}

//MARK: Private
extension OverviewView {
    private func setupHeaderView() -> UIView {
        let headerView =  UIView.loadFromNibNamed("OverViewheader") as! OverViewheader
        headerView.frame.size.height = CGFloat(HeightHeader)
        return headerView
    }
    
    private func openMapView() {
        LocationPopup.showQuestionPopup(self) { (data, error) -> Void in
            
        }
    }
}

//MARK: UITableView Datasource
extension OverviewView: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == AppDefine.AppEnum.OverviewType.OverviewMap.rawValue {
            return overviewMapCell(tableview, cellForRowAtIndexPath: indexPath)
        } else if indexPath.row == AppDefine.AppEnum.OverviewType.OverviewHighligh.rawValue {
            return overviewObjectHighlightCell(tableview, cellForRowAtIndexPath: indexPath)
        }  else if indexPath.row == AppDefine.AppEnum.OverviewType.OverviewProject.rawValue {
             return overviewProjectCell(tableview, cellForRowAtIndexPath: indexPath)
        }
         return overViewPriceRangeCell(tableview, cellForRowAtIndexPath: indexPath)
    }
}

//MARK: UITableView Delegate
extension OverviewView: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            openMapView()
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == AppDefine.AppEnum.OverviewType.OverviewMap.rawValue {
            return CGFloat(HeightForRowMap)
        } else if indexPath.row == AppDefine.AppEnum.OverviewType.OverviewHighligh.rawValue {
            return CGFloat(HeightForRowHightlight)
        }  else if indexPath.row == AppDefine.AppEnum.OverviewType.OverviewProject.rawValue {
            return CGFloat(HeightForRowProject)
        }
        return CGFloat(HeightForRowPriceRange)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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

//MARK: Cells
extension OverviewView {
    private func overviewMapCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier(OverviewMapCell.className, forIndexPath: indexPath) as! OverviewMapCell
        return cell
    }
    
    private func overviewObjectHighlightCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier(OverviewObjectHighlightCell.className, forIndexPath: indexPath) as! OverviewObjectHighlightCell
        return cell
    }
    
    private func overviewProjectCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier(OverviewProjectCell.className, forIndexPath: indexPath) as! OverviewProjectCell
        return cell
    }
    
    private func overViewPriceRangeCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier(OverViewPriceRangeCell.className, forIndexPath: indexPath) as! OverViewPriceRangeCell
        return cell
    }
}