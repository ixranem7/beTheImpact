//
//  ModelManager.swift
//  beTheImpact
//
//  Created by Wejdan Alghamdi on 29/06/1446 AH.
//

import Foundation
import CoreML
import UIKit

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
