import SwiftUI

struct QRTicket: Codable {
    var ticket_id: Int
    var flight_number: Int
    var seat_number: Int
    var time_start: String
    var code_number: String
}
