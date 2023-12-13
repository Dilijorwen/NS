import SwiftUI
import AVKit

struct QRCodeView: View {
    @State private var isShowingPopup = false
    @State private var ticketId = ""
    @State private var flightNumber = ""
    @State private var seatNumber = ""
    @State private var timeStart = ""
    @State private var codeNumber = ""
    @State private var Verification = ""
    
    @State private var isScanning: Bool = false
    @State private var  session: AVCaptureSession = .init()
    @State private var cameraPermisson: Permission = .idle
    
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @Environment(\.openURL) private var openURL
    
    @StateObject private var qrDelegate = QRScannerDelegate()
    
    @State private var scannedCode: String = ""
    var body: some View {
        VStack(spacing: 8){
            Text("Область QR-кода внутри арены")
                .font(.title3)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top, 40)
            
            Text("Сканер автоматически сработает")
                .font(.callout)
                .foregroundStyle(.gray)
            
            ///Scaner
            Spacer(minLength: 0)
            
            GeometryReader{
                let size = $0.size
                
                ZStack{
                    CamerView(frameSize: CGSize(width: 210, height: 210), session: $session)
                        .scaleEffect(0.97)
                    ForEach(0...4, id: \.self) { index in
                        let rotation = Double(index) * 90
                        
                        RoundedRectangle(cornerRadius: 2, style: .circular)
                            .trim(from:0.61, to: 0.64)
                            .stroke(.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.init(degrees: rotation))
                    }
                }
                .frame(width: 210, height: 210)
                
                .overlay(alignment: .top, content: {
                    Rectangle()
                        .fill(.blue)
                        .frame(height: 2.5)
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.8), radius: 8, x: 0, y: isScanning ? 15 : -15)
                        .offset(y: isScanning ? size.width: 0)
                })
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 210, height: 210)
            .padding(.horizontal, 45)
            
            Spacer(minLength: 15)
            
            Button(action:{
                if !session.isRunning && cameraPermisson == .approved{
                    reactivateCamera()
                    activeScannerAnimation()
                }
            }) {
                Text("Сканировать заново")
                    .preferredColorScheme(.light)
                    .font(
                        Font.custom("Montserrat", size: 20)
                            .weight(.bold)
                    )
                    .frame(width: 265, height: 54, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(.blue))
                    .cornerRadius(30)
                
            }
            
            Button(action: {
                isShowingPopup.toggle()
            }) {
                Text("Ввести данные")
                    .preferredColorScheme(.light)
                    .font(
                        Font.custom("Montserrat", size: 20)
                            .weight(.bold)
                    )
                    .frame(width: 265, height: 54, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(red: 0.44, green: 0.5, blue: 0.55))
                    .cornerRadius(35)
                
            }
            .popover(isPresented: $isShowingPopup, arrowEdge: .top) {
                VStack {
                    Text("Введите данные пользователя, чтобы проверить билет")
                        .font(.title3)
                        .foregroundColor(.black.opacity(0.8))
                        .padding(.top, 30)
                        .multilineTextAlignment(.center)
                    
                    VStack(alignment: .center, spacing: 25){
                        TextField("ID Билета", text: $ticketId)
                            .padding(.horizontal, 48)
                            .frame(height: 54, alignment: .center)
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            .cornerRadius(30)
                        
                        TextField("Номер рейса", text: $flightNumber)
                            .padding(.horizontal, 48)
                            .frame(height: 54, alignment: .center)
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            .cornerRadius(30)
                        
                        TextField("Номер места", text: $seatNumber)
                            .padding(.horizontal, 48)
                            .frame(height: 54, alignment: .center)
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            .cornerRadius(30)
                        
                        TextField("Время начала рейса", text: $timeStart)
                            .padding(.horizontal, 48)
                            .frame(height: 54, alignment: .center)
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            .cornerRadius(30)
                        
                        TextField("Код билета", text: $codeNumber)
                            .padding(.horizontal, 48)
                            .frame(height: 54, alignment: .center)
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                            .cornerRadius(30)
                    }
                    .padding()
                    
                    Button(action: {
                        Verification = ticketId + flightNumber + seatNumber + timeStart
                        
                    }) {
                        Text("Проверить")
                            .foregroundColor(.white)
                            .frame(width: 265, height: 54, alignment: .center)
                            .background(Color(red: 0.44, green: 0.5, blue: 0.55))

                            .cornerRadius(30)
                        
                    }
                    .padding()
                }
                .background(Color.white)
                .cornerRadius(10)
                .padding()
            }
            Spacer()
            
        }
        .padding(15)
        .onAppear(perform: checkCameraPermission)
        .alert(errorMessage, isPresented: $showError){
            if cameraPermisson == .denied{
                Button("Settings"){
                    let settingsString = UIApplication.openSettingsURLString
                    if let settingURl = URL(string: settingsString){
                        openURL(settingURl)
                    }
                }
                
                Button("Cancel", role: .cancel) {
                    
                }
            }
        }
        .onChange(of: qrDelegate.scannedCode) { oldValue, newValue in
            if let code = newValue {
                scannedCode = code
                session.stopRunning()
                deActiveScannerAnimation()
                qrDelegate.scannedCode = nil
            }
        }
    }
    
    func reactivateCamera(){
        DispatchQueue.global(qos: .background) . async {
            session.startRunning()
        }
    }
    
    
    func setupCamera() {
        do {
            ///Ищем заднюю камеру
            ///Так же в коде мы использовали поиск обычной камеры, а не ультраширокой, чтобы охватить больший спектр людей
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
                presentError("НЕИЗВЕСТНАЯ ОШИБКА УСТРОЙСТВА")
                return
            }
            ///Вводим камеру
            let input = try AVCaptureDeviceInput(device: device)
            ///Для безопасности
            ///Проверка возможности добавления ввода и вывода в сессию
            if session.canAddInput(input) && session.canAddOutput(qrOutput) {
                ///Добовляем ввод и вывод для камеры
                session.addInput(input)
                session.addOutput(qrOutput)
                ///Добавляем delegate для получения полученного QR-кода с камеры
                qrOutput.metadataObjectTypes = qrOutput.availableMetadataObjectTypes
                qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
                ///сессия может начаться только на заднем плане
                DispatchQueue.global(qos: .background).async {
                    session.startRunning()
                }
                activeScannerAnimation()
            } else {
                presentError("НЕИЗВЕСТНАЯ ОШИБКА ВВОДА/ВЫВОДА")
            }
        } catch {
            presentError(error.localizedDescription)
        }
    }
    
    
    func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
    
    func activeScannerAnimation(){
        withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)){
            isScanning = true
        }
    }
    
    func deActiveScannerAnimation(){
        withAnimation(.easeInOut(duration: 0.85)){
            isScanning = false
        }
    }
    
    func checkCameraPermission(){
        Task{
            switch AVCaptureDevice.authorizationStatus(for: .video){
            case .authorized:
                cameraPermisson = .approved
                if session.inputs.isEmpty{
                    setupCamera()
                } else {
                    session.startRunning()
                }
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermisson = .approved
                    setupCamera()
                } else {
                    cameraPermisson = .denied
                    presentError("Пожалуйста поддтвердите использование камеры для сканирования кода")
                }
            case .denied, .restricted:
                cameraPermisson = .denied
                presentError("Пожалуйста поддтвердите использование камеры для сканирования кода")
            default: break
            }
        }
    }
}


//struct QRView_Previews: PreviewProvider {
//    static var previews: some View {
//        QRCodeView()
//    }
//}
