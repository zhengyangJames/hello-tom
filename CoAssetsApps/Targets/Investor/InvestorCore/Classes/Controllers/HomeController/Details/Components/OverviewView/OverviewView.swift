//
//  OverviewView.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import SDWebImage

private let headerHeight: CGFloat = 200 * AppDefine.ScreenSize.ScreenScale

class OverviewView: COTabView {
    weak var parentController: OfferDetailsController!
    @IBOutlet weak private var tableview: UITableView!
    
    weak var offerHeaderImageView: UIImageView!
    
    var headerView: UIView!
    
    func reloadData() {
        self.reloadTableData()
        self.offerHeaderImageView?.sd_setImageWithURL(NSURL(string: self.parentController.offerModel.project?.photo ?? ""), completed: { (image, error, type, url) -> Void in
            if image != nil && error == nil {
                self.headerView!.frame.size.height = floor(self.headerView!.bounds.size.width * image!.size.height / image!.size.width)
            } else {
                self.headerView!.frame.size.height = headerHeight
            }
            self.headerView!.sizeToFit()
            self.reloadTableData()
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: headerHeight))
        let imageView = UIImageView(frame: headerView.bounds)
        imageView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        imageView.backgroundColor = UIColor.lightGrayColor()
        headerView.addSubview(imageView)
        offerHeaderImageView = imageView
        offerHeaderImageView.backgroundColor = UIColor.lightGrayColor()
        tableview.registerCellNib(OVAddressCell)
        tableview.registerCellNib(OVDescriptionCell)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.tableFooterView = UIView()
        tableview.tableHeaderView = headerView
        tableview.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    private func reloadTableData() {
        if NSThread.isMainThread() {
            self.tableview.reloadData()
        } else {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.tableview.reloadData()
            })
        }
    }
}

//MARK: UITableView Datasource
extension OverviewView: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = parentController {
            return 2
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == AppDefine.AppEnum.OverviewType.OverviewAddress.rawValue {
            return tableview(tableView, overviewAddressCellForRowAtIndexPath: indexPath)
        } else if indexPath.row == AppDefine.AppEnum.OverviewType.OverviewDescription.rawValue {
            return tableview(tableview, overviewDescriptionCellForRowAtIndexPath: indexPath)
        } else {
            return UITableViewCell()
        }
    }
}

//MARK: UITableView Delegate
extension OverviewView: UITableViewDelegate {
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}

//MARK: Cells
extension OverviewView {
    private func tableview(tableView: UITableView, overviewAddressCellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCellWithIdentifier(OVAddressCell.className, forIndexPath: indexPath) as? OVAddressCell {
            cell.titleLabel.text = parentController.offerModel.offerTitle
            cell.addressLabel.text = parentController.offerModel.project?.address
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    private func tableview(tableView: UITableView, overviewDescriptionCellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCellWithIdentifier(OVDescriptionCell.className, forIndexPath: indexPath) as? OVDescriptionCell {
            cell.descriptionTextView.attributedText = parentController.offerModel.shortDesc
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
