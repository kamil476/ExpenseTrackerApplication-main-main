//
//  BaseController.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 11/04/2025.

import UIKit

class BaseController: UIViewController {
    
    // MARK: - Common UI Components
    let askAmount = CustomLabel(text: "How much?", textColor: .systemGray5, font: UIFont.systemFont(ofSize: 16, weight: .semibold))
    let currencyLabel = CustomLabel(text: "Rs.", textColor: .white, font: UIFont.systemFont(ofSize: 35, weight: .semibold))
    let descriptionFieldView = CustomView(cornerRadius: 14, backgroundColor: .clear, borderWidth: 1, borderColor: .systemGray5)
    let descriptiontextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter description"
        txt.font = UIFont.systemFont(ofSize: 16)
        txt.textColor = .black
        txt.borderStyle = .none
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt }()
    let amountSpent: UITextField = {
        let txt = UITextField()
        txt.font = UIFont.boldSystemFont(ofSize: 40)
        txt.textColor = .white
        txt.borderStyle = .none
        txt.text = "0"
        txt.keyboardType = .numberPad
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt }()
    let fieldsView = CustomView(cornerRadius: 30, backgroundColor: .white, shadowColor: .black, shadowOpacity: 0.2, shadowOffset: CGSize(width: 0, height: -3), shadowRadius: 5)
    let categoryFieldView = CustomView(cornerRadius: 14, backgroundColor: .clear, borderWidth: 1, borderColor: .systemGray5)
    let walletFieldView = CustomView(cornerRadius: 14, backgroundColor: .clear, borderWidth: 1, borderColor: .systemGray5)
    let attachmentFieldView = CustomView(cornerRadius: 14, backgroundColor: .clear, borderWidth: 1, borderColor: .systemGray5)
    let categoryLabel = CustomLabel(text: "Select Category", textColor: .darkGray, font: .systemFont(ofSize: 15))
    let walletLabel = CustomLabel(text: "Select Wallet", textColor: .darkGray, font: .systemFont(ofSize: 15))
    let attachmentLabel = CustomLabel(text: "Add Attachment", textColor: .darkGray, font: .systemFont(ofSize: 17))
    let dropDownArrow = CustomImageView(imageName: "arrowDropDown")
    let dropDownArrowWallet = CustomImageView(imageName: "arrowDropDown")
    let attachmentPin = CustomImageView(imageName: "attachmentPin")
    let categoryDropdown: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.systemGray5.cgColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView }()
    let walletDropdown: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.systemGray5.cgColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView }()
    let bottomSheetView = CustomView(cornerRadius: 20, backgroundColor: .white, shadowColor: .black, shadowOpacity: 0.3, shadowOffset: CGSize(width: 0, height: -3), shadowRadius: 5)
    let attachmentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let categoryOptions = ["Food", "Transport", "Shopping", "Entertainment", "Donations", "Bills", "Repairs", "Fuel"]
    let walletOptions = ["EasyPaisa"]
    lazy var cancelButton = CustomButton(title: "Close",titleColor: .white, target: self, action:  #selector (closeBottomSheet))
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropdowns()
        setupTapGestures()
    }
    
    // MARK: - Setup Methods
    func setupTapGestures() {
        let tapCategory = UITapGestureRecognizer(target: self, action: #selector(showCategoryDropdown))
        categoryFieldView.addGestureRecognizer(tapCategory)
        
        let tapWallet = UITapGestureRecognizer(target: self, action: #selector(showWalletDropdown))
        walletFieldView.addGestureRecognizer(tapWallet)
        
        let tapAttachment = UITapGestureRecognizer(target: self, action: #selector(openAttachmentBottomSheet))
        attachmentFieldView.addGestureRecognizer(tapAttachment)
    }
    func setupDropdowns() {
        categoryDropdown.register(UITableViewCell.self, forCellReuseIdentifier: "categoryCell")
        categoryDropdown.dataSource = self
        categoryDropdown.delegate = self
        
        walletDropdown.register(UITableViewCell.self, forCellReuseIdentifier: "walletCell")
        walletDropdown.dataSource = self
        walletDropdown.delegate = self
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
    func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    // MARK: - Dropdown Actions
    @objc func showCategoryDropdown() {
        categoryDropdown.isHidden.toggle()
    }
    @objc func showWalletDropdown() {
        walletDropdown.isHidden.toggle()
    }
    @objc private func galleryTapped() {
        openImagePicker(sourceType: .photoLibrary)
        closeBottomSheet()
    }
    @objc private func closeBottomSheet() {
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomSheetView.transform = CGAffineTransform(translationX: 0, y: 300)
        }) { _ in
            self.bottomSheetView.removeFromSuperview()
        }
    }
    
    // MARK: - Attachment Bottom Sheet
    @objc func openAttachmentBottomSheet() {
        view.addSubview(bottomSheetView)
        let galleryButton = createButton(title: "Choose from Gallery", action: #selector(galleryTapped))
        let cancelButton = createButton(title: "Cancel", action: #selector(closeBottomSheet))
        let stackView = UIStackView(arrangedSubviews: [ galleryButton, cancelButton])
        
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
            stackView.widthAnchor.constraint(equalTo: bottomSheetView.widthAnchor, multiplier: 0.8),
        ])
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetView.transform = CGAffineTransform(translationX: 0, y: -380)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension BaseController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == categoryDropdown {
            return categoryOptions.count
        } else {
            return walletOptions.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == categoryDropdown {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
            cell.textLabel?.text = categoryOptions[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "walletCell", for: indexPath)
            cell.textLabel?.text = walletOptions[indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == categoryDropdown {
            categoryLabel.text = categoryOptions[indexPath.row]
            categoryDropdown.isHidden = true
        } else {
            walletLabel.text = walletOptions[indexPath.row]
            walletDropdown.isHidden = true
        }
    }
}

extension BaseController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            attachmentImageView.image = selectedImage
        } else if let selectedImage = info[.originalImage] as? UIImage {
            attachmentImageView.image = selectedImage
        }
        attachmentFieldView.isHidden = true
        print("Attachment selected")
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
