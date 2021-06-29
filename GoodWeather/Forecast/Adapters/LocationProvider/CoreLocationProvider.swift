import CoreLocation
import Combine

final class CoreLocationProvider: NSObject, CLLocationManagerDelegate, LocationProvider {
    
    private let subject = PassthroughSubject<(Double, Double), Never>()
    private let locationManager = CLLocationManager()
    
    let location: AnyPublisher<(Double, Double), Never>
    
    override init() {
        location = subject.eraseToAnyPublisher()
        super.init()
        locationManager.delegate = self
    }
    
    func refreshLocation() {
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.first {
            let coordinate = currentLocation.coordinate
            subject.send((Double(coordinate.longitude), Double(coordinate.latitude)))
        }
    }
    
}
