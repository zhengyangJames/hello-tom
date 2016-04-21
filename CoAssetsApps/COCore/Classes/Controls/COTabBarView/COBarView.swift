//
//  COBarView.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

@objc protocol COBarViewDelegate {
    func barView(barView: COBarView, didSelectAtIndex index: Int)
    func barView(barView: COBarView, shouldSelectIndex index: Int) -> Bool
}

class COBarView: BaseView {
    
    var backgroundNormalColor: UIColor = UIColor.whiteColor()
    var backgroundSelectedColor: UIColor = UIColor.lightGrayColor()
    var textNormalColor: UIColor = UIColor.blackColor()
    var textSelectedColor: UIColor = UIColor.whiteColor()
    
    var selectedIndex: Int = 0 {
        didSet {
            for itemView in itemViews {
                if itemView.index == selectedIndex {
                    selectItemView(itemView)
                }
            }
        }
    }
    
    private weak var selectedItemView: COBarItemView?
    
    weak var delegate: COBarViewDelegate!
    
    var items: [COBarItem] = [] {
        didSet {
            for subView in self.subviews {
                subView.removeFromSuperview()
            }
            itemViews.removeAll()
            setupUI()
        }
    }
    
    var itemViews: [COBarItemView] = []
    
    private var didSetupUI: Bool = false
    
    convenience init(items: [COBarItem]) {
        self.init()
        self.items = items
    }
    
    func selectItemView(barItemView: COBarItemView) {
        if let mySelectedItemView = selectedItemView {
            mySelectedItemView.selected = false
        }
        
        barItemView.selected = true
        selectedItemView = barItemView
    }
}

// MARK: Setup UI
extension COBarView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !didSetupUI {
            setupUI()
            didSetupUI = true
        }
    }
    
    private func createItemView(item: COBarItem, index: Int, selected: Bool) -> COBarItemView {
        let itemView = COBarItemView(item: item, index:index, selected: selected)
        itemView.translatesAutoresizingMaskIntoConstraints = false
        itemView.delegate = self
        itemView.backgroundNormalColor = backgroundNormalColor
        itemView.backgroundSelectedColor = backgroundSelectedColor
        itemView.textNormalColor = textNormalColor
        itemView.textSelectedColor = textSelectedColor
        return itemView
    }
    
    private func addSeparatorView() -> UIView {
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor.lightGrayColor()
        seperatorView.alpha = 0.4
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = NSLayoutConstraint(item: seperatorView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 0.5)
        seperatorView.addConstraint(widthConstraint)
        self.addSubview(seperatorView)
        
        let centerYConstraint = NSLayoutConstraint(item: seperatorView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        let equalHeightConstraint = NSLayoutConstraint(item: seperatorView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0.5, constant: 0.0)
        self.addConstraints([centerYConstraint, equalHeightConstraint])
        return seperatorView
    }
    
    private func setupUI() {
        weak var preItemView: UIView?
        weak var preSeperatorView: UIView?
        for (index, item) in items.enumerate() {
            
            let itemView = createItemView(item, index: index, selected: selectedIndex == index)
            if selectedIndex == index {
                self.selectedItemView = itemView
            }
            self.addSubview(itemView)
            
            let topConstraint = NSLayoutConstraint(item: itemView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0)
            let bottomConstraint = NSLayoutConstraint(item: itemView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
            self.addConstraints([topConstraint, bottomConstraint])
            
            
            if let myPreSeperatorView = preSeperatorView {
                let leftConstraint = NSLayoutConstraint(item: itemView, attribute: .Leading, relatedBy: .Equal, toItem: myPreSeperatorView, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
                self.addConstraints([leftConstraint])
            } else {
                let leftConstraint = NSLayoutConstraint(item: itemView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0.0)
                self.addConstraint(leftConstraint)
            }
            
            if let myPreItemView = preItemView {
                let equalConstraint = NSLayoutConstraint(item: itemView, attribute: .Width, relatedBy: .Equal, toItem: myPreItemView, attribute: .Width, multiplier: 1.0, constant: 0.0)
                self.addConstraints([equalConstraint])
            }
            
            if index == items.count - 1 {
                let rightConstraint = NSLayoutConstraint(item: itemView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
                self.addConstraint(rightConstraint)
                itemView.leftSeperatorView = preSeperatorView
            } else {
                let seperateView = addSeparatorView()
                let seperatorLeftConstraint = NSLayoutConstraint(item: seperateView, attribute: .Leading, relatedBy: .Equal, toItem: itemView, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
                self.addConstraint(seperatorLeftConstraint)
                
                itemView.leftSeperatorView = preSeperatorView
                itemView.rightSeperatorView = seperateView
                
                preSeperatorView = seperateView
            }
            
            preItemView = itemView
            
            itemViews.append(itemView)
        }
    }
}

// MARK: COBarItemViewDelegate
extension COBarView: COBarItemViewDelegate {
    
    func barItemView(barItemView: COBarItemView, didSelect: Bool) {
        selectItemView(barItemView)
        delegate.barView(self, didSelectAtIndex: barItemView.index!)
    }
    
}
