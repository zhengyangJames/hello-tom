//
//  BaseView.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewDidLoad()
    }

    func viewDidLoad() {
        
    }
    
    class func nibView(nibName: String, bundle: NSBundle?) -> BaseView {
        if let view = UINib(nibName: nibName, bundle: bundle).instantiateWithOwner(nil, options: nil)[0] as? BaseView {
            return view
        }
        return BaseView()
    }
    
    class func nibView() -> BaseView {
        let view = BaseView.nibView(self.className, bundle: nil)
        return view
    }
}

class BaseViewPorfolio: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.blackColor().CGColor
    }
}
