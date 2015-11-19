//
//  ViewController.swift
//  MotionProject
//
//  Created by Kyle on 11/3/15.
//  Copyright © 2015 kylepontius. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var lblAccelX: UILabel!
    @IBOutlet weak var lblAccelY: UILabel!
    @IBOutlet weak var lblAccelZ: UILabel!
    @IBOutlet weak var lblBarometer: UILabel!
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    
    let motionManager = CMMotionManager()
    let locationManager = CLLocationManager()
    let altimeter = CMAltimeter()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupMotionDetection()
        setupBarometerDetection()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func setupMotionDetection() {
        motionManager.accelerometerUpdateInterval = 1.0
        motionManager.gyroUpdateInterval = 1.0
        
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) { motionData, _ in
            self.lblAccelX.text = String(motionData!.userAcceleration.x)
            self.lblAccelY.text = String(motionData!.userAcceleration.y)
            self.lblAccelZ.text = String(motionData!.userAcceleration.z)
        }
    }
    
    private func setupBarometerDetection() {
        altimeter.startRelativeAltitudeUpdatesToQueue(NSOperationQueue.mainQueue()) { data, _ in
            self.lblBarometer.text = String(data!.relativeAltitude)
        }
    }
    
    // MARK: - LOCATION DELEGATE METHODS -
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        lblLatitude.text = String(newLocation.coordinate.latitude)
        lblLongitude.text = String(newLocation.coordinate.longitude)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        locationManager.startUpdatingLocation()
    }
}