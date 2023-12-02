import SwiftUI



func Login(login: String, password: String, completion: @escaping (Result<UserInfo, Error>) -> Void) {
    // Определение URL вашего API для входа
    let loginURL = URL(string: "https://spacekot.ru/apishechka/login")!
    
    // Создание запроса
    var request = URLRequest(url: loginURL)
    request.httpMethod = "POST"
    
    // Установка тела запроса с учетными данными пользователя
    let requestBody: [String: Any] = [
        "login": login,
        "password": password
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

//Эта строка создает задачу (task) с использованием URLSession для выполнения запроса на основе предоставленного URLRequest.
//URLSession.shared: Это общий экземпляр URLSession, который предоставляется по умолчанию для работы с сетевыми запросами. .shared указывает на общий экземпляр URLSession, который может использоваться в приложении.
//dataTask(with:completion:): Это метод URLSession, который создает задачу (dataTask), которая выполняет запрос по указанному URLRequest.
//request: Это объект типа URLRequest, который представляет собой запрос, содержащий информацию о методе запроса (например, GET, POST), URL, заголовках, теле запроса и других деталях.
//{ data, response, error in ... }: Это замыкание (closure) или обработчик завершения, который будет вызван после завершения выполнения задачи. В нем предоставляются три опциональных параметра: data содержит данные ответа от сервера, response содержит объект URLResponse, представляющий ответ сервера, а error содержит ошибку, если что-то пошло не так во время выполнения запроса.

