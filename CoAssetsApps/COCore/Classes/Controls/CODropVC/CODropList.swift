//
//  CODropListController.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/2/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class CODropList: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleDroplabel: UILabel!
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var bottomButton: CORedButton!
    var titleDrop: String! {
        didSet {
            titleDroplabel.text = titleDrop
        }
    }
    var selectedIndex: Int?
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = UIModalPresentationStyle.Custom
        tableView.registerCellClass(UITableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        titleDroplabel.text = titleDrop
        bottomButton.setTitle(m_local_string("TITLE_BUTTON_OK"), forState: .Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        maskView.alpha = 0.3
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func actionOK(sender: AnyObject) {
        if let index = selectedIndex {
            didSelectRowAtIndex(index)
        }
        dismiss()
    }
    
    @IBAction func actionClose(sender: AnyObject) {
        dismiss()
    }
}

extension CODropList: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(UITableViewCell.className, forIndexPath: indexPath)
        cell.textLabel?.text = titleForRowAtIndex(indexPath.row)
        cell.textLabel?.font = UIFont(name: AppDefine.AppFontName.COAvenirMedium,
            size: cell.textLabel?.font.pointSize ?? 16 * AppDefine.ScreenSize.ScreenScale)
        if selectedIndex == indexPath.row {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
}

extension CODropList: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if let myCell = cell {
            if let mySelectIndex = selectedIndex {
                if mySelectIndex != indexPath.row {
                    myCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    let oldCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: mySelectIndex, inSection: 0))
                    if let myoldCell = oldCell {
                        myoldCell.accessoryType = UITableViewCellAccessoryType.None
                    }
                }
            } else {
                myCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        }
        selectedIndex = indexPath.row
    }
}

//MARK: - DataSource
extension CODropList {
    
    func numberOfRows() -> Int {
        return 0
    }
    
    func titleForRowAtIndex(index: Int) -> String {
        return ""
    }
    
    func didSelectRowAtIndex(index: Int) {
    }
}
