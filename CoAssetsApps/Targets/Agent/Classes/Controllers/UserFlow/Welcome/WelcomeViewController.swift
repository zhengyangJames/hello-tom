//
//  WelcomeViewController.swift
//  CoAssets-Agent
//
//  Created by TruongVO07 on 12/14/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit



class WelcomeViewController: BaseViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    private var HeightForRow = (Double(UIScreen.mainScreen().bounds.height) - AppDefine.ScreenSize.Navigation)/2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = m_local_string("TITLE_WELCOME")
        self.navigationController?.navigationBar.translucent = false
        self.setupNavigation()
        setupTableview()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    private func setupNavigation() {
        let newIcon =  UIImage(named: "icon_setting")?.resizeToNewSize(CGSize(width: 20, height: 20))
        let setting = UIBarButtonItem(image: newIcon!, style: UIBarButtonItemStyle.Plain, target: self, action: "actionSetting:")
        self.navigationItem.rightBarButtonItem = setting
    }
    
    private func setupTableview() {
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = UITableViewCellSeparatorStyle.None
        tableview.registerNib(UINib(nibName: WelcomeCell.className, bundle: nil), forCellReuseIdentifier: WelcomeCell.className)
    }
}

//MARK: Setter, getter
extension WelcomeViewController {
    var dataArray: NSArray? {
        guard let array = ResourcesHelper.readFilePlist("WelcomePlist") else {
            return []
        }
        return array as [AnyObject]
    }
    
}
//MARK: Action
extension WelcomeViewController {
    func actionSetting(sender: AnyObject) {
        kUserDefault.setBool(false, forKey: AppDefine.UserDefaultKey.LoggedIn)
        kAppDelegate!.setupLoginFlow()
    }
    
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.HeightForRow = (Double(UIScreen.mainScreen().bounds.height) - AppDefine.ScreenSize.Navigation)/2
                self.tableview.reloadData()
            })
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.HeightForRow = (Double(UIScreen.mainScreen().bounds.height) - AppDefine.ScreenSize.Navigation)/2
                self.tableview.reloadData()
                
            })
        }
    }
}

//MARK: UITableviewDatasource
extension WelcomeViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let mydata = self.dataArray {
            return mydata.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier(WelcomeCell.className, forIndexPath: indexPath) as! WelcomeCell
        cell.object = self.dataArray![indexPath.row]
        cell.isFirstItemIntableView = indexPath.row == 0 ? true : false
        cell.isLastItemIntableView = indexPath.row == (dataArray!.count - 1) ? true : false
        return cell
    }
}

//MARK: UITableviewDelegate
extension WelcomeViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(HeightForRow)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 0 {
            let manageVC = ManageInvestmentViewController(nibName: ManageInvestmentViewController.className, bundle: nil)
            self.pushViewController(manageVC)
        }
    }
    
    
    
}