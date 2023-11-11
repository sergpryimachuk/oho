import Foundation

enum AppError: Error {
    case nilCoordinate, errorFetchingFromURL, errorDecodingData, nilWeatherData
}
