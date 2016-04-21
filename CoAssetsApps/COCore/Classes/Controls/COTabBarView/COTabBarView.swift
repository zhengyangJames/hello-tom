//
//  COTabBarViewswift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

@objc protocol COTabBarViewDelegate {
    optional func tabBarView(tabBarView: COTabBarView, didSelectTabView tabView: COTabView)
}

class COTabBarView: BaseView {
    
    var backgroundNormalColor: UIColor = UIColor.whiteColor()
    var backgroundSelectedColor: UIColor = UIColor.lightGrayColor()
    var textNormalColor: UIColor = UIColor.blackColor()
    var textSelectedColor: UIColor = UIColor.whiteColor()
    
    weak var barView: COBarView?
    weak var selectedTabView: UIView?
    
    private weak var barHeightConstraint: NSLayoutConstraint?
    
    weak var delegate: COTabBarViewDelegate?
    
    @IBInspectable var selectedIndex: Int = 0 {
        didSet {
            selectIndex(selectedIndex)
        }
    }
    
    @IBInspectable var barHeight: CGFloat = 42 {
        didSet {
            UIView.animateWithDuration(1.0) { () -> Void in
                self.barHeightConstraint?.constant = self.barHeight
            }
        }
    }
    
    var tabViews: [COTabView] = []
    
    private var didSetupUI: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !didSetupUI {
            setupUI()
            didSetupUI = true
        }
    }
    
    func selectIndex(index: Int) {
        if index < tabViews.count {
            let tabView = tabViews[index]
            if let mySelectedTabView = selectedTabView {
                mySelectedTabView.hidden = true
            }
            tabView.hidden = false
            selectedTabView = tabView
            barView?.selectedIndex = index
            
            delegate?.tabBarView?(self, didSelectTabView: tabView)
        }
    }
}

// MARK: Setup UI
extension COTabBarView {
    private func addBarView() {
        var items: [COBarItem] = []
        for tabView in tabViews {
            items.append(tabView.barItem!)
        }
        let barView = COBarView(items: items)
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.delegate = self
        barView.backgroundNormalColor = backgroundNormalColor
        barView.backgroundSelectedColor = backgroundSelectedColor
        barView.textNormalColor = textNormalColor
        barView.textSelectedColor = textSelectedColor
        
        let heightConstraint = NSLayoutConstraint(item: barView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: barHeight)
        barView.addConstraint(heightConstraint)
        barHeightConstraint = heightConstraint
        self.addSubview(barView)
        
        let topConstraint = NSLayoutConstraint(item: barView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let leftConstraint = NSLayoutConstraint(item: barView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let rightConstraint = NSLayoutConstraint(item: barView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
        self.addConstraints([leftConstraint, topConstraint, rightConstraint])
        
        self.barView = barView
    }
    
    private func addContentView() {
        for tabView in tabViews {
            tabView.translatesAutoresizingMaskIntoConstraints = false
            tabView.hidden = true
            
            self.addSubview(tabView)
            let topConstraint = NSLayoutConstraint(item: tabView, attribute: .Top, relatedBy: .Equal, toItem: barView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
            let bottomConstraint = NSLayoutConstraint(item: tabView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
            let leftConstraint = NSLayoutConstraint(item: tabView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0.0)
            let rightConstraint = NSLayoutConstraint(item: tabView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
            self.addConstraints([leftConstraint, topConstraint, rightConstraint, bottomConstraint])
        }
    }
    
    private func setupUI() {
        addBarView()
        addContentView()
        selectIndex(selectedIndex)
    }
}

// MARK: COBarViewDelegate
extension COTabBarView: COBarViewDelegate {
    func barView(barView: COBarView, didSelectAtIndex index: Int) {
        selectedIndex = index
    }
    
    func barView(barView: COBarView, shouldSelectIndex index: Int) -> Bool {
        return true
    }
}
