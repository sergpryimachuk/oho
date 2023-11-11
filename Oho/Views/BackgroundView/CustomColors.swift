import SwiftUI

enum GradientElement {
    case blobs, highlights
}

enum CustomColors {
    static let freezing: [GradientElement: [Color]] = [
        .blobs: [.freezingB1, .freezingB2, .freezingB3, .freezingB4],
        .highlights: [.freezingH1, .freezingH2, .freezingH3, .freezingH4],
    ]

    static let cold: [GradientElement: [Color]] = [
        .blobs: [.coldB1, .coldB2, .coldB3, .coldB4],
        .highlights: [.coldH1, .coldH2, .coldH3, .coldH4],
    ]

    static let warm: [GradientElement: [Color]] = [
        .blobs: [.warmB1, .warmB2, .warmB3, .warmB4],
        .highlights: [.warmH1, .warmH2, .warmH3, .warmH4],
    ]

    static let hot: [GradientElement: [Color]] = [
        .blobs: [.hotB1, .hotB2, .hotB3, .hotB4],
        .highlights: [.hotH1, .hotH2, .hotH3, .hotH4],
    ]

    static let rainbow: [GradientElement: [Color]] = [
        .blobs: [.violet, .indigo, .blue, .green],
        .highlights: [.yellow, .orange, .red],
    ]

    static let pinky: [GradientElement: [Color]] = [
        .blobs: [.pinky, .pinky, .pinky, .pinky],
        .highlights: [.pinky, .pinky, .pinky, .pinky],
    ]
}
