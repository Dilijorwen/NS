import SwiftUI

struct MainMenuView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            PersonView()
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(0) // тег, связанный с этим представлением

            BusView()
                .tabItem {
                    Image(systemName: "bus")
                }
                .tag(1) // тег, связанный с этим представлением

            QRCodeView()
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
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
