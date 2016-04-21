//
//  HomeController.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/2/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

private let dataHeight = 180 * AppDefine.ScreenSize.ScreenScale
private let dataWidth  = 75 * AppDefine.ScreenSize.ScreenScale
private let minimumLineSpacing = 4 * AppDefine.ScreenSize.ScreenScale

class HomeController: BaseViewController {
    
    @IBOutlet weak private var firstView: COTabbaView!
    @IBOutlet weak private var secondView: COTabbaView!
    @IBOutlet weak private var threeView: COTabbaView!
    @IBOutlet weak private var fourView: COTabbaView!
    @IBOutlet weak private var noDataLabel: BaseLabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet var tabbaViewCollection: [COTabbaView]!
    
    var queue: NSOperationQueue = {
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    var collectionViewLayout: LGHorizontalLinearFlowLayout?
    var pageWidth: CGFloat {
        return collectionViewLayout!.itemSize.width + collectionViewLayout!.minimumLineSpacing
    }
    
    var contentOffset: CGFloat {
        return collectionView.contentOffset.x + collectionView.contentInset.left
    }
    
    private var needsReloadCollectionView: Bool = true
    
    private var selectedTabIndex: Int = -1 {
        didSet {
            if oldValue != self.selectedTabIndex {
                self.needsReloadCollectionView = true
            }
        }
    }
    
    private var firstOfferIds = [NSNumber]()
    private var secondOfferIds = [NSNumber]()
    private var thirdOfferIds = [NSNumber]()
    private var fourthOfferIds = [NSNumber]()
    
    private var offers = [NSNumber:COOfferModel]()
    
    var offerIdWaiting: Int?
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.configureActionFilterView()
        firstView.isSelected = true
        self.selectedTabIndex = 0
        setup()
        self.navigationController?.navigationItem.title = m_local_string("APP_NAME")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    // MARK: - Setup
    
    private func setup() {
        title = m_local_string("TITLE_HOME")
        kNotification.addObserver(self, selector: #selector(HomeController.loggedIn), name: AppDefine.NotificationKey.LoggedIn, object: nil)
    }
    
    func loggedIn() {
        if let myOfferId = offerIdWaiting {
            openOfferDetailController(myOfferId)
        }
    }
    
    func updateContentView() {
        collectionViewLayout?.invalidateLayout()
    }
    
    deinit {
        kNotification.removeObserver(self, name: AppDefine.NotificationKey.LoggedIn, object: nil)
    }
    
}

// MARK: - Data Functions

extension HomeController {
    
    private func currentOfferIds() -> [NSNumber] {
        if self.selectedTabIndex == 1 {
            return self.secondOfferIds
        } else if self.selectedTabIndex == 2 {
            return self.thirdOfferIds
        } else if self.selectedTabIndex == 3 {
            return self.fourthOfferIds
        }
        return self.firstOfferIds
    }
    
    private func currentType() -> AppDefine.AppEnum.ProjectList! {
        if self.selectedTabIndex == 1 {
            return .ProjectListBulk
        } else if self.selectedTabIndex == 2 {
            return .ProjectListCroudFunding
        } else if self.selectedTabIndex == 3 {
            return .ProjectListPresale
        }
        return nil
    }
    
    func setData(arr: [COOfferModel]!) {
        self.firstOfferIds.removeAll()
        self.secondOfferIds.removeAll()
        self.thirdOfferIds.removeAll()
        self.fourthOfferIds.removeAll()
        self.offers.removeAll()
        if arr != nil {
            for offer in arr {
                let offerId = NSNumber(integer: offer.offerID)
                self.offers[offerId] = offer
                self.firstOfferIds.append(offerId)
                if let offerType = AppDefine.AppEnum.ProjectList(rawValue: offer.offerType) {
                    switch offerType {
                    case .ProjectListBulk:
                        self.secondOfferIds.append(offerId)
                        break
                    case .ProjectListCroudFunding:
                        self.thirdOfferIds.append(offerId)
                        break
                    case .ProjectListPresale:
                        self.fourthOfferIds.append(offerId)
                        break
                    }
                }
            }
        }
        self.needsReloadCollectionView = true
        refresh()
    }
    
}

// MARK: - Configure

extension HomeController {
    
    private func configureActionFilterView() {
        firstView.img = UIImage(named: "icon_all")
        firstView.titleString = m_local_string("MESSAGE_ALL")
        secondView.img = UIImage(named: "icon_bulk")
        secondView.titleString = m_local_string("MESSAGE_BULK")
        threeView.img = UIImage(named: "icon_croudfunding")
        threeView.titleString = m_local_string("MESSAGE_CROUDFUNDING")
        fourView.img = UIImage(named: "icon_presale")
        fourView.titleString = m_local_string("MESSAGE_PRE_SALES")
        let tap = UITapGestureRecognizer(target: self, action: "actionTabButton:")
        firstView.addGestureRecognizer(tap)
        let tap1 = UITapGestureRecognizer(target: self, action: "actionTabButton:")
        secondView.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: "actionTabButton:")
        threeView.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: "actionTabButton:")
        fourView.addGestureRecognizer(tap3)
    }
    
    private func configureCollectionView() {
        collectionView.registerNib(UINib(nibName: HomeCollectionViewCell.className, bundle: nil),
            forCellWithReuseIdentifier: HomeCollectionViewCell.className)
        collectionView.dataSource = self
        collectionView.delegate = self
        let mainheight = CGRectGetHeight(UIScreen.mainScreen().bounds)
        let mainwidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
        collectionViewLayout = LGHorizontalLinearFlowLayout.configureLayout(
            collectionView: collectionView,
            itemSize: CGSize(width: mainwidth - dataWidth,
            height: mainheight - dataHeight),
            minimumLineSpacing: -minimumLineSpacing)
        collectionViewLayout?.minimumScaleFactor = 0.85
    }
    
}

// MARK: - Update

extension HomeController {
    
    func refresh() {
        self.updatePageControl()
        self.updateNoDataLabel()
        self.updateCollectionView()
    }
    
    private func updateCollectionView() {
        if self.needsReloadCollectionView {
            self.collectionView.contentOffset = CGPoint(x: 0, y: 0)
            self.needsReloadCollectionView = false
            let contentSizeCL = self.collectionView.contentSize
            let contentSizeCLF = self.collectionViewLayout?.collectionViewContentSize()
            if  contentSizeCL.width < contentSizeCLF?.width {
                self.collectionView.contentSize = self.collectionViewLayout!.collectionViewContentSize()
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionViewLayout?.prepareLayout()
                self.collectionView.reloadData()
            } else {
                self.collectionViewLayout?.invalidateLayout()
                self.collectionViewLayout?.prepareLayout()
                self.collectionView.reloadData()
            }
        }
        if self.currentOfferIds().isEmpty {
            self.collectionView.contentOffset = CGPoint(x: 0, y: 0)
        } else {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.None, animated: false)
        }
    }
    
    private func updatePageControl() {
        pageControl.numberOfPages = self.currentOfferIds().count
    }
    
    private func updateNoDataLabel() {
        if self.currentOfferIds().isEmpty {
            noDataLabel.hidden = false
            var message = ""
            if let type = self.currentType() {
                switch type {
                case AppDefine.AppEnum.ProjectList.ProjectListBulk:
                    message = m_local_string("FILTER_BULLK_NULL")
                    break
                case .ProjectListCroudFunding:
                    message = m_local_string("FILTER_CROWD_NULL")
                    break
                case .ProjectListPresale:
                    message = m_local_string("FILTER_SALE_NULL")
                    break
                }
            } else {
                message = m_local_string("FILTER_ALL_NULL")
            }
            noDataLabel.text = message
        } else {
            noDataLabel.hidden = true
        }
    }
    
}

// MARK: - Action

extension HomeController {

    func actionTabButton(sender: UIGestureRecognizer) {
        if let view = sender.view as? COTabbaView {
            for i in 0..<tabbaViewCollection.count {
                let tabView = tabbaViewCollection[i]
                tabView.isSelected = false
            }
            view.isSelected = true
            var listTap = [Int]()
            listTap.append(view.tag)
            self.performSelector("setSelectedTabIndex:", withObject: listTap, afterDelay: 0.3)
        }
    }
    
    func setSelectedTabIndex(theTimer: NSObject) {
        if let listTap = theTimer as? [Int] {
            self.selectedTabIndex = listTap.last ?? 0
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.refresh()
            })
        }
    }
    
    func openOfferDetailController(offerID: Int) {
        AuthManager.shared.checkPermission(navigationController) { (granted: Bool) -> Void in
            if granted {
                if let topView = UIApplication.topViewController() where topView.isKindOfClass(OfferDetailsController) {
                    if let offerDetail = topView as? OfferDetailsController {
                        let offerModel = COOfferModel()
                        offerModel.offerID = offerID
                        offerDetail.offerModel = offerModel
                        offerDetail.syncData()
                    }
                } else {
                    let detailVC = OfferDetailsController.vc()
                    let offerModel = COOfferModel()
                    offerModel.offerID = offerID
                    detailVC.offerModel = offerModel
                    self.pushViewController(detailVC)
                }
                self.offerIdWaiting = nil
            } else {
                self.offerIdWaiting = offerID
            }
        }
    }
    
    func createPostLocalNotification() {
        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow:8)
        localNotification.alertBody = "Debug Local Notification"
        localNotification.timeZone = NSTimeZone.localTimeZone()
        let userinfo = ResourcesHelper.readJSONFileReturnDictionary("UserInfoNotification")
        localNotification.userInfo = userinfo
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.applicationIconBadgeNumber = 1
        localNotification.category = "Message"
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
}

// MARK: - UICollectionView

extension HomeController:UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentOfferIds().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HomeCollectionViewCell.className, forIndexPath: indexPath) as? HomeCollectionViewCell {
            let offerId = self.currentOfferIds()[indexPath.row]
            let offer = offers[offerId]
            cell.offerObject = offer
            cell.parentController = self
            return cell
        }
        return UICollectionViewCell()
    }
    
}

extension HomeController:UICollectionViewDelegate {

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        pageControl.currentPage =  Int(floor((contentOffset-(0.5*pageWidth))/pageWidth))+1
    }
    
}
