import SwiftUI

struct MainMenuView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            PersonView()
                .padding(.bottom, 50)
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(0)

            BusView()
                .tabItem {
                    Image(systemName: "bus")
                }
                .tag(1)

            QRCodeView()
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                }
                .tag(2)
        }
    }
}

//struct MainMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainMenuView()
//    }
//}
