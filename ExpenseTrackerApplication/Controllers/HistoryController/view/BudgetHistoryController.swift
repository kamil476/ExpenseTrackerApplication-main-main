//
//  ProfileController.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 18/03/2025.
//

import UIKit

class BudgetHistoryController: UIViewController {
    
    private let viewModel = BudgetHistoryViewModel()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let bottomSheetContainer = UIView()
    private lazy var filterButton = CustomButton(imageName: "filterIcon",target: self, action: #selector(openFilterBottomSheet))
    private lazy var refreshButton = CustomButton(imageName: "refreshIcon",target: self, action: #selector(refreshButtonAction))
    private let filterOptions = ["Income", "Expense"]
    private let sortOptions = ["Highest", "Lowest", "Newest", "Oldest"]
    private var selectedFilterButton: UIButton?
    private var selectedSortButton: UIButton?
    private let filterStack = UIStackView()
    private let sortStack = UIStackView()
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        return lbl
    }()
    private let sectionTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return lbl
    }()
    private lazy var resetButton = CustomButton(title: "Reset", titleColor: UIColor(hex: "7F3DFF"),target: self, action: #selector(resetTapped))
    private lazy var applyButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Apply", for: .normal)
        btn.backgroundColor = UIColor(hex: "7F3DFF")
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.addTarget(self, action: #selector(applyTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupFilterAndTableView()
        bindViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        dismissBottomSheet()
    }
    
    private func fetchData() {
        viewModel.fetchData {
            self.tableView.reloadData()
        }
    }
    private func bindViewModel() {
        // Bind view model properties to UI updates
        viewModel.fetchData {
            self.tableView.reloadData()
        }
    }
    private func setupFilterAndTableView() {
        // Add buttons first
        view.addSubview(filterButton)
        view.addSubview(refreshButton)
        view.addSubview(tableView)
        
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Filter Button
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filterButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            filterButton.heightAnchor.constraint(equalToConstant: 40),
            filterButton.widthAnchor.constraint(equalToConstant: 40),
            
            // Refresh Button
            refreshButton.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -10),
            refreshButton.centerYAnchor.constraint(equalTo: filterButton.centerYAnchor),
            refreshButton.heightAnchor.constraint(equalToConstant: 26),
            refreshButton.widthAnchor.constraint(equalToConstant: 26),
            
            // TableView (positioned below the filterButton)
            tableView.topAnchor.constraint(equalTo: filterButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -55)
        ])

        tableView.register(DashboardExpenseListTableView.self, forCellReuseIdentifier: "DashboardExpenseListTableView")
        tableView.register(DashboardIncomeListTableview.self, forCellReuseIdentifier: "DashboardIncomeListTableview")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    private func setupBottomSheet() {
        // Bottom sheet container
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissBottomSheet))
        swipeGesture.direction = .down
        bottomSheetContainer.addGestureRecognizer(swipeGesture)
        bottomSheetContainer.backgroundColor = .white
        bottomSheetContainer.layer.cornerRadius = 16
        bottomSheetContainer.clipsToBounds = true
        bottomSheetContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomSheetContainer)
        let height: CGFloat = 300
        
        NSLayoutConstraint.activate([
            bottomSheetContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            bottomSheetContainer.heightAnchor.constraint(equalToConstant: height)
        ])
        // Start off-screen
        bottomSheetContainer.transform = CGAffineTransform(translationX: 0, y: height)
        setupBottomSheetContent()
    }
    
    private func setupBottomSheetContent() {
        bottomSheetContainer.subviews.forEach { $0.removeFromSuperview() }
        filterStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        sortStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let resetBtn = resetButton
        sectionTitleLabel.text = "Filter By"
        configureStackView(filterStack, with: filterOptions, action: #selector(filterTapped(_:)))
        sectionTitleLabel.text = "Sort By"
        configureStackView(sortStack, with: sortOptions, action: #selector(sortTapped(_:)))
        let applyBtn = applyButton
        
        let mainStack = UIStackView(arrangedSubviews: [
            titleLabel,
            resetBtn,
            sectionTitleLabel,
            filterStack,
            sectionTitleLabel,
            sortStack,
            applyBtn
        ])
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetContainer.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: bottomSheetContainer.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: bottomSheetContainer.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: bottomSheetContainer.trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomSheetContainer.bottomAnchor, constant: -20)
        ])
    }
    private func select(button: UIButton, in stack: UIStackView) {
        for case let btn as UIButton in stack.arrangedSubviews {
            btn.backgroundColor = .white
            btn.setTitleColor(.black, for: .normal)
        }
        button.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.2)
        button.setTitleColor(UIColor(hex: "7F3DFF"), for: .normal)
    }
    private func configureStackView(_ stack: UIStackView, with items: [String], action: Selector) {
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        for item in items {
            let btn = UIButton(type: .system)
            btn.setTitle(item, for: .normal)
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.borderWidth = 1
            btn.layer.cornerRadius = 8
            btn.setTitleColor(.black, for: .normal)
            btn.addTarget(self, action: action, for: .touchUpInside)
            stack.addArrangedSubview(btn)
        }
    }
    @objc private func resetTapped() {
        for case let btn as UIButton in filterStack.arrangedSubviews {
            btn.backgroundColor = .white
            btn.setTitleColor(.black, for: .normal)
        }
        for case let btn as UIButton in sortStack.arrangedSubviews {
            btn.backgroundColor = .white
            btn.setTitleColor(.black, for: .normal)
        }
        viewModel.selectedFilter = nil
        viewModel.selectedSort = nil
    }
    @objc private func applyTapped() {
        viewModel.applyFilterAndSort {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.dismissBottomSheet()
            }
        }
    }
    @objc func openFilterBottomSheet() {
        setupBottomSheet()
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetContainer.transform = .identity
        }
    }
    @objc func dismissBottomSheet() {
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomSheetContainer.frame.origin.y = self.view.frame.height
        })
    }
    @objc private func filterTapped(_ sender: UIButton) {
        select(button: sender, in: filterStack)
        viewModel.selectedFilter = sender.titleLabel?.text
    }
    @objc private func sortTapped(_ sender: UIButton) {
        select(button: sender, in: sortStack)
        viewModel.selectedSort = sender.titleLabel?.text
    }
    @objc private func refreshButtonAction(_ sender: UIButton) {
        viewModel.fetchData {
            self.tableView.reloadData()
        }
        dismissBottomSheet()
    }
}

extension BudgetHistoryController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataByDate.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataByDate[section].entries.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.dataByDate[section].date
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = viewModel.dataByDate[indexPath.section].entries[indexPath.row]
        if entry.type == "expense", let expense = entry.data as? Expense {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardExpenseListTableView", for: indexPath) as! DashboardExpenseListTableView
            cell.configureExpense(with: expense)
            return cell
        } else if entry.type == "income", let income = entry.data as? Income {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardIncomeListTableview", for: indexPath) as! DashboardIncomeListTableview
            cell.configure(with: income)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.contentView.backgroundColor = .white
            header.textLabel?.textColor = .black
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            // Remove from data model
            viewModel.removeEntry(at: indexPath)
            // Handle section deletion if needed
            if viewModel.dataByDate.count > indexPath.section {
                if viewModel.dataByDate[indexPath.section].entries.isEmpty {
                    tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
                } else {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            } else {
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
            }
            tableView.endUpdates()
        }
    }
}
