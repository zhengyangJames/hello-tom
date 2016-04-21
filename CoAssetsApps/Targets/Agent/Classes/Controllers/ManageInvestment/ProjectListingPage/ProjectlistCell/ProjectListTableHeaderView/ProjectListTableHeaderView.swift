//
//  ProjectListTableHeaderView.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/29/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class ProjectListTableHeaderView: BaseView {
    override func viewDidLoad() {
        super.viewDidLoad()
        let newSize = CGSize(width: CGRectGetWidth(self.frame)*AppDefine.ScreenSize.ScreenScale, height: CGRectGetHeight(self.frame))
        let NewImage = UIHelper.resizeImage(UIImage(named: "icon_header")!, size: newSize)
        self.backgroundColor = UIColor(patternImage: NewImage)
    }

}
