import SwiftUI

struct PersonView: View {
    
    @State private var login: String = ""
    @State private var password: String = ""
    @EnvironmentObject var settings: UserSettings
    @EnvironmentObject var User: PersonInfo
    
    var body: some View {
        VStack{
            HStack(alignment: .center, spacing: 0) {
                Text("\(User.first_name)")
                .font(
                Font.custom("Montserrat", size: 24)
                .weight(.medium)
                )
                .foregroundColor(Color(red: 0.19, green: 0.19, blue: 0.19))
                .frame(width: 295, alignment: .topLeading)
                .padding(.horizontal, 23)
                .padding(.vertical, 21)
                .frame(width: 341, height: 66, alignment: .center)
                .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                .cornerRadius(30)
            }.padding(.bottom, 18)
                .padding(.top, 39)
            
            HStack(alignment: .center, spacing: 0) {
                Text("\(User.last_name)")
                .font(
                Font.custom("Montserrat", size: 24)
                .weight(.medium)
                )
                .foregroundColor(Color(red: 0.19, green: 0.19, blue: 0.19))
                .frame(width: 295, alignment: .topLeading)
                .padding(.horizontal, 23)
                .padding(.vertical, 21)
                .frame(width: 341, height: 66, alignment: .center)
                .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                .cornerRadius(30)
            }.padding(.bottom, 18)
            
            HStack(alignment: .center, spacing: 0) {
                Text("Отчество")
                .font(
                Font.custom("Montserrat", size: 24)
                .weight(.medium)
                )
                .foregroundColor(Color(red: 0.19, green: 0.19, blue: 0.19))
                .frame(width: 295, alignment: .topLeading)
                .padding(.horizontal, 23)
                .padding(.vertical, 21)
                .frame(width: 341, height: 66, alignment: .center)
                .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                .cornerRadius(30)
            }.padding(.bottom, 18)
            
            HStack(alignment: .center, spacing: 0) {
                Text("\(User.id)")
                .font(
                Font.custom("Montserrat", size: 24)
                .weight(.medium)
                )
                .foregroundColor(Color(red: 0.19, green: 0.19, blue: 0.19))
                .frame(width: 295, alignment: .topLeading)
                .padding(.horizontal, 23)
                .padding(.vertical, 21)
                .frame(width: 341, height: 66, alignment: .center)
                .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                .cornerRadius(30)
            }.padding(.bottom, 38)
            
            VStack {
                HStack{
                    Button(action: {
                        if let retrievedLogin = KeychainService.retrieveLogin(),
                           let retrievedPassword = KeychainService.retrievePassword() {
                            Login(login: retrievedLogin, password: retrievedPassword) { result in
                                switch result {
                                case .success(let loginResponse):
                                    User.first_name = loginResponse.first_name
                                    User.last_name = loginResponse.last_name
                                    User.id = loginResponse.id
                                case .failure(let error):
                                    print(error)
                                }
                            }
                        }
                    }) {
                        Text("Обновить")
                        .font(
                        Font.custom("Montserrat", size: 24)
                        .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)

                        .frame(width: 212, height: 29, alignment: .center)
                    }
                }.padding(.leading, 64)
                    .padding(.trailing, 65)
                    .padding(.top, 19)
                    .padding(.bottom, 18)
                    .frame(width: 341, height: 66, alignment: .center)
                    .background(Color(red: 0.44, green: 0.5, blue: 0.55))
                    .cornerRadius(30)
            }.padding(.bottom, 87)
            
            HStack{
                Button(action: {
                    settings.isLoggedIn = false
                }) {
                    Text("Выйти")
                    .font(
                    Font.custom("Montserrat", size: 24)
                    .weight(.medium)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)

                    .frame(width: 212, height: 29, alignment: .center)
                }
            }.padding(.leading, 64)
                .padding(.trailing, 65)
                .padding(.top, 19)
                .padding(.bottom, 18)
                .frame(width: 341, height: 66, alignment: .center)
                .background(.black)
                .cornerRadius(30)
        }
    }
}


//struct PersonView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonView()
//    }
//}
