import SwiftUI

struct LogInView: View {
    
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var isSecure: Bool = true
    @EnvironmentObject var settings: UserSettings
    
    
    var body: some View {
        if settings.isLoggedIn{
            MainMenuView()
                .environmentObject(settings)
        } else {
            if UserDefaults.standard.bool(forKey: "login") == true {
                MainMenuView()
                    .environmentObject(settings)
            } else {
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
                                        settings.isLoggedIn = true
//                                        UserDefaults.standard.set(loginResponse.data.id, forKey: "userID")
//                                        UserDefaults.standard.set(loginResponse.data.token, forKey: "userToken")
//                                        UserDefaults.standard.set(loginResponse.data.last_name, forKey: "userLastName")
//                                        UserDefaults.standard.set(loginResponse.data.first_name, forKey: "userFirsName")
                                        print(loginResponse)
                                    case .failure(let error):
                                        debugPrint(error)
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
        }
    }
}
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
