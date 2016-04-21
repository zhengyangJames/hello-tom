//
//  COLoadingView.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/17/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SVProgressHUD

enum ShowLoadingViewType: Int {
    case ShowNone = 0
    case ShowInApp = 1
}

class COLoadingView: BaseView {

    @IBOutlet weak var progressView: UIActivityIndicatorView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    class func wakeupAndSync(
        window: UIWindow? = UIApplication.sharedApplication().windows.last,
        showWithType: ShowLoadingViewType) {
        if let subviews = window?.subviews {
            for subview in subviews {
                if subview is COLoadingView {
                    return
                }
            }
        }
        
        if ConnectionManager.networkIsAvailable() == false {
            ConnectionManager.shared.isFirstTime = true
            let alertView = UIHelper.alertView(m_local_string("APP_NAME"), message: m_local_string("MESSAGE_ERROR_NETWORK"))
            alertView.addButtonWithAction(m_local_string("TITLE_BUTTON_OK"), handler: nil)
            alertView.show()
            return
        }
        
        if let loadingView = COLoadingView.loadNib() {
            window?.addSubview(loadingView)
            window?.bringSubviewToFront(loadingView)
            loadingView.backgroundImage.image = UIImage(named: loadingView.chooseImageBackground())
            loadingView.progressView.hidesWhenStopped = true
            loadingView.autoPinEdgesToSuperviewEdges()
            switch showWithType {
                case .ShowInApp: loadingView.animationShowInApp(loadingView); break
                case .ShowNone : loadingView.animationNone(loadingView); break
            }
        }
    }
    
    private func animationNone(loadingView: COLoadingView) {
        loadingView.initData()
    }
    
    private func animationShowInApp(loadingView: COLoadingView) {
        loadingView.transform = CGAffineTransformMakeScale(0.2, 0.2)
        UIView.animateWithDuration(0.3,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () -> Void in
                loadingView.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: { (completion: Bool) -> Void in
                loadingView.initData()
        })
    }
    
    private func chooseImageBackground() -> String {
        let imageName: String = "BG_FULL.png"
        return imageName
    }

    func initData() {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.progressView.startAnimating()
        }
        let tasks = SynchronizedArray<String>()
        tasks.completion = {
            ConnectionManager.shared.isFirstTime = true
            self.dismiss(nil)
        }
        if AuthManager.shared.hasAccessToken() {
            let myQueue = TaskQueue()
            myQueue.tasks += {_, next in
                print("complection task 2")
                self.loadDataOfferDetail({ (success, error) -> Void in
                    next(nil)
                })
            }
            myQueue.tasks += {_, next in
                print("complection task 1")
                self.syncDataProfile({ (success, error) -> Void in
                    next(nil)
                })
            }
            myQueue.run({
                ConnectionManager.shared.isFirstTime = true
                self.dismiss(nil)
                print("complection")
            })
        } else {
            tasks.append("Tasks1")
            loadDataOfferDetail({ (success, error) -> Void in
                tasks.removeLast()
            })
        }
    }
    
    func syncDataProfile(completion: COCompletion?) {
        FlowManager.shared.syncUserData { (success, error) -> Void in
            completion?(success: true, error: nil)
        }
    }
    
    func loadDataOfferDetail(completion: COCompletion?) {
        FlowManager.shared.getListOffer { (success, error) -> Void in
            completion?(success: success, error: error)
        }
    }
    
    func dismiss(completion: COCompletion?) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.progressView.stopAnimating()
            UIView.animateWithDuration(0.3,
                delay: 0,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations: { () -> Void in
                    self.transform = CGAffineTransformMakeScale(0.8, 0.8)
                    self.backgroundImage.alpha = 0
            }) { (completed: Bool) -> Void in
                self.removeFromSuperview()
                completion?(success: completed, error: nil)
            }
        }
    }
    
}

//MARK: Load Nib
extension COLoadingView {
    class func loadNib(bundle: NSBundle? = nil) -> COLoadingView? {
        return UINib( nibName: COLoadingView.className, bundle: bundle ).instantiateWithOwner(nil, options: nil)[0] as? COLoadingView
    }
}
