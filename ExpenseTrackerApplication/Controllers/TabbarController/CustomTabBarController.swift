//
//  TabBarController.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 13/03/2025.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    private let customTabBarView = UIView()
    private let floatingButton = UIButton()
    private let homeButton = UIButton()
    private let transactionButton = UIButton()
    private let budgetButton = UIButton()
    private let profileButton = UIButton()
    private let homeLabel = UILabel()
    private let transactionLabel = UILabel()
    private let budgetLabel = UILabel()
    private let profileLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        setupViewControllers()
        setupCustomTabBar()
    }
    private func setupViewControllers() {
        let homeVC = DashboardViewController()
        let transactionVC = AddIncomeViewController()
        let budgetVC = AddExpenseViewController()
        let profileVC = BudgetHistoryController()
        
        viewControllers = [homeVC, transactionVC, budgetVC, profileVC]
        selectedIndex = 0
    }
    private func setupCustomTabBar() {
        // Custom Tab Bar View
        customTabBarView.frame = CGRect(x: 10, y: view.frame.height - 90, width: view.frame.width - 20, height: 80)
        customTabBarView.backgroundColor = .white
        customTabBarView.layer.cornerRadius = 25
        customTabBarView.layer.shadowColor = UIColor.black.cgColor
        customTabBarView.layer.shadowOpacity = 0.1
        customTabBarView.layer.shadowOffset = CGSize(width: 0, height: -3)
        customTabBarView.layer.shadowRadius = 5
        view.addSubview(customTabBarView)
        
        // Floating Button
        floatingButton.frame = CGRect(x: (view.frame.width / 2) - 35, y: customTabBarView.frame.origin.y - 5, width: 60, height: 60)
        floatingButton.backgroundColor = UIColor(hex: "7F3DFF")
        floatingButton.setImage(UIImage(named: "addIcon"), for: .normal)
        floatingButton.tintColor = .white
        floatingButton.layer.cornerRadius = 28
        floatingButton.layer.shadowOpacity = 0.3
        floatingButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        view.addSubview(floatingButton)
        
        // Setup Tab Buttons and Labels
        setupTabButton(button: homeButton, imageName: "home", x: 35, tag: 0)
        setupTabButton(button: transactionButton, imageName: "Transaction", x: 107, tag: 1)
        setupTabButton(button: budgetButton, imageName: "pieChart", x: view.frame.width - 165, tag: 2)
        setupTabButton(button: profileButton, imageName: "historyUser", x: view.frame.width - 90, tag: 3)
        
        setupTabLabel(label: homeLabel, text: "Home", x: 25, tag: 0)
        setupTabLabel(label: transactionLabel, text: "Income", x: 95, tag: 1)
        setupTabLabel(label: budgetLabel, text: "Expense", x: view.frame.width - 174, tag: 2)
        setupTabLabel(label: profileLabel, text: "History", x: view.frame.width - 100, tag: 3)
        
        updateTabSelection()
    }
    private func setupTabButton(button: UIButton, imageName: String, x: CGFloat, tag: Int) {
        button.frame = CGRect(x: x, y: customTabBarView.frame.origin.y + 10, width: 50, height: 30)
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = (tag == selectedIndex) ? UIColor(hex: "7F3DFF") : .gray
        button.tag = tag
        button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    private func setupTabLabel(label: UILabel, text: String, x: CGFloat, tag: Int) {
        label.frame = CGRect(x: x, y: customTabBarView.frame.origin.y + 45, width: 70, height: 20)
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = (tag == selectedIndex) ? UIColor(hex: "7F3DFF") : .gray
        label.tag = tag
        view.addSubview(label)
    }
    @objc private func tabButtonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        updateTabSelection()
    }
    private func updateTabSelection() {
        homeButton.tintColor = (selectedIndex == 0) ? UIColor(hex: "7F3DFF") : .gray
        transactionButton.tintColor = (selectedIndex == 1) ? UIColor(hex: "7F3DFF") : .gray
        budgetButton.tintColor = (selectedIndex == 2) ? UIColor(hex: "7F3DFF") : .gray
        profileButton.tintColor = (selectedIndex == 3) ? UIColor(hex: "7F3DFF") : .gray
        homeLabel.textColor = (selectedIndex == 0) ? UIColor(hex: "7F3DFF") : .gray
        transactionLabel.textColor = (selectedIndex == 1) ? UIColor(hex: "7F3DFF") : .gray
        budgetLabel.textColor = (selectedIndex == 2) ? UIColor(hex: "7F3DFF") : .gray
        profileLabel.textColor = (selectedIndex == 3) ? UIColor(hex: "7F3DFF") : .gray
    }
    
    // MARK: - Floating Button Action
    @objc private func floatingButtonTapped() {
        let addExpenseVC = AddExpenseViewController()
        addExpenseVC.modalPresentationStyle = .overFullScreen
        present(addExpenseVC, animated: true, completion: nil)
    }
}
