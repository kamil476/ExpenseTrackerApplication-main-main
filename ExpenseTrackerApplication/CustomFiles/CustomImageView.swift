//
//  CustomImageView.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 11/03/2025.
//

import UIKit

class CustomImageView: UIImageView {
    
    init(imageName: String, cornerRadius: CGFloat = 0, backgroundColor: UIColor = .clear) {
        super.init(frame: .zero)
        self.image = UIImage(named: imageName)
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        return
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
