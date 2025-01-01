//
//  UIKitCamera.swift
//  beTheImpact
//
//  Created by Wejdan Alghamdi on 22/06/1446 AH.
//

import SwiftUI


struct UIKitCamera: UIViewControllerRepresentable {
   
    
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) var dismiss
    //@Binding var shouldNavigate: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: UIKitCamera
        
        init(parent: UIKitCamera) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//                parent.selectedImage = image
//                parent.dismiss()
                self.parent.selectedImage = image as? UIImage
                //self.parent.shouldNavigate = true // Trigger navigation
            }
            
        }
    }
}
