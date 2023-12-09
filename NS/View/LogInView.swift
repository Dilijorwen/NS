import SwiftUI
import Security

struct LogInView: View {
    
    @State private var login = ""
    @State private var password = ""
    @State private var isSecure: Bool = true
    @State private var loginError: String?
    
    
    @EnvironmentObject var settings: UserSettings
    @EnvironmentObject var User: PersonInfo
    
    
    var body: some View {
        if settings.isLoggedIn{
            MainMenuView()
                .environmentObject(settings)
        } else {
//            if UserDefaults.standard.bool(forKey: "isLogin") == true {
//                MainMenuView()
//                    .environmentObject(settings)
//            } else {
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
                                Login(login: login, password: password) { result in
                                    switch result {
                                    case .success(let loginResponse):
                                        if let retrievedLogin = KeychainService.retrieveLogin(),
                                           let retrievedPassword = KeychainService.retrievePassword() {
                                            print("Login retrieved from Keychain: \(retrievedLogin)")
                                            print("Password retrieved from Keychain: \(retrievedPassword)")
                                        } else {
                                            print("Failed to retrieve login or password from Keychain.")
                                        }
                                        settings.isLoggedIn = true
                                        User.first_name = loginResponse.first_name
                                        User.last_name = loginResponse.last_name
                                        User.id = loginResponse.id
                                        print(loginResponse)
                                    case .failure(let error):
                                        loginError = "Ошибка ввода пароля"
                                        print(error)
                                        
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
                        if loginError == "Ошибка ввода пароля"{
                            Text("Неправильный логин или пароль")
                                .foregroundColor(.red)
                                .padding(.top, 34)
                        }
                    }
                }
            }
        }
//    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogInView()
//    }
//}
