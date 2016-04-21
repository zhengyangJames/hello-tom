//
//  MenuController.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/2/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

enum Menu: NSInteger {
    case Home = 0
    case Profile
    case Notification
    case Setting
    
    var icon: String {
        switch self {
        case .Home: return "ic_nav_home"
        case .Profile: return "ic_nav_profile"
        case .Notification: return "ic_nav_notifications"
        case .Setting: return "ic_nav_settings"
        }
    }
}

class MenuController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var menus = [m_local_string("TITLE_HOME"), m_local_string("TITLE_PROFILE"),
        m_local_string("TITLE_NOTIFICATIONS"), m_local_string("TITLE_SETTINGS")]
    var oldIndexPath = NSIndexPath(forItem: 0, inSection: 0)
    var newIndexPath = NSIndexPath(forItem: 0, inSection: 0)
    var homeController: BaseNavigationController!
    var notificationController: BaseNavigationController!
    var profileController: BaseNavigationController!
    var settingController: BaseNavigationController!
    
    var controllerDelayUntilLoginCompleted: BaseNavigationController?
    
    func reloadData() {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            self.tableView.reloadData()
        })
    }
    
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCellNib(MenuCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        kNotification.addObserver(self, selector: "loggedIn:", name: AppDefine.NotificationKey.LoggedIn, object: nil)
        kNotification.addObserver(self, selector: "revokedAccessToken:", name: AppDefine.NotificationKey.RevokedAccessToken, object: nil)
        
        notificationController = BaseNavigationController(rootViewController: NotificationController.vc())
        profileController = BaseNavigationController(rootViewController: ProfileController.vc())
        settingController = BaseNavigationController(rootViewController: SettingController.vc())
    }
    
    func changeViewController(menu: Menu, checkPermission: ((Bool) -> Void)?) -> Void {
        switch menu {
        case .Home:
            checkPermission?(true)
            self.slideMenuController()?.changeMainViewController(homeController, close: true)
        case .Profile:
            AuthManager.shared.checkPermission(self, completion: { (granted) -> Void in
                if granted {
                    checkPermission?(true)
                    self.slideMenuController()?.changeMainViewController(self.profileController, close: true)
                } else {
                    checkPermission?(false)
                    self.controllerDelayUntilLoginCompleted = self.profileController
                }
            })
            
        case .Notification:
            AuthManager.shared.checkPermission(self, completion: { (granted) -> Void in
                if granted {
                    checkPermission?(true)
                    self.slideMenuController()?.changeMainViewController(self.notificationController, close: true)
                } else {
                    checkPermission?(false)
                    self.controllerDelayUntilLoginCompleted = self.notificationController
                }
            })
        case .Setting:
            checkPermission?(true)
            self.slideMenuController()?.changeMainViewController(settingController, close: true)
        }
    }
    
    func loggedIn(notification: NSNotification) {
        if let controller = controllerDelayUntilLoginCompleted {
            controllerDelayUntilLoginCompleted = nil
            self.slideMenuController()?.changeMainViewController(controller, close: true)
            changeColorCell(newIndexPath.row, isSelected: true)
            self.reloadData()
            newIndexPath = NSIndexPath(forItem: 0, inSection: 0)
        }
    }
    
    func revokedAccessToken(notification: NSNotification) {
        guard let currentVC = self.slideMenuController()?.mainViewController else {
            return
        }
        if currentVC.isKindOfClass(ProfileController.classForCoder()) || currentVC.isKindOfClass(NotificationController.classForCoder()) {
            profileController = nil
            notificationController = nil
            controllerDelayUntilLoginCompleted = nil
            newIndexPath = NSIndexPath(forItem: 0, inSection: 0)
            self.slideMenuController()?.changeMainViewController(homeController, close: true)
            changeColorCell(newIndexPath.row, isSelected: true)
            self.reloadData()
        }
    }
}

extension MenuController:UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let _ = Menu(rawValue: indexPath.item) {
            if let cell = tableView.dequeueReusableCellWithIdentifier(MenuCell.className,
                forIndexPath: indexPath) as? MenuCell {
                    return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let menu = Menu(rawValue: indexPath.item) {
            if let cell_ = cell as? MenuCell {
                cell_.setData(menus[indexPath.row], menu: menu)
                if oldIndexPath != indexPath {
                    cell_.actionSelected(false)
                    tableView.deselectRowAtIndexPath(indexPath, animated: false)
                } else {
                    cell_.actionSelected()
                    tableView.selectRowAtIndexPath(indexPath, animated: false,
                        scrollPosition: UITableViewScrollPosition.None)
                }
            }
        }
    }
}

extension MenuController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let _ = Menu(rawValue: indexPath.item) {
            return MenuCell.menuHeight
        }
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        changeColorCell(indexPath.row, isSelected: true)
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        var indexPathTemp: NSIndexPath? = nil
        if let menu = Menu(rawValue: indexPath.item) {
            self.changeViewController(menu, checkPermission: { (isLogin: Bool) -> Void in
                if isLogin == true {
                    indexPathTemp = indexPath
                } else {
                    indexPathTemp = nil
                    self.newIndexPath = indexPath
                }
            })
        }
        return indexPathTemp
    }
    
    func changeColorCell(forRow: NSInteger, isSelected: Bool) {
        for i in 0..<4 {
            performSelecteCell(i, isSelected: false)
        }
        performSelecteCell(forRow, isSelected: isSelected)
    }
    
    private func performSelecteCell(row: NSInteger, isSelected: Bool) {
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? MenuCell {
            cell.actionSelected(isSelected)
        }
        oldIndexPath = indexPath
    }
}

extension MenuController {
    func openOfferDetail(offerId: NSInteger) {
        oldIndexPath = NSIndexPath(forRow: Menu.Home.rawValue, inSection: 0)
        reloadData()
        if let menu = Menu(rawValue: Menu.Home.rawValue) {
            self.changeViewController(menu, checkPermission: nil)
        }
        guard let home = FlowManager.shared.home else {
            return
        }
        home.openOfferDetailController(offerId)
    }
}

extension MenuController {
    func openHomeFlow() {
        self.changeViewController(.Home, checkPermission: nil)
        self.changeColorCell(Menu.Home.rawValue, isSelected: true)
        self.reloadData()
    }
}
