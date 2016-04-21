//
//  NotificationController.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/2/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class NotificationController: BaseViewController {
    
    @IBOutlet weak private var tableview: UITableView!
    var requestNotification = true
    
    private var notificationManager: NotificationsManager {
        return NotificationsManager.shared
    }
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIHelper.showNetworkActivityIndicator()
        notificationManager.getNotifications { (success, error) -> Void in
            UIHelper.hideNetworkActivityIndicator()
            self.reloadTableView()
        }
    }
    
    var notifications: [CONotificationModel] {
        return NotificationsManager.shared.notificationModel
    }
    
    //MARK: - Setup
    func setupUI() {
        title = m_local_string("TITLE_NOTIFICATIONS")
        self.setupTableView()
    }
    
    func setupTableView() {
        self.tableview.registerCellNib(NotificationCell)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.tableFooterView = UIView()
    }
    
    private func reloadTableView() {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            self.tableview.reloadData()
        })
    }
}

//MARK: tableview datasource, delegate
extension NotificationController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(NotificationCell.className, forIndexPath: indexPath) as? NotificationCell {
            cell.notificationObject = notifications[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension NotificationController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? NotificationCell {
            NotificationsManager.shared.performCONotificationAction(cell.notificationObject, completion: { (success, error) -> Void in
                if success {
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        cell.notificationObject.item.status = NotificationStatus.Read.rawValue
                        self.reloadTableView()
                    })
                } else {
                    UIHelper.showError(error, actionButton: nil)
                }
            })
        }
    }
}
