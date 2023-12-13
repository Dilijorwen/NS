import SwiftUI

struct DailySchedule: Codable {
    let id: Int64
    let date: Date
    let status: String
    let tickets: [Ticket]
    let trip: Trip
}
