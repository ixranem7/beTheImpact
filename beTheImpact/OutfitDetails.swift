import SwiftUI
import CoreML
import UIKit

// MARK: - View
struct OutfitDetails: View {
    
    @State private var predictionResult: String? = nil
    @Binding var realImage: UIImage?
    @State private var showActionSheet2 = false
    @State private var showCamera2: Bool = false
    @State private var showImagePicker2: Bool = false
    @State private var showSelectedImage2: Bool = false
    @State var cameraImage2: UIImage?
    @State private var cameraError: CameraPermission.CameraError?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView{
        VStack {
            
            VStack(alignment: .leading, spacing: 15) {
                if let uiImage = realImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 280, height: 300)
                        .cornerRadius(10)
                        .onAppear {
                            // Perform the prediction when the image appears
                            performPrediction(with: uiImage)
                        }
                } else {
                    Text("Image not found in Assets.")
                        .foregroundColor(.red)
                }
                
                Text("Item Details")
                    .font(.custom("Tajawal-Bold", size: 18))
                    .foregroundColor(Color(hex: "#423F42"))
                    .accessibilityLabel("Item details")
                    .accessibilityHint("Item details")
                
                if let prediction = predictionResult {
                    Text("\(prediction)")
                        .font(.custom("Tajawal-Regular", size: 18))
                        .foregroundColor(Color(hex: "#423F42"))
                        .accessibilityLabel("Details")
                        .accessibilityHint("\(prediction)")
                } else {
                    Text("Just a moment! We're working on finding the best result for you...")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button(action: {
                    showActionSheet2 = true
                }) {
                    Text("Another Piece")
                        .font(.custom("Tajawal-Bold", size: 24))
                        .frame(height: 15)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#3B2860"))
                        .foregroundColor(.white)
                        .cornerRadius(50)
                }
                .accessibilityLabel("Another Piece Button")
                .accessibilityHint("Another Piece")
                
                Button(action: {
                    print("Button 2 tapped")
                }) {
                    Text("Try Again")
                        .font(.custom("Tajawal-Bold", size: 24))
                        .foregroundColor(Color(hue: 0.729, saturation: 0.762, brightness: 0.268))
                        .frame(height: 15)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color(hex: "#69696E"), lineWidth: 1)
                        )
                }
                .accessibilityLabel("Try Again Button")
                .accessibilityHint("Try Again")
                
                
            }
            .actionSheet(isPresented: $showActionSheet2) {
                ActionSheet(
                    title: Text("Choose an option"),
                    buttons: [
                        .default(Text("Take a photo")) {
                            if let error = CameraPermission.checkPermission() {
                                cameraError = error
                            }else{
                                showCamera2.toggle()
                                showSelectedImage2=true
                            }
                            // If the user chooses to take a photo
                        },
                        .default(Text("Upload from Photos")) {
                            showImagePicker2.toggle()
                           showSelectedImage2=true// If the user chooses to upload a photo
                        }, .cancel() // Close the ActionSheet
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
            .fullScreenCover(isPresented: $showCamera2) {
                CameraView(selectedImage: $cameraImage2) // Open the camera in a new view
            }
            
            // Display the ImagePicker to choose an image from the gallery
            .fullScreenCover(isPresented: $showImagePicker2) {
                ImagePicker(selectedImage: $cameraImage2)
            }
            
            .fullScreenCover(isPresented: $showSelectedImage2) {
                SecondOutfitDetails(realImage2:$cameraImage2)}
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    Text("Back").bold()
                        .foregroundColor(Color.pur)
                }
            }}
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }}
    
    // MARK: - Perform Prediction Logic
    func performPrediction(with image: UIImage) {
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.predictBestPrompt(from: image)
            if let result = result {
                        translateToArabic(result) { translatedResult in
                            self.predictionResult = translatedResult
                        }
                    } else {
                        self.predictionResult = "No prediction available."
                    }        }
    }
    
    // MARK: - Prediction Logic (Moved Inside the View Struct)
    func predictBestPrompt(from image: UIImage) -> String? {
        guard let pixelValues = image.preprocessForCLIP(targetSize: CGSize(width: 224, height: 224)) else {
            print("Failed to preprocess image.")
            return nil
        }

        do {
            // Safely unwrap the model using optional binding
            if let model = ModelManager.shared.model {
                var bestPrompt: String? = nil
                var highestScore: Float = -Float.infinity

                let batchSize = 50
                for batchIndex in stride(from: 0, to: Tokens.tokenizedPrompts.count, by: batchSize) {
                    let batch = Array(Tokens.tokenizedPrompts[batchIndex..<min(batchIndex + batchSize, Tokens.tokenizedPrompts.count)])
                    for (index, tokens) in batch.enumerated() {
                        let inputIDs = try MLMultiArray(shape: [1, 77], dataType: .float32)
                        for (i, token) in tokens.enumerated() {
                            inputIDs[i] = NSNumber(value: token)
                        }

                        let input = fashion_clippInput(input_ids: inputIDs, pixel_values: pixelValues)
                        let output = try model.prediction(input: input)
                        let logits = output.logits_per_text
                        if let logitsArray = logits as? MLMultiArray {
                            let score = logitsArray[0].floatValue
                            if score > highestScore {
                                highestScore = score
                                bestPrompt = Prompts.originalPrompts[batchIndex + index]
                            }
                        }
                    }
                }
                return bestPrompt
            } else {
                print("Model is nil")
                return nil
            }
        } catch {
            print("Error during prediction: \(error)")
            return nil
        }
    }
}

// MARK: - Color Hex Initialization
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1  // skip the '#'
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
