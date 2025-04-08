//
//  AlertPopups.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 28/03/2025.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Alert for showing a success message (Income added)
    func showSuccessAlert(title: String = "Success", message: String = "Income Added successfully!", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    // General error alert
    func showErrorAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true, completion: nil)
    }
}
