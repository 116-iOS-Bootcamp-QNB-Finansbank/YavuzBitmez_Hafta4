//
//  MapViewController.swift
//  BasicUIComponents
//
//  Created by Semih Emre ÜNLÜ on 18.09.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        checkLocaionStatus()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        self.view.addGestureRecognizer(longPressGesture)
    }
    
    private var locationManager: CLLocationManager {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }
    
    private func checkLocaionStatus() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied, .restricted:showLocationPermissionPopup()
            break // Odev 2 burada settings'e yonlendirmek uzere bir popup gosterip. popup action'inda settingsi actiralim.
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError()
        }
    }
    func showLocationPermissionPopup(){
        let alert = UIAlertController(title: "Görünüyorki konum iznini kabul etmemişsiniz.",
                                     message: "Lütfen konumunuzu paylaşın. ", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { action in
            switch action.style {
            case.cancel:print("Cancel")
            case.destructive:print("destructive")//Uygulamanın ayarlar sayfasını açar
            default:UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }

    @objc func handleLongGesture(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Selected Adress"
        mapView.addAnnotation(annotation)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latitudeLabel.text = "latitude: \(locations.first?.coordinate.latitude)"
        longitudeLabel.text = "longitude: \(locations.first?.coordinate.longitude)"
        
        if let coordinate = locations.first?.coordinate {
            mapView.setCenter(coordinate, animated: true)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocaionStatus()
    }
}

extension MapViewController: MKMapViewDelegate {
    
}
