//
//  CustomButton.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 10/04/2025.
//

import UIKit

class CustomButton: UIButton {
    
    init(imageName: String? = nil, title: String? = nil, backgroundColor: UIColor = .clear, titleColor: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 16), cornerRadius: CGFloat = 0, target: Any? = nil, action: Selector? = nil) {
        
        super.init(frame: .zero)
        
        if let imageName = imageName {self.setImage(UIImage(named: imageName), for: .normal)}
        if let title = title { self.setTitle(title, for: .normal)}
        self.backgroundColor = backgroundColor
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        if let target = target, let action = action {self.addTarget(target, action: action, for: .touchUpInside)}
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
