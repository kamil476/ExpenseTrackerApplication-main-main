//
//  DashboardViewModel.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 28/03/2025.
//

import Foundation

class DashboardViewModel {
    
    var expenses: [Expense] = []
    var incomes: [Income] = []
    
    // MARK: - Properties for Total Calculation
    var totalIncome: Double {
        return calculateTotalIncome()
    }
    var totalExpenses: Double {
        return calculateTotalExpenses()
    }
    var accountBalance: Double {
        return totalIncome - totalExpenses
    }
    
    // MARK: - Functions to Calculate Totals
    func calculateTotalIncome() -> Double {
        return incomes.reduce(0) { result, income in
            return result + income.incomeAmount
        }
    }
    func calculateTotalExpenses() -> Double {
        return expenses.reduce(0) { result, expense in
            return result + expense.expenseAmount
        }
    }
    
    // MARK: - Load All Data and Filter by Option
    func loadDataFiltered(for option: String) {
        let allExpenses = CoreDataManager.shared.fetchAllExpenses() ?? []
        let allIncomes = CoreDataManager.shared.fetchAllIncomes() ?? []
        let calendar = Calendar.current
        let today = Date()
        
        switch option {
        case "Today":
            expenses = allExpenses.filter { calendar.isDate($0.expenseDate ?? Date(), inSameDayAs: today) }
            incomes = allIncomes.filter { calendar.isDate($0.incomeDate ?? Date(), inSameDayAs: today) }
        case "Week":
            if let weekAgo = calendar.date(byAdding: .day, value: -7, to: today) {
                expenses = allExpenses.filter {
                    guard let date = $0.expenseDate else { return false }
                    return date >= weekAgo && date <= today
                }
                incomes = allIncomes.filter {
                    guard let date = $0.incomeDate else { return false }
                    return date >= weekAgo && date <= today
                }
            }
        case "Month":
            if let monthAgo = calendar.date(byAdding: .month, value: -1, to: today) {
                expenses = allExpenses.filter {
                    guard let date = $0.expenseDate else { return false }
                    return date >= monthAgo && date <= today
                }
                incomes = allIncomes.filter {
                    guard let date = $0.incomeDate else { return false }
                    return date >= monthAgo && date <= today
                }
            }
        case "Year":
            if let yearAgo = calendar.date(byAdding: .year, value: -1, to: today) {
                expenses = allExpenses.filter {
                    guard let date = $0.expenseDate else { return false }
                    return date >= yearAgo && date <= today
                }
                incomes = allIncomes.filter {
                    guard let date = $0.incomeDate else { return false }
                    return date >= yearAgo && date <= today
                }
            }
        default:
            expenses = allExpenses
            incomes = allIncomes
        }
        print("Loaded \(expenses.count) expenses and \(incomes.count) incomes for \(option)")
    }
}
