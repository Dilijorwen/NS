import SwiftUI

class Settings: ObservableObject {
    @Published var isTripStarted: Bool = false
    @Published var selectedID = 0
        
}

struct StationView: View {
    
    let userData: DailySchedule
    
    @EnvironmentObject var settings: Settings
    
    
    @State private var showingAlert = false
    @State private var currentIndex = 0
    
    
    private var isFirstStation: Bool {
        currentIndex == 0
    }
    
    private var isLastStation: Bool {
        currentIndex == (userData.trip.stations.count) - 2
    }
    
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Text("Время: \(userData.trip.departure_time)")
                    Spacer()
                    Text("Станция: \(userData.trip.stations[currentIndex])")
                }
                Image(systemName: "arrow.down")
                HStack{
                    Text("Время: \(userData.trip.departure_time)")
                    Spacer()
                    Text("Станция: \(userData.trip.stations[currentIndex + 1])")
                }
            }
            .padding()
            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
            .frame(width: 341, alignment: .leading)
            .cornerRadius(30)
            .foregroundColor(.black.opacity(0.6))
            VStack {
                Button(action: {
                    if !isLastStation {
                        currentIndex += 1
                    }
                }) {
                    Text("Следующий сегмент")
                        .frame(width: 341, height: 54, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color(red: 0.9, green: 0.83, blue: 0.59))
                        .cornerRadius(30)
                }
                .disabled(isLastStation)
                
                Button(action: {
                    if !isFirstStation {
                        currentIndex -= 1
                    }
                }) {
                    Text("Предыдущий сегмент")
                        .frame(width: 341, height: 54, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color(red: 0.9, green: 0.83, blue: 0.59))
                        .cornerRadius(30)
                }
                .disabled(isFirstStation)
            }
            Spacer()
            
            Button(action: {
                settings.selectedID = userData.id
                if settings.isTripStarted {
                    showingAlert = true
                } else {
                    settings.isTripStarted.toggle()
                }
            }) {
                Text(settings.isTripStarted ? "Закончить поездку" : "Начать поездку")
                    .frame(width: 341, height: 54, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(settings.isTripStarted ? .red : Color(red: 0.67, green: 0.9, blue: 0.59)))
                    .cornerRadius(30)
            }
            .padding(.bottom, 10)
            .alert("Вы уверены, что хотите оменить поездку?", isPresented: $showingAlert){
                
                Button("Да"){
                    settings.isTripStarted.toggle()
                    /// Здесь отсылаю данные
                }
                
                Button("Нет", role: .cancel) {
                    
                }
                
            }
        }
    }
}


//struct StationView_Previews: PreviewProvider {
//    static var previews: some View {
//        StationView()
//    }
//}
