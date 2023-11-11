import Foundation

struct Lyric: Codable {
    let lyric: String
    let code: ClosedRange<Int>
    let temp: Range<Double>
    let wind: ClosedRange<Double>

    static let demoLyrics = [Lyric(lyric: "Немає п***ди, щось не робе.", code: 1 ... 1000, temp: -100 ..< 101, wind: 0 ... 100)]
}
