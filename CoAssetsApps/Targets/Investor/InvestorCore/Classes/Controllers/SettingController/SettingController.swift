//
//  SettingController.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/2/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

private let heightFroRowAtIndex = 45

class SettingController: BaseViewController {
    @IBOutlet weak private var tableView: UITableView!
    lazy var settingDatas: NSArray = {
        guard let data = ResourcesHelper.readPlistFile("SettingPlist") else {
            return []
        }
        return data
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem()
        updateUserAuthStatus()
    }
    
    //MARK: - Setup
    private func setupUI() {
        title = m_local_string("TITLE_SETTINGS")
        tableView.registerNib(UINib(nibName: SettingCell.className, bundle: nil), forCellReuseIdentifier: SettingCell.className)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func updateUserAuthStatus() {
        if NSThread.isMainThread() {
            updateDataInMainThread()
        } else {
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                self.updateDataInMainThread()
            }
        }
    }
    
    private func updateDataInMainThread() {
        var userAuthStatus = ""
        if AuthManager.shared.hasAccessToken() {
            userAuthStatus = m_local_string("SIGN_OUT")
        } else {
            userAuthStatus = m_local_string("SIGN_IN")
        }
        let arr = NSMutableArray(array: self.settingDatas)
        arr.replaceObjectAtIndex(self.settingDatas.count - 1, withObject: userAuthStatus)
        self.settingDatas = arr
        self.tableView.reloadData()
        if self.tableView.contentSize.height > self.tableView.bounds.size.height {
            self.tableView.scrollEnabled = true
        } else {
            self.tableView.scrollEnabled = false
        }
    }
}

//MARK: UITableviewDataSource
extension SettingController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingDatas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(SettingCell.className, forIndexPath: indexPath) as? SettingCell {
            cell.title = settingDatas[indexPath.row] as? String
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

//MARK: UITableviewDelegate
extension SettingController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(heightFroRowAtIndex)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        deselectRowAtIndexPath(tableView, didSelectRowAtIndex: indexPath.row)
    }
}

//MARK: DidSelectRowAtIndexPath
extension SettingController {
    private func deselectRowAtIndexPath(tableView: UITableView, didSelectRowAtIndex index: NSInteger) {
        if index == 0 {
            pushContacViewController()
        } else if index == 1 {
            pushWebViewSetting(ServiceDefine.StaticURL.News, title: m_local_string("NEWS"))
        } else if index == 2 {
            pushWebViewSetting(ServiceDefine.StaticURL.TermsOfUse, title: m_local_string("TERM_OF_USE"))
        } else if index == 3 {
            pushWebViewSetting(ServiceDefine.StaticURL.CodeOfConduct, title: m_local_string("CODE_OF_CONDUCT"))
        } else if index == 4 {
            pushWebViewSetting(ServiceDefine.StaticURL.Privacy, title: m_local_string("PRIVACY"))
        } else if index == 5 {
            setupLoginAndLogout()
        }
    }
    
    private func pushContacViewController() {
        let contactVC = ContactController(nibName: ContactController.className, bundle: nil)
        self.pushViewController(contactVC)
    }
    
    private func pushWebViewSetting(link: String, title: String) {
        let webView = WebViewController(nibName: WebViewController.className, bundle: nil)
        webView.title = title
        webView.webLink = link
        self.pushViewController(webView)
    }
    
    private func setupLoginAndLogout() {
        AuthManager.shared.checkPermission(navigationController) { (granted: Bool) -> Void in
            if granted {
                let alert = UIHelper.alertView(m_local_string("APP_NAME"), message: m_local_string("MESSAGE_LOGOUT"))
                alert.addButtonWithAction(m_local_string("TITLE_BUTTON_OK")) { (UIAlertAction) -> Void in
                    AuthManager.shared.revokeAccessToken()
                    NotificationsManager.shared.notificationCount = 0
                    ConnectionManager.shared.isFirstTime = false
                    FlowManager.shared.home?.offerIdWaiting = nil
                    self.updateUserAuthStatus()
                }
                alert.addButtonWithAction(m_local_string("TITLE_BUTTON_CANCEL")) { (UIAlertAction) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                alert.show()
            }
        }
    }
}
