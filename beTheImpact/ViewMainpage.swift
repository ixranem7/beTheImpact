
import SwiftUI


struct ViewMainpage: View {
    @State private var showAlert = false
    @State private var showCamera: Bool = false
    @State private var cameraError: CameraPermission.CameraError?
    @State var cameraImage: UIImage?
    
    var body: some View {
        ZStack{
            VStack {
                Text("Welcome to your digital wardrobe!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.3, green: 0.2, blue: 0.5, opacity: 1.0))
                    .multilineTextAlignment(.leading)
                    .padding(.top , -30)
                    .padding(.trailing , 90)
                
                Text(" Use the camera to know the outfit:")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.pur)
                    .multilineTextAlignment(.leading)
                    .padding(.top , -10)
                    .padding(.trailing , 40)
                
                Button(action: {
                    showAlert = true
            
                    
                }) {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()          .frame(width: 100, height: 100)
                    .font(.title)
                        .padding()
                        .frame(width: 350, height: 400)
                        .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.pur.opacity(0.7), Color.pur]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                        
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.top , 50)

                }.shadow(radius: 10)

            }.blur(radius: showAlert ? 5 : 0)
                
            .alert("Camera Instructions", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    
                    if let error = CameraPermission.checkPermission() {
                        cameraError = error
                    }else {
                        showCamera.toggle()
                       
                    }
                    
                }
        
                }message: {
                Text("Make sure you are slightly away from the camera so the piece appears clearly")
                }
                
                .alert(isPresented: .constant(cameraError != nil), error: cameraError){ _ in
                        Button("OK"){
                            cameraError = nil
                        }
                    } message: { error in
                        Text(error.recoverySuggestion ?? "Try again later") }
                    .sheet(isPresented: $showCamera){
                        UIKitCamera(selectedImage: $cameraImage)
                            //.ignoresSafeArea()
                    }
                    
                    if let image = cameraImage {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 300.0, height: 200.0)
                        
                    } else {
//                        VStack{
//                            Image(systemName:"photo.badge.plus")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 80, height: 60)
//                                .foregroundColor(Color(red: 0.984313725490196, green: 0.3803921568627451, blue: 0.07058823529411765))
//                            Text("Upload Photo")
//                                .font(.title)
//                                .fontWeight(.bold)
//                                .foregroundColor(Color(red: 0.984313725490196, green: 0.3803921568627451, blue: 0.07058823529411765))
//                            //.offset(y: 55)
//                        }
                    }
                
            
        }
        .padding()
    }
}

#Preview {
    ViewMainpage()
}

//struct CameraView : View {
//    @Binding var cameraImage: UIImage?
//    @Binding var showCamera: Bool
//    var body: some View {
//        VStack{
//            
//            UIKitCamera(selectedImage: $cameraImage)
//                    
//        }
//    }
//}
