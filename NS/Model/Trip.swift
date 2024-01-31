import SwiftUI

struct Trip: Codable{
    let id: Int
    let departure_time: String
    let days: [Int]
    let driver: Driver
    let bus: Bus
    let stations: [String]
}
