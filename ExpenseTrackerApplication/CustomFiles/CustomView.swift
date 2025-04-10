//
//  CustomView.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 10/04/2025.
//

import UIKit

class CustomView: UIView {
    
    init(cornerRadius: CGFloat = 0,backgroundColor: UIColor = .clear,borderWidth: CGFloat = 0,borderColor: UIColor = .clear,shadowColor: UIColor = .clear,shadowOpacity: Float = 0,shadowOffset: CGSize = .zero,shadowRadius: CGFloat = 0) {
        
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
