import SwiftUI
import Foundation

struct UserInfo: Codable {
    let first_name: String
    let last_name: String
    let patronymic: String
    let bus_code: Int
    let token: String
    let daily_schedule: [DailySchedule]
}


