//
//  mapVC.swift
//  FirebaseTests
//
//  Created by Aivars Meijers on 04.06.17.
//  Copyright © 2017. g. Aivars Meijers. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class mapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var location = CLLocationManager()
    
    override func viewDidLoad() {
    
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        location.delegate = self
        
        location.requestWhenInUseAuthorization()
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.startUpdatingLocation()
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation : CLLocation = locations[0]
        let userLati = userLocation.coordinate.latitude
        let userLong = userLocation.coordinate.longitude
        
        print("\(userLati) and \(userLong)")
        
        let span = MKCoordinateSpan (latitudeDelta: 0.4, longitudeDelta: 0.4)
        
        let centerLocation = CLLocationCoordinate2D(latitude: userLati, longitude: userLong)
        let mapRegion = MKCoordinateRegion(center: centerLocation, span: span)
        
        self.mapView.setRegion(mapRegion, animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
