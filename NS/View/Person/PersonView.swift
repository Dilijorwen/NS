import SwiftUI

struct PersonView: View {
    
    @State private var login: String = ""
    @State private var password: String = ""
    @EnvironmentObject var settings: UserSettings
    @EnvironmentObject var User: PersonInfo
    @EnvironmentObject var Trip: TripInfo
    
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
                .frame(width: 341, height: 54, alignment: .center)
                .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                .cornerRadius(30)
            }.padding(.bottom, 18)
                .padding(.top, 29)
            
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
                .frame(width: 341, height: 54, alignment: .center)
                .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                .cornerRadius(30)
            }.padding(.bottom, 28)
            
            HStack(alignment: .center, spacing: 0) {
                Text("\(User.patronymic)")
                .font(
                Font.custom("Montserrat", size: 24)
                .weight(.medium)
                )
                .foregroundColor(Color(red: 0.19, green: 0.19, blue: 0.19))
                .frame(width: 295, alignment: .topLeading)
                .padding(.horizontal, 23)
                .padding(.vertical, 21)
                .frame(width: 341, height: 54, alignment: .center)
                .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                .cornerRadius(30)
            }.padding(.bottom, 28)
            
            HStack(alignment: .center, spacing: 0) {
                Text("\(User.bus_code)")
                .font(
                Font.custom("Montserrat", size: 24)
                .weight(.medium)
                )
                .foregroundColor(Color(red: 0.19, green: 0.19, blue: 0.19))
                .frame(width: 295, alignment: .topLeading)
                .padding(.horizontal, 23)
                .padding(.vertical, 21)
                .frame(width: 341, height: 54, alignment: .center)
                .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                .cornerRadius(30)
            }.padding(.bottom, 48)
            
            VStack {
                HStack{
                    Button(action: {
                        if let retrievedLogin = Credentials.retrieveLogin(),
                           let retrievedPassword = Credentials.retrievePassword() {
                            Login(login: retrievedLogin, password: retrievedPassword) { result in
                                switch result {
                                case .success(let loginResponse):
                                    User.first_name = loginResponse.first_name
                                    User.last_name = loginResponse.last_name
                                    User.bus_code = loginResponse.bus_code
                                    User.patronymic = loginResponse.patronymic
                                    Trip.trip_id = loginResponse.daily_schedule.first?.trip.id
                                    Trip.departure_time = loginResponse.daily_schedule.first?.trip.departure_time
                                    Trip.stations = loginResponse.daily_schedule.first?.trip.stations
                                    Trip.days = loginResponse.daily_schedule.first?.trip.days
                                case .failure(let error):
                                    settings.isLoggedIn = false
                                    print(error)
                                }
                            }
                        } else {
                            settings.isLoggedIn = false
                        }
                    }) {
                        Text("Обновить")
                            .preferredColorScheme(.light)
                            .font(
                                Font.custom("Montserrat", size: 20)
                                    .weight(.bold)
                            )
                            .frame(width: 265, height: 54, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color(red: 0.44, green: 0.5, blue: 0.55))
                            .cornerRadius(30)
                        
                    }
                }
            }.padding(.bottom, 77)
            
            HStack{
                Button(action: {
                    settings.isLoggedIn = false
                }) {
                        Text("Выйти")
                            .preferredColorScheme(.light)
                            .font(
                                Font.custom("Montserrat", size: 20)
                                    .weight(.bold)
                            )
                            .frame(width: 265, height: 54, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color(.black))
                            .cornerRadius(30)
                        
                    }
            }
        }
    }
}


//struct PersonView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonView()
//    }
//}
