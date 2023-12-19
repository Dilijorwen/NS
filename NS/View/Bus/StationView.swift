import SwiftUI

struct StationView: View {
    @EnvironmentObject var trip: TripInfo
    
    @State private var currentIndex = 0
    @State private var idTrip = 0
    
    private var isFirstStation: Bool {
        currentIndex == 0
    }
    
    private var isLastStation: Bool {
        currentIndex == (trip.stations?.count ?? 0) - 2
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                if let stations = trip.stations {
                    HStack {
                        Text("Время: \(trip.departure_time ?? "")")
                        Spacer()
                        Text("Название первой станции: \(stations[currentIndex])")
                    }
                    Image(systemName: "arrow.down")
                        .font(.title3)
                    if currentIndex < stations.count - 1 {
                        HStack {
                            Text("Время: \(trip.departure_time ?? "")")
                            Spacer()
                            Text("Название следующей станции: \(stations[currentIndex + 1])")
                        }
                    }
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
                trip.isTripStarted.toggle()
                if trip.isTripStarted {

                } else {
                    
                }
            }) {
                Text(trip.isTripStarted ? "Закончить поездку" : "Начать поездку")
                    .frame(width: 341, height: 54, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(trip.isTripStarted ? .red : Color(red: 0.67, green: 0.9, blue: 0.59)))
                    .cornerRadius(30)
            }
            .padding(.bottom, 10)
        }
    }
}


//struct StationView_Previews: PreviewProvider {
//    static var previews: some View {
//        StationView()
//    }
//}
