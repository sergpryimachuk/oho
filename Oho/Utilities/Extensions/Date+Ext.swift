import SwiftUI

extension Date {
    /// Finds the next whole hour
    func nearestHour() -> Date {
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        var components = gregorian.components([.year, .month, .day, .hour, .minute], from: .now)
        
        if components.minute != 0 {
            components.hour = components.hour! + 3
            components.minute = 0
        }
        
        let date = gregorian.date(from: components)!
        return date
    }
    
    static var calendar = Calendar.current
    static let now = Date()
    static let midnight = calendar.startOfDay(for: now)
    static let tomorrow = calendar.date(byAdding: .day, value: 1, to: midnight)!
    static let nearestHour = now.nearestHour()
    static let later = calendar.date(byAdding: .hour, value: 3, to: nearestHour)!
    static let mornning = calendar.date(byAdding: .hour, value: 10, to: tomorrow)!
    static let afternoon = calendar.date(byAdding: .hour, value: 16, to: tomorrow)!
}
