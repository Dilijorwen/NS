import SwiftUI

@main
struct NSApp: App {
    
    var body: some Scene {
        WindowGroup {
            LogInView()
                .preferredColorScheme(.light)
                .environmentObject(UserSettings())
                .environmentObject(PersonInfo())
                .environmentObject(Settings())
        }
    }
}
