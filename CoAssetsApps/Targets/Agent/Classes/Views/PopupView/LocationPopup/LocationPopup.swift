//
//  LocationPopup.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/28/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationPopup: BasePopup {

    @IBOutlet weak private var map: MKMapView!
    
    override func awakeFromNib() {
         super.awakeFromNib()
        let location = CLLocationCoordinate2DMake(1.48305, 103.66333)
        let span = MKCoordinateSpanMake(0.02, 0.02)
        let regon = MKCoordinateRegionMake(location, span)
        map.setRegion(regon, animated: true)
        let annocation = MKPointAnnotation()
        
        annocation.coordinate = location
        map.addAnnotation(annocation)

    }

}
//MARK: - Static func
extension LocationPopup {
    class func showQuestionPopup(parentView: UIView, complete: Completion) {
        let questionPopup = UIView.loadFromNibNamed("LocationPopup") as! LocationPopup
//        questionPopup.complete = complete
        questionPopup.translatesAutoresizingMaskIntoConstraints = false
        kAppDelegate!.window!.addSubview(questionPopup)
        questionPopup.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
    }
}

//MARK: Action
extension LocationPopup {
    @IBAction func actionClose(sender: AnyObject) {
        self.popView()
    }
}
