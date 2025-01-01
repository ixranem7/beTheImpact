import SwiftUI
import UIKit

struct ViewMainpage: View {
    
    @State private var showActionSheet = false
    @State private var showCamera: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var showSelectedImage: Bool = false
    @State var cameraImage: UIImage?
    @State private var cameraError: CameraPermission.CameraError?
    
    @State var shouldNavigate: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.pur.opacity(12), Color.pur.opacity(0.6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 18) {
                    // Main texts
                    Text("Welcome to your digital wardrobe!")
                        .font(.custom("Tajawal-Bold", size: 36))
                        .lineSpacing(5)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .accessibilityLabel("Welcome to your digital wardrobe!")
                        .accessibilityHint("Welcome to your digital wardrobe!")
                    
                    Text("Use the camera or upload to explore your outfit")
                        .font(.custom("Tajawal-Regular", size: 18))
                        .lineSpacing(5)
                        .foregroundColor(Color.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .accessibilityLabel("Use the camera or upload to explore your outfit")
                        .accessibilityHint("Use the camera or upload to explore your outfit")
                    
                    Spacer()
                }.padding(.top, 70)
                
                VStack {
                    // Button
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showActionSheet = true // Show the ActionSheet when the button is pressed
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.8))
                                .frame(width: 150, height: 150)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                            
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color("pur"))
                        }
                    }
                    .padding(.top, 400)
                    .padding()
                    .scaleEffect(showActionSheet ? 1.1 : 1.0) // Zoom effect when pressed
                    .accessibilityLabel("camera button")
                    .accessibilityHint("camera button")
                    .animation(.spring(), value: showActionSheet)
                    
                    Spacer()
                }
                .padding()
                
                // ActionSheet for choosing to either take a photo or upload an image from the gallery
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(
                        title: Text("Choose an option"),
                        buttons: [
                            .default(Text("Take a photo")) {
                                if let error = CameraPermission.checkPermission() {
                                    cameraError = error
                                }else{
                                    showCamera.toggle()
                                    showSelectedImage=true
                                }
                                // If the user chooses to take a photo
                            },
                            .default(Text("Upload from Photos")) {
                                showImagePicker.toggle()
                               showSelectedImage=true// If the user chooses to upload a photo
                            },
                            .cancel() // Close the ActionSheet
                        ]
                    )
                }
                .alert(isPresented: .constant(cameraError != nil), error: cameraError){ _ in
                    Button("OK"){
                        cameraError = nil
                    }
                } message: { error in
                    Text(error.recoverySuggestion ?? "Try again later") }
                
                // Display the camera in full-screen when selected
                .fullScreenCover(isPresented: $showCamera) {
                    //showSelectedImage=true
                    UIKitCamera(selectedImage: $cameraImage)
                        .ignoresSafeArea()// Open the camera in a new view
                }
                
                // Display the ImagePicker to choose an image from the gallery
                .fullScreenCover(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $cameraImage) // Show ImagePicker for selecting an image
                }
                
                .fullScreenCover(isPresented: $showSelectedImage) {
                    OutfitDetails(realImage:$cameraImage)}
                
                     // Open the camera in a new view
                }
            }.navigationBarBackButtonHidden(true)
        }
    }


//struct CameraView: View {
//    @Binding var selectedImage: UIImage?
//    
//    var body: some View {
//        UIKitCamera(selectedImage: $selectedImage)
//            .edgesIgnoringSafeArea(.all) // Make the camera cover the entire screen
//
//    }
//}


#Preview {
    ViewMainpage()
}


