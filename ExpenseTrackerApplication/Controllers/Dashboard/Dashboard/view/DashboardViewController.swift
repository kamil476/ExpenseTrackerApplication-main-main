//
//  DashboardViewController.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 13/03/2025.

import UIKit

class DashboardViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel = DashboardViewModel()
    
    // MARK: - UI Components
    private let incomeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "00A86B")
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -3)
        view.layer.shadowRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let expenseView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "FD3C4A")
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -3)
        view.layer.shadowRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let incomeIconView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let accountBalanceLabel = CustomLabel(text: "Account Balance", textColor: .systemGray2, font: UIFont.systemFont(ofSize: 18, weight: .semibold))
    private let expenceIconView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let incomeAmount = CustomLabel(text: "0", textColor: .white, font: UIFont.systemFont(ofSize: 16, weight: .regular)
    )
    private let accountBalanceAmount = CustomLabel(text: "Rs 0", textColor: .black, font: UIFont.systemFont(ofSize: 35, weight: .bold)
    )
    private let expenseAmount = CustomLabel(text: "0", textColor: .white, font: UIFont.systemFont(ofSize: 16, weight: .regular)
    )
    private let incomeLabel = CustomLabel(text: "Income", textColor: .white, font: UIFont.systemFont(ofSize: 18, weight: .semibold))
    private let expenseLabel = CustomLabel(text: "Expense", textColor: .white, font: UIFont.systemFont(ofSize: 18, weight: .semibold))
    private let incomeImage = CustomImageView(imageName: "IncomeIcon")
    private let expenseImage = CustomImageView(imageName: "ExpenseIcon")
    private let currencyLabel = CustomLabel(text: "Rs", textColor: .white, font: UIFont.systemFont(ofSize: 17, weight: .regular))
    private let currencyLabel2 = CustomLabel(text: "Rs", textColor: .white, font: UIFont.systemFont(ofSize: 17, weight: .regular))
    private let tableView = UITableView()
    private let notificationImage = CustomImageView(imageName: "notifiactionIcon")
    private var collectionView: UICollectionView!
    private let options = ["Today", "Week", "Month", "Year"]
    private var showExpenses = false
    private var selectedIndex = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "FFF6E5")
        setupViews()
        setupCollectionView()
        setupExpenseTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadExpenses()
    }
    
    // MARK: - Functions
    private func setupViews(){
        view.addSubview(incomeView)
        view.addSubview(expenseView)
        view.addSubview(notificationImage)
        view.addSubview(accountBalanceLabel)
        view.addSubview(accountBalanceAmount)
        incomeView.addSubview(incomeIconView)
        expenseView.addSubview(expenceIconView)
        incomeIconView.addSubview(incomeImage)
        expenceIconView.addSubview(expenseImage)
        incomeView.addSubview(incomeLabel)
        incomeView.addSubview(currencyLabel)
        incomeView.addSubview(incomeAmount)
        expenseView.addSubview(expenseAmount)
        expenseView.addSubview(expenseLabel)
        expenseView.addSubview(currencyLabel2)
        
        NSLayoutConstraint.activate([
            incomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            incomeView.heightAnchor.constraint(equalToConstant: 90),
            incomeView.widthAnchor.constraint(equalToConstant: 175),
            incomeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
            expenseView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            expenseView.heightAnchor.constraint(equalToConstant: 90),
            expenseView.widthAnchor.constraint(equalToConstant: 175),
            expenseView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
            incomeIconView.leadingAnchor.constraint(equalTo: incomeView.leadingAnchor, constant: 16),
            incomeIconView.heightAnchor.constraint(equalToConstant: 55),
            incomeIconView.widthAnchor.constraint(equalToConstant: 55),
            incomeIconView.topAnchor.constraint(equalTo: incomeView.topAnchor, constant: 18),
            
            expenceIconView.leadingAnchor.constraint(equalTo: expenseView.leadingAnchor, constant: 16),
            expenceIconView.heightAnchor.constraint(equalToConstant: 55),
            expenceIconView.widthAnchor.constraint(equalToConstant: 55),
            expenceIconView.topAnchor.constraint(equalTo: expenseView.topAnchor, constant: 18),
            
            incomeLabel.leadingAnchor.constraint(equalTo: incomeIconView.trailingAnchor, constant: 4),
            incomeLabel.topAnchor.constraint(equalTo: incomeIconView.topAnchor, constant: 3),
            
            notificationImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            notificationImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            
            expenseImage.centerXAnchor.constraint(equalTo: expenceIconView.centerXAnchor),
            expenseImage.centerYAnchor.constraint(equalTo: expenceIconView.centerYAnchor),
            
            incomeImage.centerXAnchor.constraint(equalTo: incomeIconView.centerXAnchor),
            incomeImage.centerYAnchor.constraint(equalTo: incomeIconView.centerYAnchor),
            
            currencyLabel.leadingAnchor.constraint(equalTo: incomeIconView.trailingAnchor, constant: 4),
            currencyLabel.topAnchor.constraint(equalTo: incomeIconView.topAnchor, constant: 32),
            
            incomeAmount.leadingAnchor.constraint(equalTo: currencyLabel.trailingAnchor, constant: 1),
            incomeAmount.topAnchor.constraint(equalTo: incomeIconView.topAnchor, constant: 34),
            
            expenseLabel.leadingAnchor.constraint(equalTo: expenceIconView.trailingAnchor, constant: 4),
            expenseLabel.topAnchor.constraint(equalTo: expenceIconView.topAnchor, constant: 3),
            
            currencyLabel2.leadingAnchor.constraint(equalTo: expenceIconView.trailingAnchor, constant: 4),
            currencyLabel2.topAnchor.constraint(equalTo: expenceIconView.topAnchor, constant: 32),
            
            expenseAmount.leadingAnchor.constraint(equalTo: currencyLabel2.trailingAnchor, constant: 1),
            expenseAmount.topAnchor.constraint(equalTo: expenceIconView.topAnchor, constant: 34),
            
            accountBalanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountBalanceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            accountBalanceAmount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountBalanceAmount.topAnchor.constraint(equalTo: accountBalanceLabel.topAnchor, constant: 2),
            accountBalanceAmount.bottomAnchor.constraint(equalTo: incomeView.topAnchor, constant: -2),
        ])
    }
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TimeCollectionViewCell.self, forCellWithReuseIdentifier: "TimeCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: incomeView.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    private func setupExpenseTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(DashboardExpenseListTableView.self, forCellReuseIdentifier: "DashboardExpenseListTableView")
        tableView.register(DashboardIncomeListTableview.self, forCellReuseIdentifier: "DashboardIncomeListTableview")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -92),
        ])
    }
    private func loadExpenses() {
        let selectedOption = options[selectedIndex]
        viewModel.loadData(for: selectedOption)
        updateUI()
    }
    private func updateUI() {
        incomeAmount.text = "\(viewModel.totalIncome)"
        expenseAmount.text = "\(viewModel.totalExpenses)"
        accountBalanceAmount.text = "Rs\(viewModel.accountBalance)"
        tableView.reloadData()
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView Methods
extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCollectionViewCell", for: indexPath) as! TimeCollectionViewCell
        cell.configure(text: options[indexPath.item], isSelected: indexPath.item == selectedIndex)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        let selectedOption = options[selectedIndex]
        viewModel.loadData(for: selectedOption)
        updateUI()
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 40)
    }
}

// MARK: - UITableView Methods
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.expenses.count + viewModel.incomes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Check whether the current index is for an expense or an income
        if indexPath.row < viewModel.expenses.count {
            // Configure expense cell
            let expenseCell = tableView.dequeueReusableCell(withIdentifier: "DashboardExpenseListTableView", for: indexPath) as! DashboardExpenseListTableView
            let expense = viewModel.expenses[indexPath.row]
            expenseCell.configureExpense(with: expense)
            return expenseCell
        } else {
            // Configure income cell
            let incomeCell = tableView.dequeueReusableCell(withIdentifier: "DashboardIncomeListTableview", for: indexPath) as! DashboardIncomeListTableview
            let income = viewModel.incomes[indexPath.row - viewModel.expenses.count]  // Adjust index to income's range
            incomeCell.configure(with: income)
            return incomeCell
        }
    }
}
