//
//  Created with ♥ by Serhii Pryimachuk on 11.11.2023.
//  

import OSLog

extension Logger {
    static let subsystem = Bundle.main.bundleIdentifier ?? "Oho app"
    static let location = Logger(subsystem: subsystem, category: "Location manager")
    static let weather = Logger(subsystem: subsystem, category: "Weather manager")
}
