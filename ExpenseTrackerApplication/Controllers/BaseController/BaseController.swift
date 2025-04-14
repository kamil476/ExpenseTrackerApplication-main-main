//
//  BaseController.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 11/04/2025.
//

// Shared setup code (e.g., navigation bar style, background color)
//
// Utility methods (e.g., showing alerts, loading indicators)
//
// Common lifecycle hooks
//
// Theme or appearance configuration
//
// Analytics or logging

import UIKit

class BaseController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: - UI COMPONENTS (Shared)
    var imagePickedHandler: ((UIImage) -> Void)?
    let bottomSheetView = CustomView(cornerRadius: 20, backgroundColor: .white, shadowColor: .black, shadowOpacity: 0.3, shadowOffset: CGSize(width: 0, height: -3), shadowRadius: 5)
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    func openImagePicker(sourceType: UIImagePickerController.SourceType, completion: @escaping (UIImage) -> Void) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.imagePickedHandler = completion
        present(imagePicker, animated: true)
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        if let editedImage = info[.editedImage] as? UIImage {
            imagePickedHandler?(editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            imagePickedHandler?(originalImage)
        }
    }
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "7F3DFF")
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    @objc func openAttachmentBottomSheet() {
        view.addSubview(bottomSheetView)
        let galleryButton = createButton(title: "Choose from Gallery", action: #selector(galleryTapped))
        let cancelButton = createButton(title: "Cancel", action: #selector(closeBottomSheet))
        let stackView = UIStackView(arrangedSubviews: [galleryButton, cancelButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.heightAnchor.constraint(equalToConstant: 200),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 300),
            
            stackView.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: bottomSheetView.centerYAnchor),
        ])
        
        // Animate bottom sheet up
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetView.transform = CGAffineTransform(translationX: 0, y: -300)
        }
    }
    // Close bottom sheet
    @objc func closeBottomSheet() {
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomSheetView.transform = .identity
        }) { _ in
            self.bottomSheetView.removeFromSuperview()
        }
    }
    @objc func galleryTapped() {
        openImagePicker(sourceType: .photoLibrary)
        closeBottomSheet()
    }
}

