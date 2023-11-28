import SwiftUI

struct PersonView: View {
    
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        VStack{
            HStack(alignment: .center, spacing: 0) {
                Text("Имя")
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
                Text("Фамилия")
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
                Text("Код")
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
                        //
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


struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
