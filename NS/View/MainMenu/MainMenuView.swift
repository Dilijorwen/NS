import SwiftUI

struct MainMenuView: View {
    
    @Binding var schedule: [DailySchedule]
    
    @State private var selectedTab = 0
    @EnvironmentObject var settings: Settings
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PersonView(schedule: $schedule)
                .padding(.bottom, 50)
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(0)
            
            BusView(schedule: schedule)
                .tabItem {
                    Image(systemName: "bus")
                }
                .tag(1)
            
            QRCodeView(settings: _settings)
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                }
                .tag(2)
            
        }.background(.white)
    }
}

//struct MainMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainMenuView()
//    }
//}
