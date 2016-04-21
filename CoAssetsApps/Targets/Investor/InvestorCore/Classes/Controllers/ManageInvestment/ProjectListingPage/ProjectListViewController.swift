//
//  PrijectListViewController.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/21/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

private let dataHeight = 180*AppDefine.ScreenSize.ScreenScale
private let dataWidth  = 75*AppDefine.ScreenSize.ScreenScale
private let minimumLineSpacing = 4*AppDefine.ScreenSize.ScreenScale

class ProjectListViewController: BaseViewController, ProjectListCellDelegate {
    
    @IBOutlet weak private var firstView: COTabbaView!
    @IBOutlet weak private var secondView: COTabbaView!
    @IBOutlet weak private var threeView: COTabbaView!
    @IBOutlet weak private var fourView: COTabbaView!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var collectionViewLayout: LGHorizontalLinearFlowLayout?
    
    var pageWidth: CGFloat {
        return collectionViewLayout!.itemSize.width + collectionViewLayout!.minimumLineSpacing
    }
    
    var contentOffset: CGFloat {
        return collectionView.contentOffset.x + collectionView.contentInset.left
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = m_local_string("TITLE_PROJECT_LIST")
        setupUI()
        configureCollectionView()
        configurePageControl()
    }
    
    private func setupUI() {
        
        firstView.img = UIImage(named: "icon_all")
        firstView.titleString = m_local_string("MESSAGE_ALL")
        
        secondView.img = UIImage(named: "icon_bulk")
        secondView.titleString = m_local_string("MESSAGE_BULK")
        
        threeView.img = UIImage(named: "icon_croudfunding")
        threeView.titleString = m_local_string("MESSAGE_CROUDFUNDING")
        
        fourView.img = UIImage(named: "icon_presale")
        fourView.titleString = m_local_string("MESSAGE_PRE_SALES")
        
        firstView.groudColor = AppDefine.AppColor.COblueColor
        setBackGroundTabbarView(secondView, view2: threeView, view3: fourView)
        
        let tap = UITapGestureRecognizer(target: self, action: "actionFirstView:")
        firstView.addGestureRecognizer(tap)
        let tap1 = UITapGestureRecognizer(target: self, action: "actionSecondView:")
        secondView.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: "actionThreeView:")
        threeView.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: "actionFourView:")
        fourView.addGestureRecognizer(tap3)
    }
}

//MARK: - Configure
extension ProjectListViewController {
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(UINib(nibName: "ProjectListCell", bundle: nil), forCellWithReuseIdentifier: "ProjectListCell")
        
        let mainheight = CGRectGetHeight(UIScreen.mainScreen().bounds)
        let mainwidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
        collectionViewLayout = LGHorizontalLinearFlowLayout.configureLayout(collectionView: collectionView, itemSize: CGSize(width: mainwidth - dataWidth, height: mainheight - dataHeight), minimumLineSpacing: -minimumLineSpacing)
        collectionViewLayout?.minimumScaleFactor = 0.85
    }
    
    func configurePageControl() {
        pageControl.numberOfPages = dataArray!.count
    }
}
//MARK: Setter, Getter
extension ProjectListViewController {
    var dataArray: NSArray? {
        guard let array = ResourcesHelper.readPlistFile("ProjectList") else {
            return []
        }
        return array as [AnyObject]
    }
}

//MARK: Private
extension ProjectListViewController {
    private func setBackGroundTabbarView(view1: COTabbaView, view2: COTabbaView, view3: COTabbaView ) {
        view1.groudColor = UIColor.clearColor()
        view2.groudColor = UIColor.clearColor()
        view3.groudColor = UIColor.clearColor()
    }
}

//MARK: Action
extension ProjectListViewController {
    func actionFirstView(sender: AnyObject) {
        firstView.groudColor = AppDefine.AppColor.COblueColor
        setBackGroundTabbarView(secondView, view2: threeView, view3: fourView)
    }
    
    func actionSecondView(sender: AnyObject) {
        secondView.groudColor = AppDefine.AppColor.CORedAlphaColor
        setBackGroundTabbarView(threeView, view2: firstView, view3: fourView)
    }
    
    func actionThreeView(sender: AnyObject) {
        threeView.groudColor = AppDefine.AppColor.COYellowAlphaColor
        setBackGroundTabbarView(secondView, view2: firstView, view3: fourView)
    }
    
    func actionFourView(sender: AnyObject) {
        fourView.groudColor = AppDefine.AppColor.COBlueAlphaColor
        setBackGroundTabbarView(secondView, view2: threeView, view3: firstView)
    }
    @IBAction func actionDetail(sender: AnyObject) {
        let detailVC = ProjectListDetailController(nibName: ProjectListDetailController.className, bundle: nil)
        self.pushViewController(detailVC)
    }
}

//MARK: UICollectionViewDataSource
extension ProjectListViewController:UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let myData = dataArray {
            return myData.count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ProjectListCell.className, forIndexPath: indexPath) as? ProjectListCell, myData = dataArray {
            cell.objectButton = myData[indexPath.row]
            cell.delegate = self
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension ProjectListViewController:UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        pageControl.currentPage =  Int(floor((contentOffset-(0.5*pageWidth))/pageWidth))+1
    }
    
}

//MARK: Delegate
extension ProjectListViewController {
    func projectListCell(projectListCell: ProjectListCell) {
        let projectDetailVC = ProjectListDetailController(nibName: ProjectListDetailController.className, bundle: nil)
        self.pushViewController(projectDetailVC)
    }
}
