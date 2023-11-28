import SwiftUI

@main
struct NSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LogInView()
                .preferredColorScheme(.light)
                .environmentObject(UserSettings())
        }
    }
}
