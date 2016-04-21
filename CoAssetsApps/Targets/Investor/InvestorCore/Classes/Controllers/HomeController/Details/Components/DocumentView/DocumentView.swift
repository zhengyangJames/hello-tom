//
//  DocumentView.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import PureLayout

private let heightHeaderView = 93*AppDefine.ScreenSize.ScreenScale
private let heightForSection = 48*AppDefine.ScreenSize.ScreenScale
private let heightForRow     = 63*AppDefine.ScreenSize.ScreenScale

class DocumentView: COTabView {
    weak var parentController: OfferDetailsController!
    @IBOutlet weak private var tableview: UITableView!
    @IBOutlet weak private var questionButton: COButton!
    weak var questionPopup: QuestionPopup?
    
    var documents: [[String:[COOfferDocumentItem]]]? {
        return loadData()
    }
    
    func loadData() -> [[String:[COOfferDocumentItem]]] {
        var documentArray = [[String:[COOfferDocumentItem]]]()
        if let _ = parentController {
            let documents = parentController.offerModel.documents
            let sectionTitleArray = [m_local_string("declaration_form_list"), m_local_string("registration_form_list"), m_local_string("licenses"), m_local_string("ownership"), m_local_string("legal_appointment"), m_local_string("others")]
            let privateValueArray = [[COOfferDocumentItem(title: m_local_string("declaration_private"), url: "")],
            [COOfferDocumentItem(title: m_local_string("comapny_private"), url: "")],
            [COOfferDocumentItem(title: m_local_string("licenses_private"), url: "")],
            [COOfferDocumentItem(title: m_local_string("ownership_private"), url: "")],
            [COOfferDocumentItem(title: m_local_string("legal_appointment_private"), url: "")],
            [COOfferDocumentItem(title: m_local_string("others_private"), url: "")]]
            let valueSectionArray = [documents.declarationFormList, documents.registrationFormList, documents.licenses, documents.ownership, documents.legalAppointment, documents.others]
            for var i = 0; i < sectionTitleArray.count; i++ {
                var sectionDiction = [String:[COOfferDocumentItem]]()
                let value = valueSectionArray[i]
                if value.isEmpty == false {
                    sectionDiction[sectionTitleArray[i]] = value

                } else {
                    sectionDiction[sectionTitleArray[i]] = privateValueArray[i]
                }
                documentArray.append(sectionDiction)
            }
        }
        return documentArray
    }
    
    func reloadData() {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.tableview.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        tableview.registerCellNib(DocumentHeaderCell)
        tableview.registerCellNib(DocumentViewCell)
        tableview.dataSource = self
        tableview.delegate   = self
        tableview.tableFooterView = UIView()
        tableview.tableHeaderView = setupHeaderView()
        
        questionButton.setTitle(m_local_string("BUTTON_I'VE_QUESTION"), forState: UIControlState.Normal)
    }
}

//MARK: Private
extension DocumentView {
    private func setupHeaderView() -> UIView {
        let headerView = UIView()
        headerView.frame.size.height = CGFloat(heightHeaderView)
        
        let viewFooter = UIView()
        viewFooter.backgroundColor = AppDefine.AppColor.COGrayColor
        headerView.addSubview(viewFooter)
        viewFooter.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 0)
        viewFooter.autoPinEdgeToSuperviewEdge(ALEdge.Leading, withInset: 0)
        viewFooter.autoPinEdgeToSuperviewEdge(ALEdge.Trailing, withInset: 0)
        viewFooter.autoSetDimension(ALDimension.Height, toSize: 0.5)
        
        let contentLabel = BaseLabel()
        contentLabel.textColor = AppDefine.AppColor.COGrayColorText
        contentLabel.font = UIFont(name: AppDefine.AppFontName.COAvenirBook,
            size: 15*AppDefine.ScreenSize.ScreenScale)
        contentLabel.numberOfLines = 0
        contentLabel.text = m_local_string("TITLE_HEADER_DOCUMENT")
        headerView.addSubview(contentLabel)
        contentLabel.autoPinEdgeToSuperviewEdge(ALEdge.Leading,
            withInset: 16*AppDefine.ScreenSize.ScreenScale)
        contentLabel.autoPinEdgeToSuperviewEdge(ALEdge.Trailing,
            withInset: 16*AppDefine.ScreenSize.ScreenScale)
        contentLabel.autoPinEdgeToSuperviewEdge(ALEdge.Top,
            withInset: -5*AppDefine.ScreenSize.ScreenScale)
        contentLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top,
            ofView: viewFooter, withOffset: 0)
        return headerView
    }
}

//MARK: Datasource
extension DocumentView:UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let myDocument = documents where documents?.isEmpty == false {
            let document = myDocument[section]
            let value = document.values.first
            if let value = value where value.isEmpty == false {
                return value.count + 1
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
        if indexPath.row == 0 {
            return headerDocumentCell(tableview, cellForRowAtIndexPath: indexPath)
        }
        return documentCell(tableview, cellForRowAtIndexPath: indexPath)
    }
}

//MARK: Cells
extension DocumentView {
    private func documentCell(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCellWithIdentifier(DocumentViewCell.className,
            forIndexPath: indexPath) as? DocumentViewCell {
            if let myDocument = documents where documents?.isEmpty == false {
                let document = myDocument[indexPath.section]
                let value = document.values.first
                if let value = value where value.isEmpty == false {
                    cell.documentItem = value[indexPath.row - 1]
                }
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    private func headerDocumentCell(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
        
        if let cell = tableview.dequeueReusableCellWithIdentifier(DocumentHeaderCell.className,
            forIndexPath: indexPath) as? DocumentHeaderCell {
            if let myDocument = documents where documents?.isEmpty == false {
                let document = myDocument[indexPath.section]
                let key = document.keys.first
                cell.titleLabel.text = key
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

//MARK: Delegate
extension DocumentView: UITableViewDelegate {
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath)
        -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(heightForSection)
        }
        return CGFloat(heightForRow)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath)
        -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableview.cellForRowAtIndexPath(indexPath) as? DocumentViewCell
        if let _ = cell {
            if let url = NSURL(string: cell!.documentItem?.url ?? "") {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
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

//MARK: Actions
extension DocumentView {
    @IBAction func actionQuestion(sender: AnyObject) {
        let popup = QuestionPopup.showQuestionPopup(m_local_string("QUESTION_TITLE"),
            shortDescription: m_local_string("TITLE_QUESTION_HOME"),
            content: "") { (content) -> Void in
                UIHelper.showLoadingInView()
                OfferService().postOfferQuestion(offerId: self.parentController.offerModel.offerID,
                    question: content) { (data, error) -> Void in
                        UIHelper.hideLoadingFromView()
                        if error == nil && data != nil {
                            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                                let alert = UIHelper.alertView(nil, message: m_local_string("MESSAGE_QUESTION_CONTENT"))
                                alert.addButtonWithAction(m_local_string("TITLE_DONE")) { (UIMyAlertAction) -> Void in
                                    self.questionPopup?.popView()
                                }
                                alert.show()
                            })
                        } else {
                            // show error
                            print(error)
                        }
                }
            }
        questionPopup = popup
        questionPopup?.errorMessage = m_local_string("MESSAGE_QUESTION_NOT_CONTENT")
    }
}
