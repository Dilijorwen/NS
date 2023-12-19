import SwiftUI
import AVKit

class QRScannerDelegate: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var scannedCode: String?
    
    @Published var isShowingQRSuccessPopup = false
    @Published var isShowingQRDeniedPopup = false
    
    @Published var alertQRText = ""
    
    @EnvironmentObject var trip: TripInfo
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaObject = metadataObjects.first {
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let Code = readableObject.stringValue else { return }
            scannedCode = Code
            do {
                let jsonData = Code.data(using: .utf8)!
                let decoder = JSONDecoder()
                let ticketData = try decoder.decode(TicketData.self, from: jsonData)
                
                let verification = "\(ticketData.ticket_id) \(ticketData.flight_number) \(ticketData.seat_number)"
                let shaVerification = sha256(verification)
                print(shaVerification, ticketData.code_number)
                if shaVerification == ticketData.code_number {
                    isShowingQRSuccessPopup = true
                    isShowingQRDeniedPopup = false // Показываем окно "Ура"
                    alertQRText = "Успешно"
                } else {
                    isShowingQRDeniedPopup = true
                    isShowingQRSuccessPopup = false // Показываем окно "Плохо"
                    alertQRText = "Неверный билет"
                }
            } catch {
                print("Ошибка при декодировании JSON: \(error.localizedDescription)")
            }
        }
    }
}


struct TicketData: Codable {
    var ticket_id: Int
    var flight_number: Int
    var seat_number: Int
    var time_start: String
    var code_number: String
}