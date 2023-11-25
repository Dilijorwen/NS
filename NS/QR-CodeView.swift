import SwiftUI

struct QRCodeView: View {
    
    @State var fristName: String = ""
    @State var lastName: String = ""
    @State var fatherName: String = ""
    @State var Code: String = ""
    
    
    var body: some View {
       Text("QR")
    }
}

struct QRView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView()
    }
}
