import Foundation

final class UserSettings: ObservableObject{
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLogin" )
        }
    }
    
    init(){
        self.isLoggedIn = false
    }
}
