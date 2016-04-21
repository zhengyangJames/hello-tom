//
//  InvestView.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

private let HeightForRow   =  80.0*AppDefine.ScreenSize.ScreenScale
class InvestView: COTabView {
    
    @IBOutlet weak private var tableview: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        tableview.dataSource = self
        tableview.delegate  = self
        tableview.tableFooterView = UIView()
        tableview.registerNib(UINib(nibName: InvestViewCell.className, bundle: nil), forCellReuseIdentifier: InvestViewCell.className)
    }
}

//MARK: Property
extension InvestView {
    private var dataArray: NSArray? {
        guard let array = ResourcesHelper.readFilePlist("InvestViewPlist") else {
            return []
        }
        return array as [AnyObject]
    }
}

//MARK: Action
extension InvestView {
    @IBAction func actionQuestion(sender: AnyObject) {
        QuestionPopup.showQuestionPopup { (data, error) -> Void in
            
        }
    }
    
    @IBAction func actionIntrested(sender: AnyObject) {
        IntrestedPopup.showQuestionPopup(self) { (data, error) -> Void in
            print("block")
        }
    }
}

//MARK: Datasource
extension InvestView: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier(InvestViewCell.className, forIndexPath: indexPath) as! InvestViewCell
        cell.objectInvest = self.dataArray![indexPath.row]
        return cell
    }
}

//MARK: DeleGate
extension InvestView: UITableViewDelegate {
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(HeightForRow)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}