//
//  SecondOutfitDetails.swift
//  beTheImpact
//
//  Created by Wejdan Alghamdi on 28/06/1446 AH.
//

import SwiftUI
import CoreML
import UIKit

struct SecondOutfitDetails: View {
    @State private var predictionResult2: String? = nil
    @Binding var realImage2: UIImage?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView{
            VStack {
                
                VStack(alignment: .leading, spacing: 15) {
                    if let uiImage = realImage2 {
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
                    
                    if let prediction = predictionResult2 {
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
                
            }.navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    trailing: NavigationLink( destination: ViewMainpage(), label: {Text("Finish").bold().foregroundColor(Color.pur)
                    }))
        }
    }
    
    // MARK: - Perform Prediction Logic
    func performPrediction(with image: UIImage) {
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.predictBestPrompt(from: image)
            DispatchQueue.main.async {
                self.predictionResult2 = result
            }
        }
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

//#Preview {
//    SecondOutfitDetails()
//}
