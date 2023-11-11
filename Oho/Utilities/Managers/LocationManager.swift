import CoreLocation
import OSLog
import SwiftUI

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private var manager = CLLocationManager()
    private let logger = Logger.location

    @Published var userLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        userLocation = manager.location
        logger.info("Requested when in use Location Authorization.")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            authorizationStatus = .notDetermined
        case .restricted:
            authorizationStatus = .restricted
        case .denied:
            authorizationStatus = .denied
        case .authorizedAlways, .authorizedWhenInUse:
            authorizationStatus = .authorizedWhenInUse
            manager.requestLocation()
            guard let newLocation = manager.location else { break }
            userLocation = newLocation
        @unknown default:
            fatalError("@unknown LocationManager Authorization Status")
        }
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
        logger.info("Successfully got user location.")
    }

    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        logger.error("Error getting location: \(error.localizedDescription)")
    }
}
