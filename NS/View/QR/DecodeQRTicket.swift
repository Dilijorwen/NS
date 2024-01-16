import Foundation

func decodeTicketData(from code: String) throws -> QRTicket {
    do {
        let jsonData = code.data(using: .utf8)!
        let decoder = JSONDecoder()
        let ticketData = try decoder.decode(QRTicket.self, from: jsonData)
        return ticketData
    } catch {
        throw error
    }
}
