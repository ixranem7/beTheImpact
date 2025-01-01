
import SwiftUI
import CoreML
import UIKit

struct SecondOutfitDetails: View {
    @State private var predictionResult2: String? = nil
    @State private var matchResult: String? = nil
    @Binding var firstItemPrediction: String?
    @Binding var realImage2: UIImage?
    @State private var showActionSheet3 = false
    @State private var showCamera3: Bool = false
    @State private var showImagePicker3: Bool = false
    @State private var showSelectedImage3: Bool = false
    @State var cameraImage3: UIImage?
    @State private var cameraError: CameraPermission.CameraError?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 15) {
                        if let uiImage = realImage2 {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 280, height: 300)
                                .cornerRadius(10)
                                .padding(.top, 20)
                                .onAppear {
                                    // Perform the prediction when the image appears
                                    performPrediction(with: uiImage)
                                }
                            
                            
                        } else {
                            Text("No Image Captured or Selected")
                                .foregroundColor(.red)
                                .bold()
                        }
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 15){
                        if realImage2 != nil {
                            Text("Item Details")
                                .font(.custom("Tajawal-Bold", size: 18))
                                .foregroundColor(Color.pur)
                                .accessibilityLabel("Item details")
                                .accessibilityHint("Item details")
                        }
                        
                        if let prediction = predictionResult2 {
                            Text("\(prediction)")
                                .font(.custom("Tajawal-Regular", size: 18))
                                .foregroundColor(Color.pur)
                                .accessibilityLabel("Details")
                                .accessibilityHint("\(prediction)")
                        }
                        
                        if let match = matchResult {
                            
                            Text(match)
                                .font(.custom("Tajawal-Regular", size: 18))
                                .bold()
                                .foregroundColor(Color.pur)
                            //.foregroundColor(match.contains("\(condition)") ? .red : .green)
                                .accessibilityLabel("Matching result")
                            .accessibilityHint(match)}
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    Spacer()
                    
                    
                        .actionSheet(isPresented: $showActionSheet3) {
                            ActionSheet(
                                title: Text("Choose an option"),
                                buttons: [
                                    .default(Text("Take a photo")) {
                                        if let error = CameraPermission.checkPermission() {
                                            cameraError = error
                                        } else {
                                            showCamera3.toggle()
                                            showSelectedImage3 = true
                                        }
                                    },
                                    .default(Text("Upload from Photos")) {
                                        showImagePicker3.toggle()
                                        showSelectedImage3 = true
                                    },
                                    .cancel()
                                ]
                            )
                        }
                    
                    
                    
                }.padding()
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }){
                                Text("Back")
                                    .font(.custom("Tajawal-Bold", size: 18))
                                    .foregroundColor(Color.pur)
                                    .padding()
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing){
                            NavigationLink( destination: ViewMainpage(), label: {Text("Finish").font(.custom("Tajawal-Bold", size: 18)).foregroundColor(Color.pur).padding()
                            })
                        }}
                
                
                if showPopup {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    VStack(spacing: 20) {
                        LoadingSpinner()
                            .frame(width: 50, height: 50)
                        
                        Text("Determining if the items match...")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding()
                    .frame(width: 300, height: 200)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 20)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    @State private var showPopup = false // Popup state variable
    
    func performPrediction(with image: UIImage) {
        // Show the popup before starting the prediction
        self.showPopup = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.predictBestPrompt(from: image)
            
            DispatchQueue.main.async {
                // Hide the popup after the prediction process completes
                self.showPopup = false
                
                if let result = result {
                    // Translate the prediction for display purposes
                    translateToArabic(result) { translatedResult in
                        self.predictionResult2 = translatedResult // Display the translated prediction
                    }
                    
                    // Pass the English prediction to the match function
                    if let firstItemPrediction = self.firstItemPrediction {
                        self.matchResult = checkIfItemsMatch(firstItem: firstItemPrediction, secondItem: result)
                    } else {
                        self.matchResult = "Unable to determine if the items match."
                    }
                } else {
                    self.predictionResult2 = "No prediction available."
                    self.matchResult = "Unable to determine if the items match."
                }
            }
        }
    }
    
    
    // MARK: - Prediction Logic
    func predictBestPrompt(from image: UIImage) -> String? {
        guard let pixelValues = image.preprocessForCLIP(targetSize: CGSize(width: 224, height: 224)) else {
            print("Failed to preprocess image.")
            return nil
        }
        
        do {
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
