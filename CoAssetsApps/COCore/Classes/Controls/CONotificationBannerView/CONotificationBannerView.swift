//
//  CONotificationBannerView.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/16/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

protocol CONotificationBannerViewDelegate {
    func actionTapBannerView(notificationView: CONotificationBannerView, args: AnyObject?)
}

struct BannerViewTag {
    static let tagView = 686869
}

class CONotificationBannerView: BaseView {
    var imageLogoApp: UIImageView!
    var titleApp: UILabel!
    var messageApp: UILabel!
    var buttonTap: UIButton!
    var delegate: CONotificationBannerViewDelegate?
    var args: AnyObject?
    
    //Setter, getter
    var textMessage: String? {
        didSet {
            if let myTextMessage = textMessage {
                messageApp?.text = myTextMessage
            }
        }
    }
    
    override func viewDidLoad() {
        let with = UIScreen.mainScreen().bounds.size.width
        let height = 70
        self.frame = CGRect(x: 0, y: 0, width: Int(with), height: height)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
        self.tag = BannerViewTag.tagView
        setupUI()
    }
}

//MARK: Private
extension CONotificationBannerView {
    private func setupUI() {
        creatLayout()
    }
    
    private func creatLayout() {
        var views = [String:NSObject]()
        var allConstraints = [NSLayoutConstraint]()
        //Creat Logo
        let imageLogoApp = UIImageView.newAutoLayoutView()
        imageLogoApp.translatesAutoresizingMaskIntoConstraints = false
        imageLogoApp.image = UIImage(named: "AppIcon40x40")
        imageLogoApp.layer.cornerRadius = 8
        imageLogoApp.clipsToBounds = true
        self.addSubview(imageLogoApp)
        views["logo"] = imageLogoApp
        self.imageLogoApp = imageLogoApp
        let heightLG = NSLayoutConstraint.constraintsWithVisualFormat("V:[logo(==40)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += heightLG
        let widthhLG = NSLayoutConstraint.constraintsWithVisualFormat("H:[logo(==40)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += widthhLG
        let topLG = NSLayoutConstraint.constraintsWithVisualFormat("V:|-22-[logo]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += topLG
        let leadingLG = NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[logo]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += leadingLG
        
        //Creat title
        let titleApp = UILabel()
        titleApp.translatesAutoresizingMaskIntoConstraints = false
        titleApp.font = UIFont.systemFontOfSize(14)
        titleApp.text = m_local_string("APP_NAME")
        titleApp.textColor = UIColor.whiteColor()
        self.addSubview(titleApp)
        views["title"] = titleApp
        self.titleApp = titleApp
        let heightTL = NSLayoutConstraint.constraintsWithVisualFormat("V:[title(==18)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += heightTL
        let topTL = NSLayoutConstraint.constraintsWithVisualFormat("V:|-22-[title]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += topTL
        let rightTL = NSLayoutConstraint.constraintsWithVisualFormat("H:[title]-8-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += rightTL
        let leftTL = NSLayoutConstraint.constraintsWithVisualFormat("H:[logo]-8-[title]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += leftTL
        
        //Creat message
        let messageApp = UILabel()
        messageApp.translatesAutoresizingMaskIntoConstraints = false
        messageApp.font = UIFont.systemFontOfSize(14)
        messageApp.textColor = UIColor.whiteColor()
        self.addSubview(messageApp)
        views["message"] = messageApp
        self.messageApp = messageApp
        let heightMES = NSLayoutConstraint.constraintsWithVisualFormat("V:[message(==22)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += heightMES
        let topMES = NSLayoutConstraint.constraintsWithVisualFormat("V:[title]-4-[message]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += topMES
        let rightMES = NSLayoutConstraint.constraintsWithVisualFormat("H:[message]-8-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += rightMES
        let leftMES = NSLayoutConstraint.constraintsWithVisualFormat("H:[logo]-8-[message]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += leftMES
        
        //Creat Button Tap
        let buttonTap = UIButton()
        buttonTap.translatesAutoresizingMaskIntoConstraints = false
        buttonTap.backgroundColor = UIColor.clearColor()
        buttonTap.addTarget(self, action: "actionTapButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(buttonTap)
        views["button"] = buttonTap
        self.buttonTap = buttonTap
        let horizontalBTN = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[button]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += horizontalBTN
        let verticalBTN = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[button]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += verticalBTN
        
        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
}

//MARK: Action
extension CONotificationBannerView {
    func actionTapButton(sender: AnyObject) {
        self.delegate?.actionTapBannerView(self, args: self.args)
        dismissView()
    }
}

//MARK: Public
extension CONotificationBannerView {
    func show(showInView: UIView? = nil, isWillShow: (CONotificationBannerView -> Void)?) {
        isWillShow?(self)
        if let _ = showInView {
            showInView!.addSubview(self)
        } else {
            UIApplication.sharedApplication().keyWindow?.addSubview(self)
        }
        self.transform = CGAffineTransformMakeTranslation(0, -self.bounds.size.height)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: { (finnished) -> Void in
                if let superView = self.superview {
                    superView.bringSubviewToFront(self)
                }
                self.delayPerform()
        })
    }
    
    func dismissView() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.transform = CGAffineTransformMakeTranslation(0, -self.bounds.size.height)
            }, completion: { (finnished) -> Void in
                self.removeFromSuperview()
        })
    }
    
    func delayPerform() {
        NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: "dismissView", object: nil)
        self.performSelector("dismissView", withObject: nil, afterDelay: 4)
    }
}
