import SwiftUI

struct Ticket: Codable {
    let id: Int64
    let departure_id: Int64
    let bus_route_id: Int64
    let place_number: Int64
    let trip_id: Int64
    let date: Date
    let time: String
    let departure_point: String
    let place_of_arrival: String
    let is_visited: Bool
    let first_name: String
    let last_name: String
    let father_name: String
}

