//
//  TimeCollectionViewCell.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 19/03/2025.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String, isSelected: Bool) {
        titleLabel.text = text
        if isSelected {
            contentView.backgroundColor = UIColor(hex: "FEEFD0")
            titleLabel.textColor = UIColor(hex: "E58E26")
        } else {
            contentView.backgroundColor = .clear
            titleLabel.textColor = UIColor.lightGray
        }
    }
}
