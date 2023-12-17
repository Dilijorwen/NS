import SwiftUI

struct DailySchedule: Codable {
    let id: Int
    let date: Date
    let status: String
    let tickets: [Ticket]
    let trip: Trip
}

