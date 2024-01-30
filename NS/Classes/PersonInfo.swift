import Foundation

final class PersonInfo: ObservableObject{
    
    @Published var first_name: String {
        didSet {
            UserDefaults.standard.set(first_name, forKey: "first_name" )
            
        }
    }
    
    @Published var last_name: String {
        didSet {
            UserDefaults.standard.set(last_name, forKey: "last_name" )
            
        }
    }
    
    @Published var patronymic: String {
        didSet {
            UserDefaults.standard.set(patronymic, forKey: "patronymic" )
            
        }
    }

    @Published var bus_code: Int {
        didSet {
            UserDefaults.standard.set(bus_code, forKey: "bus_code" )
            
        }
    }
    
    init(){
        self.first_name = ""
        self.last_name = ""
        self.patronymic = ""
        self.bus_code = 0
    }
    
}
