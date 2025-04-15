//
//  DashboardListTableView.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 25/03/2025.
//

import UIKit

class DashboardExpenseListTableView: UITableViewCell {
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.2)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let iconImageView = CustomImageView(imageName: "", cornerRadius: 12)
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let expenseAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let incomeAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 4
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(expenseAmountLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(incomeAmountLabel)
        
        NSLayoutConstraint.activate([
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 50),
            iconContainer.heightAnchor.constraint(equalToConstant: 50),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: expenseAmountLabel.leadingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: timeLabel.leadingAnchor, constant: -8),
            
            expenseAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            expenseAmountLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            
            incomeAmountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            incomeAmountLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            timeLabel.topAnchor.constraint(equalTo: descriptionLabel.topAnchor)
        ])
    }
    
    // MARK: - Configure with Expense
    func configureExpense(with expense: Expense) {
        // setting the iconImage based on the category or type of expense
        titleLabel.text = expense.expenseCategory
        descriptionLabel.text = expense.expenseDetails
        expenseAmountLabel.text = "- Rs\(expense.expenseAmount)"
        if let imageData = expense.expensePlaceHolder {
            iconImageView.image = UIImage(data: imageData)
        } else {
            iconImageView.image = UIImage(named: "shoppingBag") 
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        timeLabel.text = dateFormatter.string(from: expense.expenseDate!)
    }
}
