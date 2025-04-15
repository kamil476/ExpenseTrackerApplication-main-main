//
//  BudgetHistoryViewModel.swift
//  ExpenseTrackerApplication
//
//  Created by APPLE on 08/04/2025.
//

import Foundation

class BudgetHistoryViewModel {
    
    var dataByDate: [(date: String, entries: [(type: String, data: Any)])] = [] // Holds both expenses and incomes under each date
    var selectedFilter: String?
    var selectedSort: String?
    private let dateFormatter: DateFormatter

    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMMM-yyyy"
    }
    func fetchData(completion: @escaping () -> Void) {
        var allEntries: [(String, Any)] = [] // Holds both expenses and incomes
        // Fetch expenses
        if let fetchedExpenses = CoreDataManager.shared.fetchAllExpenses() {
            for expense in fetchedExpenses {
                allEntries.append(("expense", expense))
            }
        }
        // Fetch incomes
        if let fetchedIncomes = CoreDataManager.shared.fetchAllIncomes() {
            for income in fetchedIncomes {
                allEntries.append(("income", income))
            }
        }
        // Grouping data by date
        let groupedData = Dictionary(grouping: allEntries) { entry -> String in
            if let expense = entry.1 as? Expense {
                return dateFormatter.string(from: expense.expenseDate ?? Date())
            } else if let income = entry.1 as? Income {
                return dateFormatter.string(from: income.incomeDate ?? Date())
            }
            return ""
        }
        dataByDate = groupedData.map { (date, entries) in
            return (date, entries)
        }.sorted { $0.date > $1.date } // Sorting date in descending order
        completion()
   }
    func applyFilterAndSort(completion: @escaping () -> Void) {
        fetchData {
            // Filter
            if let filter = self.selectedFilter {
                self.dataByDate = self.dataByDate.map { (date, entries) in
                    let filteredEntries = entries.filter { $0.type.lowercased() == filter.lowercased() }
                    return (date, filteredEntries)
                }.filter { !$0.entries.isEmpty }
            }
            // Sorting
            if let sort = self.selectedSort {
                switch sort {
                case "Highest":
                    self.dataByDate = self.dataByDate.map { (date, entries) in
                        let sorted = entries.sorted {
                            let amount1 = self.getAmount(from: $0.data)
                            let amount2 = self.getAmount(from: $1.data)
                            return amount1 > amount2
                        }
                        return (date, sorted)
                    }
                case "Lowest":
                    self.dataByDate = self.dataByDate.map { (date, entries) in
                        let sorted = entries.sorted {
                            let amount1 = self.getAmount(from: $0.data)
                            let amount2 = self.getAmount(from: $1.data)
                            return amount1 < amount2
                        }
                        return (date, sorted)
                    }
                case "Newest":
                    self.dataByDate.sort {
                        guard let date1 = self.dateFormatter.date(from: $0.date),
                              let date2 = self.dateFormatter.date(from: $1.date) else { return false }
                        return date1 > date2
                    }
                case "Oldest":
                    self.dataByDate.sort {
                        guard let date1 = self.dateFormatter.date(from: $0.date),
                              let date2 = self.dateFormatter.date(from: $1.date) else { return false }
                        return date1 < date2
                    }
                default:
                    break
                }
            }
            completion()
        }
    }
    func getAmount(from entry: Any) -> Double {
        if let expense = entry as? Expense {
            return expense.expenseAmount
        } else if let income = entry as? Income {
            return income.incomeAmount
        }
        return 0.0
    }
    func removeEntry(at indexPath: IndexPath) {
        let entry = dataByDate[indexPath.section].entries[indexPath.row]
        // Delete from CoreData
        if entry.type == "expense", let expense = entry.data as? Expense {
            CoreDataManager.shared.deleteExpense(expense)
        } else if entry.type == "income", let income = entry.data as? Income {
            CoreDataManager.shared.deleteIncome(income)
        }
        // Remove from local data array
        dataByDate[indexPath.section].entries.remove(at: indexPath.row)
        // If section is empty after deletion, remove the section
        if dataByDate[indexPath.section].entries.isEmpty {
            dataByDate.remove(at: indexPath.section)
        }
    }
}

