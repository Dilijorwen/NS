import Foundation

func sendAttendance(departure_id: Int, tickets_id: [Int]) {
    let controlURL = URL(string: "https://api.spacekot.ru/apishechka/m/Control")!
    
    // Создаем данные для отправки в теле запроса
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    let currentDate = dateFormatter.string(from: Date())
    
    let requestBody: [String: Any] = [
        "departure_id": departure_id,
        "arrive_time": currentDate,
        "timeslots": [1],
        "status": "done",
        "tickets_id": tickets_id
    ]
    
    var request = URLRequest(url: controlURL)
    request.httpMethod = "POST"
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    } catch {
        print("Error: \(error)")
        return 
    }
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
        } else if let data = data {
            // Обработка ответа, если это необходимо
            print("Response: \(String(data: data, encoding: .utf8) ?? "")")
        }
    }
    
    task.resume()
}
