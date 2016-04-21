//
//  CoAssetsStockViewController.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 04/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

let kStockIcon = "kStockIcon"
let kStockCode = "kStockCode"
let kStockCurrency = "kStockCurrency"
let kStockPrice = "kStockPrice"
let kStockDate = "kStockDate"

class CoAssetsStockViewController: BaseViewController {
    
    @IBOutlet weak private var icon: UIImageView!
    @IBOutlet weak private var interestButton: CORedButton!
    @IBOutlet weak private var testLabel4: UILabel!
    @IBOutlet weak private var testLabel1: UILabel!
    @IBOutlet weak private var testLabel2: UILabel!
    @IBOutlet weak private var testLabel3: UILabel!
    
    weak var questionPopup: QuestionPopup?
    var errorMessage: String! = ""
    lazy var stockProfile: COStockProfileModel = {
        return COStockProfileModel()
    }()
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        refreshUI()
        testLabel3.font = UIFont(
            name: AppDefine.AppFontName.COAvenirMedium,
            size: testLabel3.font.pointSize * AppDefine.ScreenSize.ScreenScale)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        callAPIGetStockProfile()
    }
    
    
    //MARK: - Setup
    private func setupUI() {
        title = m_local_string("COASSETSSTOCK")
        interestButton.setTitle(m_local_string("stock_i_invest"), forState: .Normal)
    }
    
    //MARK: Data
    func refreshUI() {
        if NSThread.isMainThread() {
            updateUIInMainTheard()
        } else {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.updateUIInMainTheard()
            })
        }
    }
    
    private func updateUIInMainTheard() {
        let dateString = self.stockProfile.stockPriceDate != nil ? self.stockProfile.stockPriceDate! : ""
        let attributeFormartedNormal = [ NSFontAttributeName: UIFont(
            name: AppDefine.AppFontName.COAvenirMedium,
            size: 14 * AppDefine.ScreenSize.ScreenScale)!,
            NSForegroundColorAttributeName: UIColor.blackColor()]
        let dateStringF = NSMutableAttributedString(string:  dateString, attributes: attributeFormartedNormal)
        let codeStringF = NSMutableAttributedString(string:  self.stockProfile.stockCode, attributes: attributeFormartedNormal)
        let attributeFormartedBlack = [ NSFontAttributeName: UIFont(
            name: AppDefine.AppFontName.COAvenirBlack,
            size: 17 * AppDefine.ScreenSize.ScreenScale)!,
            NSForegroundColorAttributeName: UIColor.blackColor()]
        let stringCurrencyStock = self.stockProfile.stockCurrency + " " + "\(self.stockProfile.stockPrice)"
        let stringCurrencyF = NSMutableAttributedString(string:  stringCurrencyStock, attributes: attributeFormartedBlack)
        
        testLabel1.attributedText = codeStringF
        testLabel2.attributedText = stringCurrencyF
        testLabel3.text =  m_local_string("stock_date_x")
        testLabel4.attributedText = dateStringF
    }
    
    //MARK: actions
    @IBAction func __actionInterest(sender: UIButton) {
        let popup = QuestionPopup.showQuestionPopup(m_local_string("MESSAGE_TITLE_STOCK"), shortDescription: "", content: m_local_string("MESSAGE_STOCK")) { (content) -> Void in
            var mess: String = ""
            if content.isEmpty == false {
                mess = content
            } else {
                mess = m_local_string("MESSAGE_STOCK")
            }
            self.callAPIPostInterestedMessage(mess)
        }
        questionPopup = popup
        questionPopup!.errorMessage = m_local_string("MESSAGE_QUESTION_NOT_CONTENT")

    }
}

//MARK: - API
extension CoAssetsStockViewController {

    func callAPIGetStockProfile() {
        UIHelper.showLoadingInView()
        let listContact = ListContact()
        listContact.getStockPrice { (data, error) -> Void in
            if error == nil {
                if let stockProfile = data as? COStockProfileModel {
                    self.stockProfile = stockProfile
                    self.refreshUI()
                }
            }
            UIHelper.hideLoadingFromView()
        }
    }
    
    func callAPIPostInterestedMessage(message: String) {
        UIHelper.showLoadingInView()
        let profileService = ProfileService()
        profileService.postInvestedMessage(message) { (data, error) -> Void in
            if error == nil {
                if let message = data?.object.objectForKey("message") as? String {
                    let alert = UIHelper.alertView(nil, message: message)
                    alert.addButtonWithAction(m_local_string("TITLE_DONE")) { (UIMyAlertAction) -> Void in
                        self.questionPopup!.popView()
                    }
                    alert.show()
                }
                
            }
            UIHelper.hideLoadingFromView()
        }
    }
}
