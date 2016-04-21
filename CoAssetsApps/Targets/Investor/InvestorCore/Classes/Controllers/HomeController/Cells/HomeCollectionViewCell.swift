//
//  HomeCollectionViewCell.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/2/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCollectionViewCell: UICollectionViewCell {
    
    weak var parentController: HomeController?
    @IBOutlet weak private var offerHeaderImageView: UIImageView!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var heightCollectionView: NSLayoutConstraint!
    @IBOutlet weak private var footerButton: COIconLeftButton!
    @IBOutlet weak private var titleLabel: BaseLabel!
    @IBOutlet weak private var descriptionLabel: BaseLabel!
    
    var offerObject: COOfferModel? {
        didSet {
            if let _ = offerObject {
                creatDataMoreInfo(offerObject!)
                reloadData()
            }
        }
    }

    var moreInfoArray = [[String:String]]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        collectionView.registerNib(UINib(nibName: MoreInfoCell.className, bundle: nil),
            forCellWithReuseIdentifier: MoreInfoCell.className)
        collectionView.dataSource  = self
        collectionView.delegate  = self
        let tap = UITapGestureRecognizer(target: self, action: "actionTapCell")
        contentView.addGestureRecognizer(tap)
        heightCollectionView.constant = 160 * AppDefine.ScreenSize.ScreenScale
        collectionView.layoutIfNeeded()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func reloadData() {
        loadDataButton()
        loadDataText()
        collectionView.reloadData()
        if let myHeader = offerHeaderImageView {
            myHeader.sd_setImageWithURL(NSURL(string: offerObject!.project!.photo))
        }
    }
}

//MARK: Private
extension HomeCollectionViewCell {
    private func loadDataButton() {
        footerButton.backgroundColor = loadBackgroundColor(offerObject!.offerType)
        footerButton.titleButton = m_local_string(offerObject!.offerType).uppercaseString
        footerButton.icon = loadIcon(offerObject!.offerType)
    }
    
    private func loadDataText() {
        titleLabel.text = offerObject?.offerTitle
        descriptionLabel.attributedText = offerObject?.shortDesc
        descriptionLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
    }

    private func loadIcon(type: String) -> UIImage {
        var iconName = ""
        if type == AppDefine.AppEnum.ProjectList.ProjectListBulk.rawValue {
            iconName = "icon_bulk_white"
        } else if type == AppDefine.AppEnum.ProjectList.ProjectListCroudFunding.rawValue {
            iconName = "icon_croudfunding_white"
        } else {
            iconName = "icon_presale_white"
        }
        return UIImage(named: iconName)!
    }
    
    private func loadBackgroundColor(type: String) -> UIColor {
        if type == AppDefine.AppEnum.ProjectList.ProjectListBulk.rawValue {
            return AppDefine.AppColor.CORedListColor
        } else if type == AppDefine.AppEnum.ProjectList.ProjectListCroudFunding.rawValue {
            return AppDefine.AppColor.COYellowListColor
        }
        return AppDefine.AppColor.COBlueListColor
    }
}

//MARK: - Action
extension HomeCollectionViewCell {
    func actionTapCell() {
        if let myParentController = parentController, offerObject = offerObject {
            myParentController.openOfferDetailController(offerObject.offerID)
        }
    }
}

//MARK: - TableViewDatasource
extension HomeCollectionViewCell: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MoreInfoCell.className, forIndexPath: indexPath) as? MoreInfoCell else {
            return UICollectionViewCell()
        }
        if  moreInfoArray.isEmpty == false {
            cell.info = moreInfoArray[indexPath.row]
        } else {
            cell.info = nil
        }
        return cell
    }
}

//MARK: - TableViewDelegate
extension HomeCollectionViewCell:UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = floor(collectionView.bounds.size.width / 3.0)
        let height = floor(collectionView.bounds.size.height / 2.0)
        return CGSize(width: width, height: height)
    }
}

//MARK: - API
extension HomeCollectionViewCell {

    private func creatDataMoreInfo(offerModel: COOfferModel?) {
        moreInfoArray.removeAll()
        if let _ = offerModel {
            moreInfoArray.append([offerObject!.offerPledgedTitle:offerObject!.offerPledgedValue])
            moreInfoArray.append([offerObject!.offerFundedGoalTitle:offerObject!.offerFundedGoalValue])
            moreInfoArray.append([offerObject!.offerDayLeftTitle:offerObject!.offerDayLeftValue])
            moreInfoArray.append([offerObject!.offerInterestedTitle:offerObject!.offerInterestedValue])
            moreInfoArray.append([offerObject!.offerMinInvesmentTitle:offerObject!.offerMinInvesmentValue])
            moreInfoArray.append([offerObject!.offerMinAnnualTitle:offerObject!.offerMinAnnualValue])
        }
    }
    
}
