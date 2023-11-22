import SwiftUI

struct LogInView: View {
    
    @Binding var isLoggedIn: Bool
    @State private var login = ""
    @State private var password = ""
    @State private var isSecure = true
    
    
    struct LoginResponse: Codable {
        let code: Int?
        let message: String
        let data: UserData
    }

    struct UserData: Codable {
        let token: String
        let id: Int
        let first_name: String
        let last_name: String
        let role: String
    }
    
    var body: some View {
        ZStack{
            Image("Path")
            VStack{
                HStack{
                    Text("Вход")
                        .preferredColorScheme(.light)
                        .font(
                            Font.custom("Montserrat", size: 40)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.188, green: 0.19, blue: 0.19))
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
                        log_in(login: login, password: password) { result in
                            switch result {
                            case .success(let loginResponse):
                                isLoggedIn = true // Добавляем анимацию при изменении состояния
                                print(loginResponse)
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


//#Preview {
//    LogInView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}

//Эта строка создает задачу (task) с использованием URLSession для выполнения запроса на основе предоставленного URLRequest.
//URLSession.shared: Это общий экземпляр URLSession, который предоставляется по умолчанию для работы с сетевыми запросами. .shared указывает на общий экземпляр URLSession, который может использоваться в приложении.
//dataTask(with:completion:): Это метод URLSession, который создает задачу (dataTask), которая выполняет запрос по указанному URLRequest.
//request: Это объект типа URLRequest, который представляет собой запрос, содержащий информацию о методе запроса (например, GET, POST), URL, заголовках, теле запроса и других деталях.
//{ data, response, error in ... }: Это замыкание (closure) или обработчик завершения, который будет вызван после завершения выполнения задачи. В нем предоставляются три опциональных параметра: data содержит данные ответа от сервера, response содержит объект URLResponse, представляющий ответ сервера, а error содержит ошибку, если что-то пошло не так во время выполнения запроса.
