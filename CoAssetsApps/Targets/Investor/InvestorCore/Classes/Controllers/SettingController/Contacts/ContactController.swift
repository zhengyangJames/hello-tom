//
//  ContactController.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/3/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import PureLayout

private let heightForHeaderInSection = 40
private let heightForRowInSection = 160

class ContactController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray: [COContactModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getContacts()
    }
    
    //SetupUI
    private func setupUI() {
        self.title =  m_local_string("TITLE_CONTACT")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(UINib(nibName: ContactCell.className, bundle: nil), forCellReuseIdentifier: ContactCell.className)
        self.tableView.hidden = true
    }
}

//MARK:Setter, Getter
extension ContactController {
    private func getContacts() {
        UIHelper.showLoadingInView(m_local_string("please_wait"))
        ListContact().getListContact { (data, error) -> Void in
            UIHelper.hideLoadingFromView()
            if let _ = error {
                UIHelper.showError(error, actionButton: nil)
            } else {
                if let data = data as? [COContactModel] {
                    self.dataArray = data
                }
            }
            self.tableView.hidden = false
            self.tableView.reloadData()
            self.tableView.scrollEnabled = true
        }
    }
}

//MARK:UITableViewDataSource
extension ContactController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let myData = dataArray {
            return myData.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return self.tableView(tableView, setupContactCellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        } else if indexPath.section == 1 {
            return self.tableView(tableView, setupContactCellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 1))
        }
        return self.tableView(tableView, setupContactCellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 2))
    }
}

//MARK:Cell
extension ContactController {
    func tableView(tableView: UITableView, setupContactCellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(ContactCell.className, forIndexPath: indexPath) as? ContactCell {
            if let mydata = dataArray {
                if indexPath.section == 0 {
                    cell.cotactModel = mydata[indexPath.section]
                } else if indexPath.section == 1 {
                    cell.cotactModel = mydata[indexPath.section]
                } else {
                    cell.cotactModel = mydata[indexPath.section]
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

//MARK:UITableViewDelegate
extension ContactController: UITableViewDelegate {
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(heightForRowInSection)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
