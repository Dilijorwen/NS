import SwiftUI

struct UserInfo: Codable {
    let token: String
    let id: Int16
    let first_name: String
    let last_name: String
    let role: String
}
