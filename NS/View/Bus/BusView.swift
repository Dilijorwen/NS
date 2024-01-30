import SwiftUI

struct BusView: View {
    
    let schedule: [DailySchedule]
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(schedule.indices, id: \.self) { index in
                    NavigationLink(destination: StationView(schedule: schedule[index])) {
                        VStack(alignment: .leading) {
                            Text(schedule[index].trip.stations.first ?? "")
                                .font(.headline)
                            Text(schedule[index].trip.departure_time)
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
