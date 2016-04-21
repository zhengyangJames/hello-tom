//
//  QuestionPopup.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/15/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

public typealias CallBack = (content: String) -> Void

class QuestionPopup: BasePopup {
    
    @IBOutlet weak private var contentTextView: UITextView!
    @IBOutlet weak private var bottomConstrain: NSLayoutConstraint!
    @IBOutlet weak private var headerView: UIView!
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var shortDescriptionLabel: UILabel!
    @IBOutlet weak private var doneButton: CORedButton!
    private var actionDone: CallBack?
    private var title: String! = ""
    private var shortDescription: String! = ""
    private var content: String! = ""
    var errorMessage: String! = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap1 = UITapGestureRecognizer(target: self, action: "tapContentView")
        let tap2 = UITapGestureRecognizer(target: self, action: "tapContentView")
        
        headerView.addGestureRecognizer(tap1)
        scrollView.addGestureRecognizer(tap2)
        doneButton.setTitle(m_local_string("DONE_TITLE"), forState: UIControlState.Normal)
    }
    
    override func keyboardWillShow(notification: NSNotification) {
        super.keyboardWillShow(notification)
        let info = notification.userInfo!
        let durationTemp = info[UIKeyboardAnimationDurationUserInfoKey]
        if let infoValue = info[UIKeyboardFrameEndUserInfoKey] as? NSValue, durationTempNumber = durationTemp as? NSNumber {
            let keyboardFrame: CGRect = infoValue.CGRectValue()
            let duration = NSTimeInterval(durationTempNumber)
            UIView.animateWithDuration(duration) { () -> Void in
                self.bottomConstrain.constant = keyboardFrame.size.height
                self.layoutIfNeeded()
            }
        }
        
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        super.keyboardWillHide(notification)
        let info = notification.userInfo!
        let durationTemp = info[UIKeyboardAnimationDurationUserInfoKey]
        if let durationNumber = durationTemp as? NSNumber {
            let duration = NSTimeInterval(durationNumber)
            UIView.animateWithDuration(duration) {() -> Void in
                self.bottomConstrain.constant = 8.0
                self.layoutIfNeeded()
            }
        }
    }
    
    func tapContentView() {
        self.endEditing(true)
    }
    
    func reloadData() {
        titleLabel.text = title
        shortDescriptionLabel.text = shortDescription
        contentTextView.text = content
    }
    
}

//MARK: - Static func
extension QuestionPopup {
    class func showQuestionPopup(title: String, shortDescription: String, content: String, callBack: CallBack) -> QuestionPopup? {
        if let questionPopup = UIView.awakeFromNib(QuestionPopup.className) as? QuestionPopup, myAppDelegate = kAppDelegate {
            questionPopup.actionDone = callBack
            questionPopup.title = title
            questionPopup.shortDescription = shortDescription
            questionPopup.content = content
            questionPopup.reloadData()
            questionPopup.translatesAutoresizingMaskIntoConstraints = false
            myAppDelegate.window?.addSubview(questionPopup)
            questionPopup.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
            return questionPopup
        }
        return nil
    }
}

//MARK: Action
extension QuestionPopup {
    private func alertView(title: String?, message: String, titleButton: String, dismisView: Bool) {
        let alert = UIHelper.alertView(title, message: message)
        alert.addButtonWithAction(titleButton) { (UIMyAlertAction) -> Void in
            if dismisView == true {
                self.popView()
            }
        }
        alert.show()
    }
}
//MARK: Action
extension QuestionPopup {
    @IBAction func actionClose(sender: AnyObject) {
        self.popView()
    }
    
    @IBAction func actionSubmit(sender: AnyObject) {
        self.endEditing(true)
        if contentTextView.text.isEmpty == true {
            self.alertView(nil, message: errorMessage, titleButton: m_local_string("TITLE_BUTTON_OK"), dismisView: false)
        } else {
            if let callback = actionDone {
                callback(content: contentTextView.text.trim())
//                self.popView()
            }
        }
    }
}
