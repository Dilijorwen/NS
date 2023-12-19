import SwiftUI

struct BusView: View {
    @EnvironmentObject var trip: TripInfo
    
    
    var body: some View {
        VStack{
            Text("Расписание")
                .font(.headline)
            NavigationView {
                ScrollView {
                    NavigationLink {
                        StationView()
                    } label: {
                        if let firstStation = trip.stations?[safe: 0] {
                            HStack {
                                Text("Время: \(trip.departure_time ?? "")")
                                Spacer()
                                Text("Первая станция: \(firstStation)")
                            }
                        } else {
                            Text("Нет доступных станций")
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding()
                    .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                    .frame(width: 341, alignment: .leading)
                    .cornerRadius(30)
                    .foregroundColor(.black.opacity(0.6))
                }
            }
        }
    }
}

//struct BusView_Previews: PreviewProvider {
//    static var previews: some View {
//        BusView()
//    }
//}
