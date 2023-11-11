import SwiftUI

final class WeatherViewModel: ObservableObject {
    @Published var lyric: String?

    private let weatherDataManager = WeatherDataManager.shared
    private let generator = UINotificationFeedbackGenerator()

    func getTemp(for time: WeatherFor) -> String {
        switch time {
        case .now:
            return String(format: "%.0f", weatherDataManager.tempForNow())
        case .later:
            return String(format: "%.0f", weatherDataManager.tempForLater())
        case .morning:
            return String(format: "%.0f", weatherDataManager.tempForMorning())
        case .afternoon:
            return String(format: "%.0f", weatherDataManager.tempForAfternoon())
        }
    }

    func getDescription(for time: WeatherFor) -> String {
        switch time {
        case .now:
            return weatherDataManager.descriptionForNow()
        case .later:
            return weatherDataManager.descriptionForLater()
        case .morning:
            return weatherDataManager.descriptionForMorning()
        case .afternoon:
            return weatherDataManager.descriptionForAfternoon()
        }
    }

    func getLyric(for time: WeatherFor) {
        let lyrics = Bundle.main.decode([Lyric].self, from: "lyrics.json")
        switch time {
        case .now:
            lyric = lyrics.filter { $0.temp ~= weatherDataManager.tempForNow() && $0.code ~= weatherDataManager.codeForNow() && $0.wind ~= weatherDataManager.windForNow() }.randomElement()?.lyric ?? "Невідома п***да."
        case .later:
            lyric = lyrics.filter { $0.temp ~= weatherDataManager.tempForLater() && $0.code ~= weatherDataManager.codeForLater() && $0.wind ~= weatherDataManager.windForLater() }.randomElement()?.lyric ?? "Невідома п***да."
        case .morning:
            lyric = lyrics.filter { $0.temp ~= weatherDataManager.tempForMorning() && $0.code ~= weatherDataManager.codeForMorning() && $0.wind ~= weatherDataManager.windForMorning() }.randomElement()?.lyric ?? "Невідома п***да."
        case .afternoon:
            lyric = lyrics.filter { $0.temp ~= weatherDataManager.tempForAfternoon() && $0.code ~= weatherDataManager.codeForAfternoon() && $0.wind ~= weatherDataManager.windForAfternoon() }.randomElement()?.lyric ?? "Невідома п***да."
        }
    }

    func removeAsterisk() {
        guard let safeLyric = lyric else { return }
        if safeLyric.contains("п***д") {
            let newLyric = safeLyric.replacingOccurrences(of: "п***д", with: "погод")
            lyric = newLyric
            generator.notificationOccurred(.success)
            return
        } else if safeLyric.contains("П***д") {
            let newLyric = safeLyric.replacingOccurrences(of: "П***д", with: "Погод")
            lyric = newLyric
            generator.notificationOccurred(.success)
            return
        } else if safeLyric.contains("погод") {
            let newLyric = safeLyric.replacingOccurrences(of: "погод", with: "п***д")
            lyric = newLyric
            generator.notificationOccurred(.success)
            return
        } else if safeLyric.contains("Погод") {
            let newLyric = safeLyric.replacingOccurrences(of: "Погод", with: "П***д")
            lyric = newLyric
            generator.notificationOccurred(.success)
            return
        } else {
            generator.notificationOccurred(.error)
        }
    }
}
