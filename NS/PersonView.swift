import SwiftUI

struct PersonView: View {
    @State var gg: String = "Даниил"
    
    var body: some View {
        VStack{
            
            
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
                    //
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
