import SwiftUI

struct ContentView: View {
    @State private var login = ""
    @State private var password = ""
    @State private var isSecure = true
    
    struct LoginResponse: Codable {
        let token: String
        let first_name: String
        let last_name: String
        let role: String
    }
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Вход")
                        .font(
                            Font.custom("Montserrat", size: 40)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.19, green: 0.19, blue: 0.19))
                }.padding(.bottom, 45)
                VStack {
                    
                    HStack(alignment: .center, spacing: 0){
                        TextField("Логин", text: $login)
                            .font(
                                Font.custom("Montserrat", size: 16)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.19, green: 0.19, blue: 0.19))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .frame(width: 272, alignment: .leading)
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                        
                            .cornerRadius(16)
                    }.padding(.bottom, 19)
                    
                    ZStack {
                        if isSecure {
                            SecureField("Пароль", text: $password)
                                .padding(.leading, 16)
                                .padding(.trailing, 9)
                                .padding(.vertical, 10)
                                .frame(width: 272, alignment: .leading)
                                .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            
                                .cornerRadius(16)
                        } else {
                            TextField("Пароль", text: $password)
                                .padding(.leading, 16)
                                .padding(.trailing, 9)
                                .padding(.vertical, 10)
                                .frame(width: 272, alignment: .leading)
                                .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            
                                .cornerRadius(16)
                        }
                        
                        Button(action: {
                            withAnimation {
                                isSecure.toggle()
                            }
                        }) {
                            Image(systemName: isSecure ? "eye.slash" : "eye")
                                .foregroundColor(Color(red: 0.66, green: 0.67, blue: 0.68))
                        }
                        .padding(.leading, 210)
                    }
                }.padding(.bottom, 100)
                
                HStack{
                    Button(action: {
                        /// Вызов функции loginUser при нажатии на кнопку "Вход"
                        log_in(login: login, password: password) { result in
                            switch result {
                            case .success(let loginResponse):
                                print("Успешный вход. Токен: \(loginResponse.token)")
                                // Обработка успешного входа - например, сохранение токена в хранилище
                                // Или переход на следующий экран после успешной авторизации
                            case .failure(let error):
                                debugPrint(error)
                                // Обработка ошибки при входе
                                // Можно показать пользователю сообщение об ошибке
                            }
                        }
                    }) {
                        Text("Войти")
                            .font(
                                Font.custom("Montserrat", size: 16)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 236, height: 44, alignment: .center)
                    }
                }.padding(.horizontal, 12)
                    .padding(.top, 7)
                    .padding(.bottom, 8)
                    .frame(width: 236, height: 44, alignment: .center)
                    .background(Color(red: 0.44, green: 0.5, blue: 0.55))
                
                    .cornerRadius(16)
                
                
                
            }
        }
    }
    
    
    func log_in(login: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
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
                    let loginResponse = try decoder.decode(LoginResponse.self, from: data)
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
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
