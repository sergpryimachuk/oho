import Foundation

struct WeatherData: Codable {
    struct List: Codable {
        let dt: Date
        let main: MainClass
        let weather: [Weather]
        let wind: Wind

        struct MainClass: Codable {
            let temp: Double
        }

        struct Weather: Codable {
            let id: Int
            let description: String
        }

        struct Wind: Codable {
            let speed: Double
        }
    }

    let list: [List]
}
