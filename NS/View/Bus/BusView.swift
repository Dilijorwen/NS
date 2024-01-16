import SwiftUI

struct BusView: View {
    
    let userData: [DailySchedule]
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.indices, id: \.self) { index in
                    NavigationLink(destination: StationView(userData: userData[index])) {
                        VStack(alignment: .leading) {
                            Text(userData[index].trip.stations.first ?? "")
                                .font(.headline)
                            Text(userData[index].trip.departure_time)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationBarTitle("Расписание")
        }
    }
}

//struct BusView_Previews: PreviewProvider {
//    static var previews: some View {
//        BusView()
//    }
//}
