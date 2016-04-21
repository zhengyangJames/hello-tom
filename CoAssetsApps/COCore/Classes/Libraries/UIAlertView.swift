//
//  UIMyAlertView.swift
//  Dung_NMBT04
//
//  Created by Junest Developer on 12/18/15.
//  Copyright © 2015 JCStudio. All rights reserved.
//

import UIKit

let constrainTopToSubview   = 16.0
let minWidthButton   = 70.0

//ENUM
public enum UIMyAlertViewStyle: Int {
    case Default
    case PlainTextInput
}


//MARK: DELEGATE
protocol UIMyAlertViewDelegate {
    func didSelectAtButton(alertView: UIAlertView, button: UIButton, inputtedValue: String?, tag: Int)
}

//MARK: ALIAS
typealias AlertAction = ()

let WIDTH = (UIApplication.sharedApplication().delegate?.window!!.frame.width)! * 3.5 / 2 < 320 ?
    (UIApplication.sharedApplication().delegate?.window!!.frame.width)! * 3.5 / 2 : 304
let HEIGHT = WIDTH / 9

class UIAlertView: UIView {
    private var actions: Array< (AlertAction) -> Void>?
    private var btnTitles = [String]()
    var delegate: UIMyAlertViewDelegate?
    var title: UILabel?
    var message: UILabel?
    var text: String?
    var font = UIFont.systemFontOfSize(15)
    var titleFont = UIFont.boldSystemFontOfSize(15)
    var alertBackgroundColor = UIColor.whiteColor()
    var alertContentTextColor = UIColor.whiteColor()
    var alertButtonBackgroundColor = UIColor.redColor()
    var alertButtonTextColor = UIColor.whiteColor()
    var alertCornerRadius = 4.0 as CGFloat
    private var inputMessage: UITextField?
    private var subInView: UIView?
    private var dismissOnTappingOutside = false
    
    //MARK: INIT
    convenience init(title: String?, message: String?,
        alertStyle: UIMyAlertViewStyle, dismissOnTappingOutside: Bool) {
        self.init()
        self.title = UILabel()
        self.title?.text = title
        self.message = UILabel()
        self.message?.text = message
        if alertStyle == .PlainTextInput {
            inputMessage = UITextField(frame: CGRectMake(0, 0, WIDTH * 4 / 5, HEIGHT))
        }
        self.dismissOnTappingOutside = dismissOnTappingOutside
    }
    
    //MARK: OVERRIDE
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let window = UIApplication.sharedApplication().delegate?.window
        var location = touch?.locationInView(window!)
        location = convertPoint(location!, toView: nil)
        if !CGRectContainsPoint(self.subInView!.frame, location!) && dismissOnTappingOutside {
            dismiss()
        }
    }
}

//MARK: SHOW HIDE
extension UIAlertView {
    private func visible(completion: ((Bool) -> Void)?) {
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.backgroundColor = UIColor(white: 0, alpha: 0.4)
            self.layer.opacity = 1
            self.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }, completion: completion)
        createAlertView()
    }
    
    func show() {
        visible(nil)
    }
    
    func dismiss() {
        inputMessage?.resignFirstResponder()
        close(nil)
    }
    
    private func close(completion: ((Bool) -> Void)?) {
        let currentTransform = self.layer.transform
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.backgroundColor = UIColor(white: 0, alpha: 0)
//            self.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
            self.layer.opacity = 0
            }, completion: { (finished: Bool) in
                for view in self.subviews as [UIView] {
                    view.removeFromSuperview()
                }
                self.removeFromSuperview()
                completion?(finished)
        })
    }
}

//MARK: ACTIONS
extension UIAlertView: UITextFieldDelegate {
    func clickAction(sender: UIButton) {
        dismiss()
        text = inputMessage?.text!
        self.actions![sender.tag]()
        
    }
}

//MARK: FUNCTIONS
extension UIAlertView {
    
    func addButtonWithAction(title: String, handler: ((AlertAction) -> Void)?) {
        if actions == nil {
            actions = []
        }
        btnTitles.append(title)
        if let _ = handler {
            actions!.append(handler!)
        } else {
            let voidAction = { () -> () in
            self.dismiss()
        }
            actions!.append(voidAction)
        }
    }
    
    //set color, style of title, content by using default funtions of title and message variales as UILabel
}

//MARK: SET UP
extension UIAlertView {
    private func initUI() {
        self.title?.textAlignment = .Center
        self.title?.textColor = self.alertContentTextColor
        self.title?.font = self.titleFont
        self.title?.backgroundColor = UIColor.clearColor()
        self.title?.numberOfLines = 0
        self.title?.lineBreakMode = .ByWordWrapping
        self.message?.numberOfLines = 0
        self.message?.textColor = self.alertContentTextColor
        self.message?.font = self.font
        self.message?.lineBreakMode = .ByWordWrapping
        self.message?.textAlignment = .Center
        self.message?.backgroundColor = UIColor.clearColor()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.title?.translatesAutoresizingMaskIntoConstraints = false
        self.message?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // swiftlint:disable function_body_length
    private func createAlertView() {
        initUI()
        subInView = UIView()
        subInView?.backgroundColor = self.alertBackgroundColor
        subInView?.layer.cornerRadius = self.alertCornerRadius
        subInView!.translatesAutoresizingMaskIntoConstraints = false
        let widthSubInView = NSLayoutConstraint(item: subInView!,
            attribute: .Width, relatedBy: .Equal, toItem: nil,
            attribute: .NotAnAttribute, multiplier: 1.0, constant: WIDTH)
        subInView!.addConstraint(widthSubInView)
        
        //Layout for title
        let heightLabelValue = updateHeightForLabel(title!)
        let widthLabel = NSLayoutConstraint(item: self.title!,
            attribute: .Width, relatedBy: .Equal, toItem: nil,
            attribute: .NotAnAttribute, multiplier: 1.0, constant: WIDTH * 4 / 5)
        let heightLabel = NSLayoutConstraint(item: self.title!,
            attribute: .Height, relatedBy: .Equal, toItem: nil,
            attribute: .NotAnAttribute, multiplier: 1, constant: heightLabelValue)
        title!.addConstraints([heightLabel, widthLabel])
        subInView!.addSubview(title!)
        
        //Layout for message
        let heightTextFieldValue = updateHeightForLabel(message!)
        let widthTextField = NSLayoutConstraint(item: self.message!,
            attribute: .Width, relatedBy: .Equal, toItem: nil,
            attribute: .NotAnAttribute, multiplier: 1.0, constant: WIDTH * 4 / 5)
        let heightTextField = NSLayoutConstraint(item: self.message!,
            attribute: .Height, relatedBy: .Equal, toItem: nil,
            attribute: .NotAnAttribute, multiplier: 1, constant: heightTextFieldValue)
        self.message?.addConstraints( [heightTextField, widthTextField] )
        subInView!.addSubview(message!)
        
        //Layout for input message
        var ipnutMessageHeight = HEIGHT
        if inputMessage == nil {
            ipnutMessageHeight = 0.0
            inputMessage = UITextField(frame: CGRectMake(0, 0, WIDTH * 4 / 5, ipnutMessageHeight))
        }
        self.inputMessage?.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
        inputMessage?.translatesAutoresizingMaskIntoConstraints = false
        let widthIpnutMessage = NSLayoutConstraint(item: self.inputMessage!,
            attribute: .Width, relatedBy: .Equal, toItem: nil,
            attribute: .NotAnAttribute, multiplier: 1.0, constant: WIDTH - 40)
        let heightIpnutMessage = NSLayoutConstraint(item: self.inputMessage!,
            attribute: .Height, relatedBy: .Equal, toItem: nil,
            attribute: .NotAnAttribute, multiplier: 1, constant: ipnutMessageHeight)
        self.inputMessage?.addConstraints([heightIpnutMessage, widthIpnutMessage])
        self.inputMessage?.clearsOnBeginEditing = true
        subInView!.addSubview(inputMessage!)
        
        let topLabel = NSLayoutConstraint(item: self.title!,
            attribute: .Top, relatedBy: .Equal, toItem: subInView,
            attribute: .Top, multiplier: 1.0, constant: CGFloat(constrainTopToSubview))
        let leftLabel = NSLayoutConstraint(item: self.title!, attribute:
            .Left, relatedBy: .Equal, toItem: subInView, attribute: .Left, multiplier: 1.0, constant: WIDTH / 10)
        let topTextField = NSLayoutConstraint(item: self.message!,
            attribute: .Top, relatedBy: .Equal, toItem: self.title!,
            attribute: .Bottom, multiplier: 1.0, constant: 0)
        let leftTextField = NSLayoutConstraint(item: self.message!,
            attribute: .Left, relatedBy: .Equal, toItem: subInView,
            attribute: .Left, multiplier: 1.0, constant: WIDTH / 10)
        let topInputMessage = NSLayoutConstraint(item: self.inputMessage!,
            attribute: .Top, relatedBy: .Equal, toItem: self.message!,
            attribute: .Bottom, multiplier: 1.0, constant: 0)
        let leftInputMessage = NSLayoutConstraint(item: self.inputMessage!,
            attribute: .Left, relatedBy: .Equal, toItem: subInView,
            attribute: .Left, multiplier: 1.0, constant: 20)
        subInView!.addConstraints( [topTextField, topLabel, leftLabel, leftTextField, topInputMessage, leftInputMessage] )
        addButtonsToView()
        setAlertViewToWindow()
    }
    
    // swiftlint:disable function_body_length
    private func addButtonsToView() {
        weak var temp: UIButton?
        if btnTitles.count > 2 {
            for i in 0...btnTitles.count - 1 {
                let newButton = UIButton()
                newButton.translatesAutoresizingMaskIntoConstraints = false
                newButton.tag = i
                newButton.titleLabel?.numberOfLines = 0
                newButton.titleLabel?.lineBreakMode = .ByWordWrapping
                newButton.setTitle(btnTitles[i], forState: .Normal)
                newButton.backgroundColor = self.alertButtonBackgroundColor
                newButton.titleLabel?.font = UIFont(name: "Avenir-Roman", size: 13.5)
                newButton.setTitleColor(self.alertButtonTextColor, forState: .Normal)
                newButton.addTarget(self, action: "clickAction:", forControlEvents: .TouchUpInside)
                let widthButton = NSLayoutConstraint(item: newButton,
                    attribute: .Width, relatedBy: .Equal, toItem: nil,
                    attribute: .NotAnAttribute, multiplier: 1, constant: WIDTH - 60)
                let heightButton = NSLayoutConstraint(item: newButton,
                    attribute: .Height, relatedBy: .Equal, toItem: nil,
                    attribute: .NotAnAttribute, multiplier: 1, constant: HEIGHT)
                newButton.addConstraints( [widthButton, heightButton] )
                subInView!.addSubview(newButton)
                let leftButton = NSLayoutConstraint(item: newButton,
                    attribute: .Left, relatedBy: .Equal, toItem: subInView,
                    attribute: .Left, multiplier: 1, constant: 30)
                if i == 0 {
                    let topButton = NSLayoutConstraint(item: newButton,
                        attribute: .Top, relatedBy: .Equal,
                        toItem: inputMessage!, attribute: .Bottom, multiplier: 1, constant: 8)
                    subInView!.addConstraint(topButton)
                } else {
                    let topButton = NSLayoutConstraint(item: newButton,
                        attribute: .Top, relatedBy: .Equal, toItem: temp!,
                        attribute: .Bottom, multiplier: 1, constant: 8)
                    subInView!.addConstraint(topButton)
                }
                subInView!.addConstraint(leftButton)
                temp = newButton
            }
        } else if btnTitles.count > 1 {
            for i in 0...btnTitles.count - 1 {
                let newBtn = UIButton()
                newBtn.translatesAutoresizingMaskIntoConstraints = false
                newBtn.tag = i
                newBtn.titleLabel?.numberOfLines = 0
                newBtn.titleLabel?.lineBreakMode = .ByWordWrapping
                newBtn.titleLabel?.font = UIFont(name: "Avenir-Roman", size: 13.5)
                newBtn.setTitle(btnTitles[i], forState: .Normal)
                newBtn.backgroundColor = self.alertButtonBackgroundColor
                newBtn.setTitleColor(self.alertButtonTextColor, forState: .Normal)
                newBtn.addTarget(self, action: "clickAction:", forControlEvents: .TouchUpInside)
                
                let contact = (WIDTH - WIDTH / 8 * ( CGFloat(btnTitles.count - 1) + 2)) / CGFloat(btnTitles.count)
                let widthButton = NSLayoutConstraint(item: newBtn,
                    attribute: .Width, relatedBy: .Equal, toItem: nil,
                    attribute: .NotAnAttribute, multiplier: 1, constant:contact )
                
                let heightButton = NSLayoutConstraint(item: newBtn,
                    attribute: .Height, relatedBy: .Equal, toItem: nil,
                    attribute: .NotAnAttribute, multiplier: 1, constant: HEIGHT)
                newBtn.addConstraints( [widthButton, heightButton] )
                subInView!.addSubview(newBtn)
                let topButton = NSLayoutConstraint(item: newBtn,
                    attribute: .Top, relatedBy: .Equal, toItem: inputMessage!,
                    attribute: .Bottom, multiplier: 1, constant: 8)
                if i == 0 {
                    let leftButton = NSLayoutConstraint(item: newBtn,
                        attribute: .Left, relatedBy: .Equal, toItem: subInView,
                        attribute: .Left, multiplier: 1, constant: WIDTH / 8)
                    subInView!.addConstraint(leftButton)
                } else {
                    let leftButton = NSLayoutConstraint(item: newBtn,
                        attribute: .Left, relatedBy: .Equal, toItem: temp,
                        attribute: .Right, multiplier: 1, constant: WIDTH / 8)
                    subInView!.addConstraint(leftButton)
                }
                subInView!.addConstraint(topButton)
                temp = newBtn
            }
        } else if btnTitles.count == 1 {
            let newButton = UIButton()
            newButton.translatesAutoresizingMaskIntoConstraints = false
            newButton.tag = 0
            newButton.titleLabel?.numberOfLines = 0
            newButton.titleLabel?.lineBreakMode = .ByWordWrapping
            newButton.titleLabel?.font = UIFont(name: "Avenir-Roman", size: 13.5)
            newButton.setTitle(btnTitles[0], forState: .Normal)
            newButton.backgroundColor = self.alertButtonBackgroundColor
            newButton.setTitleColor(self.alertButtonTextColor, forState: .Normal)
            newButton.addTarget(self, action: "clickAction:", forControlEvents: .TouchUpInside)
            let widthButton = NSLayoutConstraint(item: newButton,
                attribute: .Width, relatedBy: .Equal, toItem: nil,
                attribute: .NotAnAttribute, multiplier: 1, constant: updateWidthForButton(newButton))
            let heightButton = NSLayoutConstraint(item: newButton,
                attribute: .Height, relatedBy: .Equal, toItem: nil,
                attribute: .NotAnAttribute, multiplier: 1, constant: HEIGHT)
            newButton.addConstraints( [widthButton, heightButton] )
            subInView!.addSubview(newButton)
            let topButton = NSLayoutConstraint(item: newButton,
                attribute: .Top, relatedBy: .Equal, toItem: inputMessage!,
                attribute: .Bottom, multiplier: 1, constant: 8)
                let leftButton = NSLayoutConstraint(item: newButton,
                    attribute: .Left, relatedBy: .Equal,
                    toItem: subInView, attribute: .Left, multiplier: 1,
                    constant: (WIDTH - updateWidthForButton(newButton)) / 2 - 3)
                subInView!.addConstraints( [leftButton, topButton] )
        }
    }
    
    private func setAlertViewToWindow() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        let window = UIApplication.sharedApplication().delegate?.window
        window?!.addSubview(self)
        let top = NSLayoutConstraint(item: self, attribute: .Top,
            relatedBy: .Equal, toItem: window!, attribute: .Top, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: self, attribute: .Left,
            relatedBy: .Equal, toItem: window!, attribute: .Left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: self, attribute: .Right,
            relatedBy: .Equal, toItem: window!, attribute: .Right, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: self, attribute: .Bottom,
            relatedBy: .Equal, toItem: window!, attribute: .Bottom, multiplier: 1, constant: 0)
        window!!.addConstraints([top, left, right, bottom])
        let height = updateHeightOfAlertView()
        let heightSubInView = NSLayoutConstraint(item: subInView!,
            attribute: .Height, relatedBy: .Equal, toItem: nil,
            attribute: .NotAnAttribute, multiplier: 1.0, constant: height)
        subInView!.addConstraint(heightSubInView)
        self.insertSubview(subInView!, aboveSubview: self)
        let centerY = NSLayoutConstraint(item: subInView!,
            attribute: .CenterY, relatedBy: .Equal, toItem: self,
            attribute: .CenterY, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint(item: subInView!,
            attribute: .CenterX, relatedBy: .Equal, toItem: self,
            attribute: .CenterX, multiplier: 1, constant: 0)
        self.addConstraints( [centerX, centerY] )
    }
}

//MARK: HELPERS
extension UIAlertView {
    private func updateHeightOfAlertView() -> CGFloat {
        let inputHeight = (inputMessage!.frame.height) + 10
        let subTotal = updateHeightForLabel(message!) +
            updateHeightForLabel(title!) + inputHeight + CGFloat(2*constrainTopToSubview)
        if btnTitles.count > 2 {
            return CGFloat(btnTitles.count) * ( 5 + HEIGHT ) + subTotal
        } else if btnTitles.isEmpty == false {
            return HEIGHT + subTotal
        }
        return subTotal
        
    }
    
    private func updateHeightForLabel(label: UILabel) -> CGFloat {
        let tempView = UILabel()
        tempView.frame = CGRect(x: 0, y: 0, width: WIDTH * 4 / 5, height: 0)
        tempView.numberOfLines = 0
        tempView.lineBreakMode = .ByWordWrapping
        tempView.font = label.font
        tempView.text = label.text
        tempView.sizeToFit()
        return (tempView.frame.height) == 0 ? 0 : (tempView.frame.height) + 7.0
    }
    
    private func updateWidthForButton(button: UIButton) -> CGFloat {
        let tempView = UIButton()
        tempView.frame = CGRect(x: 0, y: 0, width: 0, height: HEIGHT)
        tempView.titleLabel!.font = button.titleLabel!.font
        tempView.setTitle(button.titleLabel?.text, forState: .Normal)
        tempView.sizeToFit()
        var tempWidth = tempView.frame.width + 10
        if tempWidth < CGFloat(minWidthButton) {
            tempWidth = CGFloat(minWidthButton)
        }
        return tempWidth
    }
}
