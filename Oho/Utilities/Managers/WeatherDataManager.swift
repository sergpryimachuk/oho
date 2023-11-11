import CoreLocation
import OSLog

final class WeatherDataManager {
    
    static let shared = WeatherDataManager()
    
    private init() { }

    var weatherData: WeatherData?
    
    private let logger = Logger.weather

    @MainActor
    func fetchWeatherData(for coordinate: CLLocationCoordinate2D?) async throws {
        guard let coordinate else { throw AppError.nilCoordinate }

        let lat = coordinate.latitude
        let lon = coordinate.longitude

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?"
            + "lat=\(lat)&lon=\(lon)&units=metric&"
            + "appid=\(AppConstants.openWeatherAPIkey)&lang=uk")
        else { fatalError("INVALID WEATHER API URL!") }

        let urlRequest = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else { 
            logger.error("Error fetching from URL")
            throw AppError.errorFetchingFromURL
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        let decodedData = try decoder.decode(WeatherData.self, from: data)

        weatherData = decodedData
    }

    // MARK: - Weather for now

    func tempForNow() -> Double {
        guard let weatherData else { return 111 }
        return weatherData.list.first { $0.dt >= .nearestHour }!.main.temp
    }

    func windForNow() -> Double {
        guard let weatherData else { return 7 }
        return weatherData.list.first { $0.dt >= .nearestHour }!.wind.speed
    }

    func descriptionForNow() -> String {
        guard let weatherData else { return "***" }
        return weatherData.list.first { $0.dt >= .nearestHour }?.weather[0].description ?? "***"
    }

    func codeForNow() -> Int {
        guard let weatherData else { return 0 }
        return weatherData.list.first { $0.dt >= .nearestHour }?.weather[0].id ?? 1111
    }

    // MARK: - Weather for later

    func tempForLater() -> Double {
        guard let weatherData else { return 111 }
        return weatherData.list.first { $0.dt >= .later }?.main.temp ?? 111
    }

    func descriptionForLater() -> String {
        guard let weatherData else { return "***" }
        return weatherData.list.first { $0.dt >= .later }?.weather[0].description ?? "***"
    }

    func windForLater() -> Double {
        guard let weatherData else { return 7 }
        return weatherData.list.first { $0.dt >= .later }!.wind.speed
    }

    func codeForLater() -> Int {
        guard let weatherData else { return 0 }
        return weatherData.list.first { $0.dt >= .later }?.weather[0].id ?? 1111
    }

    // MARK: - Weather for the next morning

    func tempForMorning() -> Double {
        guard let weatherData else { return 111 }
        return weatherData.list.first { $0.dt >= .mornning }?.main.temp ?? 111
    }

    func descriptionForMorning() -> String {
        guard let weatherData else { return "***" }
        return weatherData.list.first { $0.dt >= .mornning }?.weather[0].description ?? "***"
    }

    func windForMorning() -> Double {
        guard let weatherData else { return 7 }
        return weatherData.list.first { $0.dt >= .mornning }!.wind.speed
    }

    func codeForMorning() -> Int {
        guard let weatherData else { return 0 }
        return weatherData.list.first { $0.dt >= .mornning }?.weather[0].id ?? 1111
    }

    // MARK: - Weather for the next afternoon

    func tempForAfternoon() -> Double {
        guard let weatherData else { return 111 }
        return weatherData.list.first { $0.dt >= .afternoon }?.main.temp ?? 111
    }

    func windForAfternoon() -> Double {
        guard let weatherData else { return 7 }
        return weatherData.list.first { $0.dt >= .afternoon }!.wind.speed
    }

    func descriptionForAfternoon() -> String {
        guard let weatherData else { return "***" }
        return weatherData.list.first { $0.dt >= .afternoon }?.weather[0].description ?? "***"
    }

    func codeForAfternoon() -> Int {
        guard let weatherData else { return 0 }
        return weatherData.list.first { $0.dt >= .afternoon }?.weather[0].id ?? 1111
    }
}
