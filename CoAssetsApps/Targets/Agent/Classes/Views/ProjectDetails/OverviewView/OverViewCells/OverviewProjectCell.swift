//
//  CverviewProjectCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/21/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class OverviewProjectCell: UITableViewCell {

    @IBOutlet weak private var projectTypeLabel: UILabel!
    @IBOutlet weak private var developLabel: UILabel!
    //@IBOutlet weak private var widthProjectType: NSLayoutConstraint!
    //@IBOutlet weak private var widthDevelop: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        projectTypeLabel.text = m_local_string("MESSAGE_CONTENT_PROJECT_TYPE")
        developLabel.text = m_local_string("MESSAGE_CONTENT_PROJECT_DEVELOP")
        //widthProjectType.constant = setWidthLabel(projectTypeLabel.text!, font: projectTypeLabel.font)
        //widthDevelop.constant = setWidthLabel(developLabel.text!, font: projectTypeLabel.font)
    }

    private func setWidthLabel(text: String, font: UIFont) -> CGFloat {
        let width = (StringHelper.widthOfString(text, font: font) + 4)
        return width
    }
    
}
