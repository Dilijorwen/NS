import SwiftUI
import Foundation

struct UserInfo: Codable {
    let token: String
    let id: Int64
    let first_name: String
    let last_name: String
    let role: String
}

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

    @Published var id: Int64 {
        didSet {
            UserDefaults.standard.set(id, forKey: "id" )
            
        }
    }
    
    init(){
        self.first_name = ""
        self.last_name = ""
        self.id = 0
    }
    
}


