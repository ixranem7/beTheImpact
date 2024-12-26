//
//import SwiftUI
//import CoreML
//import UIKit
//
//struct OutfitDetails: View {
//    @State private var predictionResult: String? = nil
//    @Binding var realImage: UIImage?
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//                print("Button 3 tapped")
//            }) {
//                Text("Save")
//                    .font(.custom("Tajawal-Bold", size: 18))
//                    .padding(.leading, 300.0)
//                    .padding(.top, -26.0)
//                    .foregroundColor(Color(hex: "#3B2860"))
//            }
//            .accessibilityLabel("Save Button")
//            .accessibilityHint("save outfit")
//            
//            Button(action: {
//                print("Button 4 tapped")
//            }) {
//                Text("Back")
//                    .font(.custom("Tajawal-Bold", size: 18))
//                    .padding(.trailing, 297.0)
//                    .padding(.top, -34.0)
//                    .foregroundColor(Color(hex: "#3B2860"))
//            }
//            .accessibilityLabel("Back Button")
//            .accessibilityHint("Back to home")
//            
//            VStack(alignment: .leading, spacing: 15) {
//                if let uiImage = realImage {
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .frame(width: 280, height: 300)
//                        .cornerRadius(10)
//                        .onAppear {
//                            // Perform the prediction when the image appears
//                            performPrediction(with: uiImage)
//                        }
//                } else {
//                    Text("Image not found in Assets.")
//                        .foregroundColor(.red)
//                }
//                
//                Text("Item Details")
//                    .font(.custom("Tajawal-Bold", size: 18))
//                    .foregroundColor(Color(hex: "#423F42"))
//                    .accessibilityLabel("Item details")
//                    .accessibilityHint("Item details")
//                
//                if let prediction = predictionResult {
//                    Text("\(prediction)")
//                        .font(.custom("Tajawal-Regular", size: 18))
//                        .foregroundColor(Color(hex: "#423F42"))
//                        .accessibilityLabel("Details")
//                        .accessibilityHint("\(prediction)")
//                } else {
//                    Text("Just a moment! We're working on finding the best result for you...")
//                        .foregroundColor(.gray)
//                        .padding()
//                    
//                }
//            }
//            
//            Spacer()
//            
//            VStack(spacing: 16) {
//                Button(action: {
//                    print("Button 1 tapped")
//                }) {
//                    Text("Another Piece")
//                        .font(.custom("Tajawal-Bold", size: 24))
//                        .frame(height: 15)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color(hex: "#3B2860"))
//                        .foregroundColor(.white)
//                        .cornerRadius(50)
//                }
//                .accessibilityLabel("Another Piece Button")
//                .accessibilityHint("Another Piece")
//                
//                Button(action: {
//                    print("Button 2 tapped")
//                }) {
//                    Text("Try Again")
//                        .font(.custom("Tajawal-Bold", size: 24))
//                        .foregroundColor(Color(hue: 0.729, saturation: 0.762, brightness: 0.268))
//                        .frame(height: 15)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 50)
//                                .stroke(Color(hex: "#69696E"), lineWidth: 1)
//                        )
//                }
//                .accessibilityLabel("Try Again Button")
//                .accessibilityHint("Try Again")
//            }
//        }
//        .navigationBarBackButtonHidden()
//        .padding()
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//    
//    func performPrediction(with image: UIImage) {
//        DispatchQueue.global(qos: .userInitiated).async {
//            let result = predictBestPrompt(from: image)
//            DispatchQueue.main.async {
//                self.predictionResult = result // Update the prediction result on the main thread
//            }
//        }
//    }
//}
//
//// MARK: - Prediction Logic
//func predictBestPrompt(from image: UIImage) -> String? {
//    guard let pixelValues = image.preprocessForCLIP(targetSize: CGSize(width: 224, height: 224)) else {
//        print("Failed to preprocess image.")
//        return nil
//    }
//
//    do {
//        let configuration = MLModelConfiguration()
//        configuration.computeUnits = .cpuOnly // Force CPU usage on physical device
//        let model = try fashion_clipp(configuration: configuration)
//        print("Model loaded successfully")
//        var bestPrompt: String? = nil
//        var highestScore: Float = -Float.infinity
//
//        let batchSize = 50
//        for batchIndex in stride(from: 0, to: Tokens.tokenizedPrompts.count, by: batchSize) {
//            let batch = Array(Tokens.tokenizedPrompts[batchIndex..<min(batchIndex + batchSize, Tokens.tokenizedPrompts.count)])
//            for (index, tokens) in batch.enumerated() {
//                let inputIDs = try MLMultiArray(shape: [1, 77], dataType: .float32)
//                for (i, token) in tokens.enumerated() {
//                    inputIDs[i] = NSNumber(value: token)
//                }
//                let input = fashion_clippInput(input_ids: inputIDs, pixel_values: pixelValues)
//                let output = try model.prediction(input: input)
//                let logits = output.logits_per_text
//                if let logitsArray = logits as? MLMultiArray {
//                    let score = logitsArray[0].floatValue
//                    if score > highestScore {
//                        highestScore = score
//                        bestPrompt = Prompts.originalPrompts[batchIndex + index]
//                    }
//                }
//            }
//        }
//        return bestPrompt
//    } catch {
//        print("Error during prediction: \(error)")
//        return nil
//    }
//}
//
//// MARK: - UIImage Extension for Image Preprocessing
//extension UIImage {
//    func preprocessForCLIP(targetSize: CGSize) -> MLMultiArray? {
//        guard let resizedImage = self.resizeAndCenterCrop(to: targetSize) else { return nil }
//        guard let cgImage = resizedImage.cgImage else { return nil }
//
//        let width = Int(targetSize.width)
//        let height = Int(targetSize.height)
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        var rawData = [UInt8](repeating: 0, count: width * height * 4)
//        let bytesPerRow = width * 4
//
//        guard let context = CGContext(data: &rawData,
//                                     width: width,
//                                     height: height,
//                                     bitsPerComponent: 8,
//                                     bytesPerRow: bytesPerRow,
//                                     space: colorSpace,
//                                     bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) else {
//            return nil
//        }
//
//        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
//
//        do {
//            let array = try MLMultiArray(shape: [1, 3, NSNumber(value: height), NSNumber(value: width)], dataType: .float32)
//            let mean: [Float32] = [0.48145466, 0.4578275, 0.40821073]
//            let std: [Float32] = [0.26862954, 0.26130258, 0.27577711]
//
//            for y in 0..<height {
//                for x in 0..<width {
//                    let pixelIndex = (y * width + x) * 4
//                    let r = ((Float32(rawData[pixelIndex]) / 255.0) - mean[0]) / std[0]
//                    let g = ((Float32(rawData[pixelIndex + 1]) / 255.0) - mean[1]) / std[1]
//                    let b = ((Float32(rawData[pixelIndex + 2]) / 255.0) - mean[2]) / std[2]
//
//                    array[[0, 0, y, x] as [NSNumber]] = NSNumber(value: r)
//                    array[[0, 1, y, x] as [NSNumber]] = NSNumber(value: g)
//                    array[[0, 2, y, x] as [NSNumber]] = NSNumber(value: b)
//                }
//            }
//            return array
//        } catch {
//            print("Error creating MLMultiArray: \(error)")
//            return nil
//        }
//    }
//
//    private func resizeAndCenterCrop(to targetSize: CGSize) -> UIImage? {
//        let aspectWidth = targetSize.width / self.size.width
//        let aspectHeight = targetSize.height / self.size.height
//        let aspectRatio = max(aspectWidth, aspectHeight)
//
//        let scaledWidth = self.size.width * aspectRatio
//        let scaledHeight = self.size.height * aspectRatio
//        let centerX = (scaledWidth - targetSize.width) / 2.0
//        let centerY = (scaledHeight - targetSize.height) / 2.0
//
//        let rect = CGRect(x: -centerX, y: -centerY, width: scaledWidth, height: scaledHeight)
//
//        UIGraphicsBeginImageContextWithOptions(targetSize, false, self.scale)
//        self.draw(in: rect)
//        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return croppedImage
//    }
//
//    func fixOrientation() -> UIImage? {
//        if self.imageOrientation == .up { return self }
//
//        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
//        self.draw(in: CGRect(origin: .zero, size: self.size))
//        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return normalizedImage
//    }
//}
//
//extension Color {
//    init(hex: String) {
//        let scanner = Scanner(string: hex)
//        scanner.scanLocation = 1  // skip the '#'
//        var rgb: UInt64 = 0
//        scanner.scanHexInt64(&rgb)
//        let r = Double((rgb >> 16) & 0xFF) / 255.0
//        let g = Double((rgb >> 8) & 0xFF) / 255.0
//        let b = Double(rgb & 0xFF) / 255.0
//        self.init(red: r, green: g, blue: b)
//    }
//}
//
import SwiftUI
import CoreML
import UIKit

// MARK: - View
struct OutfitDetails: View {
    @State private var predictionResult: String? = nil
    @Binding var realImage: UIImage?
    
    var body: some View {
        VStack {
            Button(action: {
                print("Button 3 tapped")
            }) {
                Text("Save")
                    .font(.custom("Tajawal-Bold", size: 18))
                    .padding(.leading, 300.0)
                    .padding(.top, -26.0)
                    .foregroundColor(Color(hex: "#3B2860"))
            }
            .accessibilityLabel("Save Button")
            .accessibilityHint("save outfit")
            
            Button(action: {
                print("Button 4 tapped")
            }) {
                Text("Back")
                    .font(.custom("Tajawal-Bold", size: 18))
                    .padding(.trailing, 297.0)
                    .padding(.top, -34.0)
                    .foregroundColor(Color(hex: "#3B2860"))
            }
            .accessibilityLabel("Back Button")
            .accessibilityHint("Back to home")
            
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
                    print("Button 1 tapped")
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
        }
        .navigationBarBackButtonHidden()
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Perform Prediction Logic
    func performPrediction(with image: UIImage) {
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.predictBestPrompt(from: image)
            DispatchQueue.main.async {
                self.predictionResult = result
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

// MARK: - ModelManager Singleton
class ModelManager {
    static let shared = ModelManager()
    var model: fashion_clipp?

    private init() {
        do {
            let configuration = MLModelConfiguration()
            // Use `.CPUAndGPU` for CPU and GPU usage
            configuration.computeUnits = .cpuAndGPU  // This is the correct way to use both CPU and GPU
            model = try fashion_clipp(configuration: configuration)
            print("Model loaded successfully")
        } catch {
            print("Error loading model: \(error)")
        }
    }
}

// MARK: - UIImage Extension for Image Preprocessing
extension UIImage {
    func preprocessForCLIP(targetSize: CGSize) -> MLMultiArray? {
        guard let resizedImage = self.resizeImage(to: targetSize) else { return nil }
        guard let cgImage = resizedImage.cgImage else { return nil }

        let width = Int(targetSize.width)
        let height = Int(targetSize.height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var rawData = [UInt8](repeating: 0, count: width * height * 4)
        let bytesPerRow = width * 4

        guard let context = CGContext(data: &rawData,
                                          width: width,
                                          height: height,
                                          bitsPerComponent: 8,
                                          bytesPerRow: bytesPerRow,
                                          space: colorSpace,
                                          bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) else {
                return nil
           }

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        do {
            let array = try MLMultiArray(shape: [1, 3, NSNumber(value: height), NSNumber(value: width)], dataType: .float32)
            let mean: [Float32] = [0.48145466, 0.4578275, 0.40821073]
            let std: [Float32] = [0.26862954, 0.26130258, 0.27577711]

            for y in 0..<height {
                for x in 0..<width {
                    let pixelIndex = (y * width + x) * 4
                    let r = ((Float32(rawData[pixelIndex]) / 255.0) - mean[0]) / std[0]
                    let g = ((Float32(rawData[pixelIndex + 1]) / 255.0) - mean[1]) / std[1]
                    let b = ((Float32(rawData[pixelIndex + 2]) / 255.0) - mean[2]) / std[2]

                    array[[0, 0, y, x] as [NSNumber]] = NSNumber(value: r)
                    array[[0, 1, y, x] as [NSNumber]] = NSNumber(value: g)
                    array[[0, 2, y, x] as [NSNumber]] = NSNumber(value: b)
                }
            }
            return array
        } catch {
            print("Error creating MLMultiArray: \(error)")
            return nil
        }
    }

    private func resizeImage(to targetSize: CGSize) -> UIImage? {
        let aspectWidth = targetSize.width / self.size.width
        let aspectHeight = targetSize.height / self.size.height
        let aspectRatio = max(aspectWidth, aspectHeight)

        let scaledWidth = self.size.width * aspectRatio
        let scaledHeight = self.size.height * aspectRatio
        let centerX = (scaledWidth - targetSize.width) / 2.0
        let centerY = (scaledHeight - targetSize.height) / 2.0

        let rect = CGRect(x: -centerX, y: -centerY, width: scaledWidth, height: scaledHeight)

        UIGraphicsBeginImageContextWithOptions(targetSize, false, self.scale)
        self.draw(in: rect)
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return croppedImage
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
