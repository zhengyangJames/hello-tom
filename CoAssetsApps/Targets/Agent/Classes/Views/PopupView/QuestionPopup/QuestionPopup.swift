//
//  QuestionPopup.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/15/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

public typealias Completion1 = (data: AnyObject?, error:NSError?) -> Void

class QuestionPopup: BasePopup {
    
    @IBOutlet weak private var contentTextView: UITextView!
    @IBOutlet weak private var bottomConstrain: NSLayoutConstraint!
    @IBOutlet weak private var headerView: UIView!
    @IBOutlet weak private var scrollView: UIScrollView!
    
    var complete: Completion?
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap1 = UITapGestureRecognizer(target: self, action: "tapContentView")
        let tap2 = UITapGestureRecognizer(target: self, action: "tapContentView")
        
        headerView.addGestureRecognizer(tap1)
        scrollView.addGestureRecognizer(tap2)
    }
    
    override func keyboardWillShow(notification: NSNotification) {
        super.keyboardWillShow(notification)
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let durationTemp = info[UIKeyboardAnimationDurationUserInfoKey]
        let duration = NSTimeInterval(durationTemp as! NSNumber)
        UIView.animateWithDuration(duration) { () -> Void in
            self.bottomConstrain.constant = keyboardFrame.size.height
            self.layoutIfNeeded()
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        super.keyboardWillHide(notification)
        let info = notification.userInfo!
        let durationTemp = info[UIKeyboardAnimationDurationUserInfoKey]
        let duration = NSTimeInterval(durationTemp as! NSNumber)
        UIView.animateWithDuration(duration) { () -> Void in
            self.bottomConstrain.constant = 16.0
            self.layoutIfNeeded()
        }
    }
    
    func tapContentView() {
        self.endEditing(true)
    }
    
}

//MARK: - Static func
extension QuestionPopup {
    class func showQuestionPopup(complete: Completion) {
        let questionPopup = UIView.loadFromNibNamed("QuestionPopup") as! QuestionPopup
        questionPopup.complete = complete
        questionPopup.translatesAutoresizingMaskIntoConstraints = false
        kAppDelegate!.window?.addSubview(questionPopup)
        questionPopup.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
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
            self.alertView(nil, message: m_local_string("MESSAGE_QUESTION_NOT_CONTENT"), titleButton: m_local_string("TITLE_BUTTON_OK"), dismisView: false)
        } else {
            self.alertView(nil, message: m_local_string("MESSAGE_QUESTION_CONTENT"), titleButton: m_local_string("TITLE_DONE"), dismisView: true)
        }
    }
}