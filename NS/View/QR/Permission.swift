import SwiftUI

/// Енумка для доступа в камеру
enum Permission: String{
    case idle = "Not Determined"
    case approved = "Access Granted"
    case denied = "Access Denied"
}
