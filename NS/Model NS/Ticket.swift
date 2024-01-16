import SwiftUI

struct Ticket: Codable {
    let id: Int
    let departure_id: Int
    let bus_route_id: Int
    let place_number: Int
    let trip_id: Int
    let date: Date
    let time: String
    let departure_point: String
    let place_of_arrival: String
    let is_visited: Bool
    let first_name: String
    let last_name: String
    let father_name: String
}
