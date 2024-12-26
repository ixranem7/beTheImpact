//
//  CameraPermission.swift
//  beTheImpact
//
//  Created by Wejdan Alghamdi on 22/06/1446 AH.
//

import UIKit
import AVFoundation

enum CameraPermission {
    enum CameraError: Error, LocalizedError {
        case unauthorized
        case notAvailable
        
        
        var errorDescription: String? {
            switch self {
            case .unauthorized:
                return NSLocalizedString("You have nott authorized camera use", comment: "")
            case .notAvailable:
                return NSLocalizedString("Camera is not available for this device", comment: "")
                
            }
        }
        
        var recoverySuggestion: String? {
            switch self {
            case .unauthorized:
                return NSLocalizedString("Go to settings and enable camera", comment: "")
            case .notAvailable:
                return nil
            }
        }
        
        
    }
    static func checkPermission() -> CameraError? {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authStatus {
            case .authorized:
                return nil
            case .notDetermined:
                return nil
            case .denied:
                return .unauthorized
            case .restricted:
                return nil
            @unknown default:
                return nil
            }
            
        }else{
            return .notAvailable
        }
    }
}
