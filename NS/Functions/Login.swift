import SwiftUI
import Security


func Login(login: String, password: String, completion: @escaping (Result<UserInfo, Error>) -> Void) {

    let loginURL = URL(string: "https://api.spacekot.ru/apishechka/m/login")!
    
    // Создание запроса
    var request = URLRequest(url: loginURL)
    request.httpMethod = "POST"
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let currentDate = dateFormatter.string(from: Date())
    
    // Установка тела запроса с учетными данными пользователя
    let requestBody: [String: Any] = [
        "login": login,
        "password": password,
        "date": currentDate
    ]
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    } catch {
        completion(.failure(error)) // Если возникла ошибка при создании данных для запроса, вызываем обратный вызов с ошибкой.
        return
    }
    
    // Выполнение запроса
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error)) // Если возникла ошибка при выполнении запроса, вызываем обратный вызов с ошибкой.
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            let unknownError = NSError(domain: "UnknownResponseError", code: 0, userInfo: nil)
            completion(.failure(unknownError)) // Если не удалось получить HTTP-ответ, вызываем обратный вызов с неизвестной ошибкой.
            return
        }
        
        if !(200...299).contains(httpResponse.statusCode) {
            let statusCodeError = NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: nil)
            completion(.failure(statusCodeError)) // Если полученный статус код не входит в диапазон успешных кодов, вызываем обратный вызов с ошибкой статуса HTTP.
            return
        }
        
        // Проверка данных ответа для проверки входа
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let loginResponse = try decoder.decode(UserInfo.self, from: data)
                // Сохранение логина в Keychain
                if let loginData = login.data(using: .utf8) {
                    let saveLoginQuery: [String: Any] = [
                        kSecClass as String: kSecClassGenericPassword,
                        kSecAttrAccount as String: "myAppLogin",
                        kSecValueData as String: loginData
                    ]
                    SecItemDelete(saveLoginQuery as CFDictionary)
                    SecItemAdd(saveLoginQuery as CFDictionary, nil)
                }
                
                // Сохранение пароля в Keychain
                if let passwordData = password.data(using: .utf8) {
                    let savePasswordQuery: [String: Any] = [
                        kSecClass as String: kSecClassGenericPassword,
                        kSecAttrAccount as String: "myAppPassword",
                        kSecValueData as String: passwordData
                    ]
                    SecItemDelete(savePasswordQuery as CFDictionary)
                    SecItemAdd(savePasswordQuery as CFDictionary, nil)
                }
                completion(.success(loginResponse))
            } catch {
                completion(.failure(error))
            }
        } else {
            let noDataError = NSError(domain: "No Data Error", code: 0, userInfo: nil)
            completion(.failure(noDataError))
        }
    }
    task.resume() // Запуск выполнения запроса.
}