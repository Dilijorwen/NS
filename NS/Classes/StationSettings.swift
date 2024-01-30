import Foundation

final class Settings: ObservableObject {
    
    @Published var isTripStarted: Bool = false
    @Published var selectedID = 0
        
}

