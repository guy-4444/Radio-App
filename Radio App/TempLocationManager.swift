import Foundation
import CoreLocation

class TempLocationManager {
    
    var locationManager: CLLocationManager
    var delegate: CLLocationManagerDelegate
    
    init(delegate: CLLocationManagerDelegate) {
        self.delegate = delegate
        locationManager = CLLocationManager()
        locationManager.delegate = delegate
        print("A1")
        locationManager.requestWhenInUseAuthorization()
        print("A2")

    }
    
    func start() {
        print("B")
        locationManager.requestLocation()
        print("C")
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
    }
}
