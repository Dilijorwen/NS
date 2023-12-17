import SwiftUI

struct Trip: Codable{
    let id: Int
    let departure_time: String
    let days: [Int]
    let driver: Driver
    let bus: Bus
    let stations: [String]
}


final class TripInfo: ObservableObject{
    
    @Published var trip_id: Int? {
        didSet {
            UserDefaults.standard.set(trip_id, forKey: "trip_id" )
            
        }
    }
    
    @Published var departure_time: String? {
        didSet {
            UserDefaults.standard.set(departure_time, forKey: "departure_time" )
            
        }
    }
    
    @Published var days: [Int]? {
        didSet {
            UserDefaults.standard.set(days, forKey: "days" )
            
        }
    }

    @Published var stations: [String]? {
        didSet {
            UserDefaults.standard.set(stations, forKey: "stations" )
            
        }
    }
    
    init(){
        self.trip_id = 0
        self.departure_time = ""
        self.days = []
        self.stations = []
    }
    
}
