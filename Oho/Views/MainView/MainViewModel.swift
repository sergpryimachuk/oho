import CoreLocation
import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var isLoading = true
    private let generator = UINotificationFeedbackGenerator()

    @MainActor
    func getWeatherData(for coordinate: CLLocationCoordinate2D) async {
        isLoading = true
        do {
            try await WeatherDataManager.shared.fetchWeatherData(for: coordinate)
            isLoading = false
            successHaptic()
        } catch {
            failtureHaptic()
            isLoading = true
        }
    }

    func successHaptic() {
        generator.notificationOccurred(.success)
    }

    func failtureHaptic() {
        generator.notificationOccurred(.error)
    }
}
