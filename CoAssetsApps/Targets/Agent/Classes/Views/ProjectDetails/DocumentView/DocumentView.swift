//
//  DocumentView.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import PureLayout

private let HeightHeaderView = 93*AppDefine.ScreenSize.ScreenScale
private let HeightForSection = 48*AppDefine.ScreenSize.ScreenScale
private let HeightForRow     = 63*AppDefine.ScreenSize.ScreenScale

class DocumentView: COTabView {
    
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
        tableview.registerNib(UINib(nibName: DocumentViewCell.className, bundle: nil), forCellReuseIdentifier: DocumentViewCell.className)
        tableview.registerNib(UINib(nibName: DocumentHeaderCell.className, bundle: nil), forCellReuseIdentifier: DocumentHeaderCell.className)
    }
}

//MARK: Property
extension DocumentView {
    private var dataArray: NSArray? {
        guard let array = ResourcesHelper.readFilePlist("ProjectDetailPlist") else {
            return []
        }
        return array as [AnyObject]
    }
}

//MARK: Private
extension DocumentView {
    private func setupHeaderView() -> UIView {
        let headerView = UIView()
        headerView.frame.size.height = CGFloat(HeightHeaderView)
        
        let viewFooter = UIView()
        viewFooter.backgroundColor = AppDefine.AppColor.COGrayColor
        headerView.addSubview(viewFooter)
        viewFooter.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 0)
        viewFooter.autoPinEdgeToSuperviewEdge(ALEdge.Leading, withInset: 0)
        viewFooter.autoPinEdgeToSuperviewEdge(ALEdge.Trailing, withInset: 0)
        viewFooter.autoSetDimension(ALDimension.Height, toSize: 0.5)
        
        let contentLabel = BaseLabel()
        contentLabel.textColor = AppDefine.AppColor.COGrayColorText
        contentLabel.font = UIFont(name: AppDefine.AppFontName.COAvenirBook, size: 15*AppDefine.ScreenSize.ScreenScale)
        contentLabel.numberOfLines = 0
        contentLabel.text = m_local_string("TITLE_HEADER_DOCUMENT")
        headerView.addSubview(contentLabel)
        contentLabel.autoPinEdgeToSuperviewEdge(ALEdge.Leading, withInset: 16*AppDefine.ScreenSize.ScreenScale)
        contentLabel.autoPinEdgeToSuperviewEdge(ALEdge.Trailing, withInset: 16*AppDefine.ScreenSize.ScreenScale)
        contentLabel.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: -5*AppDefine.ScreenSize.ScreenScale)
        contentLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: viewFooter, withOffset: 0)
        
        return headerView
    }
    
}

//MARK: Datasource
extension DocumentView:UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataArray!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dicObject = self.dataArray![section]
        let arr = dicObject["items"] as! NSArray
        return arr.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            return headerDocumentCell(tableview, cellForRowAtIndexPath: indexPath)
        }
        return documentCell(tableview, cellForRowAtIndexPath: indexPath)
    }
}

//MARK: Cells
extension DocumentView {
    private func documentCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableview.dequeueReusableCellWithIdentifier(DocumentViewCell.className, forIndexPath: indexPath) as! DocumentViewCell
        let dicObject = self.dataArray![indexPath.section]
        cell.obectDetail = (dicObject["items"] as! NSArray)[indexPath.row - 1]
        return cell
    }
    
    private func headerDocumentCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableview.dequeueReusableCellWithIdentifier(DocumentHeaderCell.className, forIndexPath: indexPath) as! DocumentHeaderCell
        let dicObject = self.dataArray![indexPath.section]
        cell.titleString = dicObject["title"] as? String
        return cell
    }
}

//MARK: Delegate
extension DocumentView: UITableViewDelegate {
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(HeightForSection)
        }
        return CGFloat(HeightForRow)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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