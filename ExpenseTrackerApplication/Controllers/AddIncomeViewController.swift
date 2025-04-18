//
//  AddIncomeViewController.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 13/03/2025.

import UIKit

class AddIncomeViewController: BaseController {
    
    // MARK: - UI COMPONENTS
    private lazy var continueButton = CustomButton(title: "Continue" ,backgroundColor: UIColor(hex: "7F3DFF"), titleColor: .white, font: UIFont.boldSystemFont(ofSize: 20), cornerRadius: 25, target: self, action: #selector(continueButtonTapped))
    private lazy var leftArrowButton = CustomButton(imageName: "arrowLeft",target: self, action: #selector(backToDashboard))
    private let titleLabel = CustomLabel(text: "Income", textColor: .white, font: UIFont.systemFont(ofSize: 20, weight: .bold))
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "00A86B")
        setupView()
        setupDropdowns()
        amountSpent.delegate = self
    }
    
    // MARK: - FUNCTIONS
    private func setupView(){
        view.addSubview(fieldsView)
        view.addSubview(leftArrowButton)
        view.addSubview(titleLabel)
        view.addSubview(askAmount)
        view.addSubview(continueButton)
        view.addSubview(amountSpent)
        view.addSubview(currencyLabel)
        fieldsView.addSubview(continueButton)
        fieldsView.addSubview(categoryFieldView)
        fieldsView.addSubview(descriptionFieldView)
        fieldsView.addSubview(walletFieldView)
        fieldsView.addSubview(categoryDropdown)
        fieldsView.addSubview(walletDropdown)
        fieldsView.addSubview(attachmentFieldView)
        categoryFieldView.addSubview(categoryLabel)
        walletFieldView.addSubview(walletLabel)
        categoryFieldView.addSubview(dropDownArrow)
        walletFieldView.addSubview(dropDownArrowWallet)
        attachmentFieldView.addSubview(attachmentLabel)
        attachmentFieldView.addSubview(attachmentPin)
        fieldsView.addSubview(attachmentImageView)
        descriptionFieldView.addSubview(descriptiontextField)
        
        NSLayoutConstraint.activate([
            categoryFieldView.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor, constant: 25),
            categoryFieldView.topAnchor.constraint(equalTo: fieldsView.topAnchor, constant: 30),
            categoryFieldView.heightAnchor.constraint(equalToConstant: 60),
            categoryFieldView.trailingAnchor.constraint(equalTo: fieldsView.trailingAnchor, constant: -25),
            
            descriptionFieldView.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor, constant: 25),
            descriptionFieldView.topAnchor.constraint(equalTo: categoryFieldView.bottomAnchor, constant: 17),
            descriptionFieldView.heightAnchor.constraint(equalToConstant: 60),
            descriptionFieldView.trailingAnchor.constraint(equalTo: fieldsView.trailingAnchor, constant: -25),
            
            walletFieldView.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor, constant: 25),
            walletFieldView.topAnchor.constraint(equalTo: descriptionFieldView.bottomAnchor, constant: 17),
            walletFieldView.heightAnchor.constraint(equalToConstant: 60),
            walletFieldView.trailingAnchor.constraint(equalTo: fieldsView.trailingAnchor, constant: -25),
            
            attachmentFieldView.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor, constant: 25),
            attachmentFieldView.topAnchor.constraint(equalTo: walletFieldView.bottomAnchor, constant: 17),
            attachmentFieldView.heightAnchor.constraint(equalToConstant: 60),
            attachmentFieldView.trailingAnchor.constraint(equalTo: fieldsView.trailingAnchor, constant: -25),
            
            dropDownArrow.topAnchor.constraint(equalTo: categoryFieldView.topAnchor, constant: 17),
            dropDownArrow.heightAnchor.constraint(equalToConstant: 30),
            dropDownArrow.trailingAnchor.constraint(equalTo: categoryFieldView.trailingAnchor, constant: -6),
            
            dropDownArrowWallet.topAnchor.constraint(equalTo: walletFieldView.topAnchor, constant: 17),
            dropDownArrowWallet.heightAnchor.constraint(equalToConstant: 30),
            dropDownArrowWallet.trailingAnchor.constraint(equalTo: walletFieldView.trailingAnchor, constant: -6),
            
            continueButton.centerXAnchor.constraint(equalTo: fieldsView.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: fieldsView.bottomAnchor, constant: -105),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.widthAnchor.constraint(equalToConstant: 300),
            
            askAmount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            askAmount.bottomAnchor.constraint(equalTo: fieldsView.topAnchor, constant: -100),
            
            currencyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            currencyLabel.bottomAnchor.constraint(equalTo: fieldsView.topAnchor, constant: -25),
            
            amountSpent.leadingAnchor.constraint(equalTo: currencyLabel.trailingAnchor, constant: 4),
            amountSpent.bottomAnchor.constraint(equalTo: fieldsView.topAnchor, constant: -8),
            amountSpent.topAnchor.constraint(equalTo: askAmount.bottomAnchor, constant: 10),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            
            leftArrowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            leftArrowButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            
            fieldsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            fieldsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            fieldsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            fieldsView.heightAnchor.constraint(equalToConstant: 500),
            fieldsView.widthAnchor.constraint(equalToConstant: 200),
            
            categoryLabel.centerYAnchor.constraint(equalTo: categoryFieldView.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: categoryFieldView.leadingAnchor, constant: 10),
            
            descriptiontextField.centerYAnchor.constraint(equalTo: descriptionFieldView.centerYAnchor),
            descriptiontextField.leadingAnchor.constraint(equalTo: descriptionFieldView.leadingAnchor, constant: 10),
            
            categoryDropdown.topAnchor.constraint(equalTo: categoryFieldView.bottomAnchor),
            categoryDropdown.leadingAnchor.constraint(equalTo: categoryFieldView.leadingAnchor),
            categoryDropdown.trailingAnchor.constraint(equalTo: categoryFieldView.trailingAnchor),
            categoryDropdown.heightAnchor.constraint(equalToConstant: 150),
            
            walletLabel.centerYAnchor.constraint(equalTo: walletFieldView.centerYAnchor),
            walletLabel.leadingAnchor.constraint(equalTo: walletFieldView.leadingAnchor, constant: 10),
            
            attachmentLabel.trailingAnchor.constraint(equalTo: attachmentFieldView.trailingAnchor, constant: -90),
            attachmentLabel.centerYAnchor.constraint(equalTo: attachmentFieldView.centerYAnchor),
            
            attachmentPin.topAnchor.constraint(equalTo: attachmentFieldView.topAnchor, constant: 15),
            attachmentPin.heightAnchor.constraint(equalToConstant: 30),
            attachmentPin.leadingAnchor.constraint(equalTo: attachmentFieldView.leadingAnchor, constant: 90),
            
            walletDropdown.centerYAnchor.constraint(equalTo: walletFieldView.centerYAnchor),
            walletDropdown.leadingAnchor.constraint(equalTo: walletFieldView.leadingAnchor),
            walletDropdown.trailingAnchor.constraint(equalTo: walletFieldView.trailingAnchor),
            walletDropdown.heightAnchor.constraint(equalToConstant: 150),
            
            attachmentImageView.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor, constant: 28),
            attachmentImageView.topAnchor.constraint(equalTo: walletFieldView.bottomAnchor, constant: 10),
            attachmentImageView.widthAnchor.constraint(equalToConstant: 100),
            attachmentImageView.heightAnchor.constraint(equalToConstant: 100), ])
    }
    private func resetFields() {
        descriptiontextField.text = ""
        amountSpent.text = "0"
        categoryLabel.text = "Select Category"
        walletLabel.text = "Select Wallet"
        attachmentImageView.image = nil
        attachmentFieldView.isHidden = false
        categoryDropdown.isHidden = true
        walletDropdown.isHidden = true
    }

    // MARK: - ACTIONS/EVENT LISTENERS
    @objc private func continueButtonTapped() {
        // Validation checks
           guard let amountText = amountSpent.text, !amountText.isEmpty, let amount = Double(amountText), amount > 0 else {
               showAlert(message: "Please enter a valid amount.")
               return
           }
           guard let category = categoryLabel.text, category != "Select Category" else {
               showAlert(message: "Please select a category.")
               return
           }
           guard let wallet = walletLabel.text, wallet != "Select Wallet" else {
               showAlert(message: "Please select a wallet.")
               return
           }
           guard let description = descriptiontextField.text, !description.isEmpty else {
               showAlert(message: "Please enter a description.")
               return
           }
           // Optional image data
           let imageData = attachmentImageView.image?.jpegData(compressionQuality: 0.8)
           // Save to Core Data
           CoreDataManager.shared.saveIncome(
               incomeAmount: amount,
               incomeCategory: category,
               incomeDate: Date(),
               incomeDetails: description,
               incomePlaceHolder: imageData
           )
           // Show success alert
           showSuccessAlert()
           resetFields()
    }
    @objc private func backToDashboard() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: -  TEXTFIELD DELEGATE
extension AddIncomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amountSpent {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
