import SwiftUI

struct MainMenuView: View {
    
    @State private var selectedTab = 1
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            PersonView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Вкладка 1")
                }
                .tag(0) // тег, связанный с этим представлением

            Text("Главный экран 2")
                .tabItem {
                    Image(systemName: "bus")
                    Text("Вкладка 2")
                }
                .tag(1) // тег, связанный с этим представлением

            Text("Главный экран 3")
                .tabItem {
                    Image(systemName: "bus")
                    Text("Вкладка 2")
                }
                .tag(2) // тег, связанный с этим представлением
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
