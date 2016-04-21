//
//  FAQPageViewController.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/16/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

private let HeightForRow             = 56.0*AppDefine.ScreenSize.ScreenScale
class FAQPageViewController: BaseViewController {
    
    @IBOutlet weak private var tableview: UITableView!
    
    var indexPathOld: NSIndexPath?
    
    lazy var dataArray: [AppDefine.FAQStruct] = {
        var dataArr: [AppDefine.FAQStruct] = []
        let arrayPlist = []
        guard let arrayTemp = ResourcesHelper.readFilePlist("PAQPlist") else {
            return dataArr
        }
        for var i = 0; i < arrayTemp.count; i++ {
            let structTemp = AppDefine.FAQStruct(title: arrayTemp[i] as? String, type: AppDefine.AppEnum.FAQPageType.Normal)
            dataArr.append(structTemp)
        }
        return dataArr
    }()
    
    lazy var itemDrop: AppDefine.FAQStruct! = {
        let structTemp = AppDefine.FAQStruct(title: "abcde", type: AppDefine.AppEnum.FAQPageType.Drop)
        return structTemp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = m_local_string("TITLE_FAQ_PAGE")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.registerNib(UINib(nibName: FAQPageCell.className, bundle: nil), forCellReuseIdentifier: FAQPageCell.className)
        tableview.registerNib(UINib(nibName: FAQPageDropCell.className, bundle: nil), forCellReuseIdentifier: FAQPageDropCell.className)
        
    }
}

//MARK: Public
extension FAQPageViewController {
    func insertRowFromIndexPath(indexPath:NSIndexPath) {
        dataArray[indexPath.row].isShow = true
        dataArray.insert(itemDrop, atIndex: indexPath.row + 1)
        tableview.insertRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section)], withRowAnimation: UITableViewRowAnimation.Middle)
        tableview.scrollToRowAtIndexPath(NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    func deleteRowFromIndexPath(indexPath:NSIndexPath) {
        dataArray[indexPath.row].isShow = false
        dataArray.removeAtIndex(indexPath.row + 1)
        tableview.deleteRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section)], withRowAnimation: UITableViewRowAnimation.Middle)
    }
}
//MARK: Datasource
extension FAQPageViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let object = self.dataArray[indexPath.row]
        if object.type == AppDefine.AppEnum.FAQPageType.Normal {
            return self.tableView(tableView, cellNormalForRowAtIndexPath: indexPath)
        } else {
            return self.tableView(tableview, cellDropForRowAtIndexPath: indexPath)
        }
    }
}

//MARK: Delegate
extension FAQPageViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let object = self.dataArray[indexPath.row]
        if object.type == AppDefine.AppEnum.FAQPageType.Normal {
            return CGFloat(HeightForRow)
        } else {
            
            return 100*AppDefine.ScreenSize.ScreenScale
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let object = self.dataArray[indexPath.row]
        if object.type == AppDefine.AppEnum.FAQPageType.Normal {
              return CGFloat(HeightForRow)
        } else {
       
            return UITableViewAutomaticDimension
        }
      
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
       let cell = tableView.cellForRowAtIndexPath(indexPath) as? FAQPageCell
        if let myCell = cell {
            myCell.actionSelect(indexPath)
        }
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
extension FAQPageViewController {
    private func tableView(tableView: UITableView, cellNormalForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier(FAQPageCell.className, forIndexPath: indexPath) as! FAQPageCell
        cell.structObject = self.dataArray[indexPath.row]
        cell.parentController = self
        return cell
    }
    
    private func tableView(tableView: UITableView, cellDropForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier(FAQPageDropCell.className, forIndexPath: indexPath) as! FAQPageDropCell
        return cell
        
    }
}