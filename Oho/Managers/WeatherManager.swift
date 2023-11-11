//
//  WeatherManager.swift
//  Oho
//
//  Created by Serhii Pryimachuk on 02.04.2023.
//

import CoreLocation
import SwiftUI

final class WeatherDataManager: ObservableObject {
    static let shared = WeatherDataManager()

    private init() {}

    var weatherData: WeatherData?

    private let APIkey = "1eb817d31da30fe2ba6f85ea7d2aef54"

    func getWeatherData(lat: CLLocationDegrees, lon: CLLocationDegrees) async throws {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&units=metric&appid=\(APIkey)&lang=uk") else { fatalError("MISSING API URL!") }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data!") }
        let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
        weatherData = decodedData
    }
}
