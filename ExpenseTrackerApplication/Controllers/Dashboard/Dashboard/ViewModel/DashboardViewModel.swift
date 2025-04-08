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
    
    // MARK: - Fetch Expenses and Incomes
    func loadData(for option: String) {
        switch option {
        case "Today":
            expenses = CoreDataManager.shared.fetchTodayExpense() ?? []
            incomes = CoreDataManager.shared.fetchTodayIncome() ?? []
        case "Week":
            expenses = CoreDataManager.shared.fetchWeeklyExpenses() ?? []
            incomes = CoreDataManager.shared.fetchWeeklyIncome() ?? []
        case "Month":
            expenses = CoreDataManager.shared.fetchMonthlyExpenses() ?? []
            incomes = CoreDataManager.shared.fetchMonthlyIncome() ?? []
        case "Year":
            expenses = CoreDataManager.shared.fetchYearlyExpenses() ?? []
            incomes = CoreDataManager.shared.fetchYearlyIncome() ?? []
        default:
            expenses = []
            incomes = []
        }
        print("Loaded \(expenses.count) expenses and \(incomes.count) incomes for \(option)")
    }
}
