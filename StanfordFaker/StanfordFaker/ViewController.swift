//
//  ViewController.swift
//  StanfordFaker
//
//  Created by qbbang on 16/11/2018.
//  Copyright © 2018 qbbang. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var countLabel: UILabel?
    @IBOutlet private weak var mapView: MKMapView!
    private var locationManager = CLLocationManager()
    
    var seconds = 30000
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    var buttoniBool = false
    var cctvButton = false
    

  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
    mapView.showsUserLocation = true
    mapView.mapType = .standard
  }
    
    @IBAction func cctvButton(_ sender: Any) {
        cctvButton.toggle()
        if cctvButton {
            let camera1 = MKPointAnnotation()
            camera1.coordinate = CLLocationCoordinate2D(latitude: 37.5012438, longitude: 127.0351441)
            camera1.title = "단속카메라"
            mapView.addAnnotation(camera1)
            let camera2 = MKPointAnnotation()
            camera2.coordinate = CLLocationCoordinate2D(latitude: 37.5003613, longitude: 127.0346916)
            camera2.title = "단속카메라"
            mapView.addAnnotation(camera2)
            let camera3 = MKPointAnnotation()
            camera3.coordinate = CLLocationCoordinate2D(latitude: 37.4991481, longitude: 127.0297281)
            camera3.title = "단속카메라"
            mapView.addAnnotation(camera3)
            let camera4 = MKPointAnnotation()
            camera4.coordinate = CLLocationCoordinate2D(latitude: 37.5081786, longitude: 127.0373821)
            camera4.title = "단속카메라"
            mapView.addAnnotation(camera4)
            let camera5 = MKPointAnnotation()
            camera5.coordinate = CLLocationCoordinate2D(latitude: 37.5084253, longitude: 127.0384322)
            camera5.title = "단속카메라"
            mapView.addAnnotation(camera5)
            let camera6 = MKPointAnnotation()
            camera6.coordinate = CLLocationCoordinate2D(latitude: 37.5076409, longitude: 127.0392105)
            camera6.title = "단속카메라"
            mapView.addAnnotation(camera6)
            let camera7 = MKPointAnnotation()
            camera7.coordinate = CLLocationCoordinate2D(latitude: 37.5022296, longitude: 127.0364404)
            camera7.title = "단속카메라"
            mapView.addAnnotation(camera7)
            let camera8 = MKPointAnnotation()
            camera8.coordinate = CLLocationCoordinate2D(latitude: 37.5034593, longitude: 127.0406281)
            camera8.title = "단속카메라"
            mapView.addAnnotation(camera8)
            let camera9 = MKPointAnnotation()
            camera9.coordinate = CLLocationCoordinate2D(latitude: 37.5022735, longitude: 127.0409848)
            camera9.title = "단속카메라"
            mapView.addAnnotation(camera9)
            let camera10 = MKPointAnnotation()
            camera10.coordinate = CLLocationCoordinate2D(latitude: 37.5014949, longitude: 127.0383879)
            camera10.title = "단속카메라"
            mapView.addAnnotation(camera10)
            let camera11 = MKPointAnnotation()
            camera11.coordinate = CLLocationCoordinate2D(latitude: 37.5083545, longitude: 127.0403277)
            camera11.title = "단속카메라"
            mapView.addAnnotation(camera11)
            let camera12 = MKPointAnnotation()
            camera12.coordinate = CLLocationCoordinate2D(latitude: 37.5059812, longitude: 127.0413806)
            camera12.title = "단속카메라"
            mapView.addAnnotation(camera12)
            let camera13 = MKPointAnnotation()
            camera13.coordinate = CLLocationCoordinate2D(latitude: 37.495859, longitude: 127.039266)
            camera13.title = "단속카메라"
            mapView.addAnnotation(camera13)
            
        } else if cctvButton == false {
            mapView.removeAnnotations(mapView.annotations)
        }
    }

    @IBAction func countStartButton(_ sender: UIButton) {
        buttoniBool.toggle()
        if buttoniBool {
            runTimer()
        } else if buttoniBool == false {
            reset()
        }
    }
    
    func reset() {
        timer.invalidate()
        seconds = 30000
        countLabel?.text = "Restart 300 sec"
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.001,
                                     target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
        
    }

    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 360000
        let minutes = Int(time) / 6000 % 6000
        let seconds = Int(time) & 6000
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }

    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            countLabel?.text = "Oh My God!!"
        } else {
        seconds -= 1
        countLabel?.text = timeString(time: TimeInterval(seconds))
        }
    }
    
}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let current = locations.last!
        let coordinate = current.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

