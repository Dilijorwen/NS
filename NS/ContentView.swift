import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false // Переменная для отслеживания входа пользователя
    
    var body: some View {
        if isLoggedIn {
            // Если пользователь вошел, показываем главное меню
            MainMenuView()
        } else {
            // Если пользователь не вошел, показываем экран входа
            LogInView(isLoggedIn: $isLoggedIn)
        }
    }
}

//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
