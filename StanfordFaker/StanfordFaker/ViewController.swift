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
    

  override func viewDidLoad() {
    super.viewDidLoad()

    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
    mapView.showsUserLocation = true
    mapView.mapType = .standard
  }
    
    @IBAction func cctvButton(_ sender: Any) {
        let cityhall = MKPointAnnotation()
        cityhall.coordinate = CLLocationCoordinate2D(latitude: 37.566308, longitude: 126.977948)
        cityhall.title = "시청"
        cityhall.subtitle = "서울특별시"
        mapView.addAnnotation(cityhall)
        
        let namsan = MKPointAnnotation()
        namsan.title = "남산"
        namsan.coordinate = CLLocationCoordinate2D(latitude: 37.551416, longitude: 126.988194)
        mapView.addAnnotation(namsan)
        
        let gimpoAirport = MKPointAnnotation()
        gimpoAirport.coordinate = CLLocationCoordinate2D(latitude: 37.559670, longitude: 126.794320)
        gimpoAirport.title = "김포공항"
        mapView.addAnnotation(gimpoAirport)
        
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
        countLabel?.text = timeString(time: TimeInterval(seconds))
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.001,
                                     target: self,
                                     selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
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
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

