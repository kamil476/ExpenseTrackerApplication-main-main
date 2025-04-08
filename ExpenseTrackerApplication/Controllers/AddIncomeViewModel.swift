//
//  AddIncomeViewModel.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 24/03/2025.
//

import Foundation

class AddIncomeViewModel {
    
    private var incomeModel: AddIncomeModel
    
    init(incomeModel: AddIncomeModel) {
        self.incomeModel = incomeModel
    }
    
    // MARK: - Binding properties
    var category: String {
        get { return incomeModel.category }
        set { incomeModel.category = newValue }
    }
    
    var description: String {
        get { return incomeModel.description }
        set { incomeModel.description = newValue }
    }
    
    var amount: String {
        get { return incomeModel.amount }
        set { incomeModel.amount = newValue }
    }
    
    var wallet: String {
        get { return incomeModel.wallet }
        set { incomeModel.wallet = newValue }
    }
    
    var attachment: Data? {
        get { return incomeModel.attachment }
        set { incomeModel.attachment = newValue }
    }
    
    // MARK: - Validation
    func validateIncomeData() -> Bool {
        return !category.isEmpty && !description.isEmpty && !amount.isEmpty && !wallet.isEmpty
    }
    
    // MARK: - Data submission
    func submitIncomeData() {
        // Handle submission logic (API call, data persistence, etc.)
        print("Income data submitted: \(incomeModel)")
    }
}
