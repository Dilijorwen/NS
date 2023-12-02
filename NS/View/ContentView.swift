import Foundation

class UserSettings: ObservableObject{
    
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "login" )
        }
    }
    
    init(){
        self.isLoggedIn = false
    }
}
