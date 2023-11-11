import SwiftUI

final class BackgroundViewModel: ObservableObject {
    func getBlobs(for tab: Tab) -> [Color] {
        switch tab {
        case .today:
            return getGradinet(for: WeatherDataManager.shared.tempForNow())[.blobs] ?? CustomColors.pinky[.blobs]!
        case .tomorrow:
            return getGradinet(for: WeatherDataManager.shared.tempForAfternoon())[.blobs] ?? CustomColors.pinky[.blobs]!
        case .none:
            return CustomColors.pinky[.blobs]!
        }
    }

    func getHighlights(for tab: Tab) -> [Color] {
        switch tab {
        case .today:
            return getGradinet(for: WeatherDataManager.shared.tempForNow())[.highlights] ?? CustomColors.pinky[.highlights]!
        case .tomorrow:
            return getGradinet(for: WeatherDataManager.shared.tempForAfternoon())[.highlights] ?? CustomColors.pinky[.highlights]!
        case .none:
            return CustomColors.pinky[.highlights]!
        }
    }

    func getWind(for tab: Tab) -> Double {
        switch tab {
        case .today:
            return WeatherDataManager.shared.windForNow() / 7
        case .tomorrow:
            return WeatherDataManager.shared.windForAfternoon() / 7
        case .none:
            return 1
        }
    }

    func getGradinet(for temp: Double) -> [GradientElement: [Color]] {
        if -30 ..< 0 ~= temp {
            return CustomColors.freezing
        } else if 0 ..< 18 ~= temp {
            return CustomColors.cold
        } else if 18 ..< 25 ~= temp {
            return CustomColors.warm
        } else if 25 ..< 40 ~= temp {
            return CustomColors.hot
        } else if 40 ..< 50 ~= temp {
            return CustomColors.rainbow
        } else {
            return CustomColors.pinky
        }
    }
}
