//
//  CoreDataManager.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 19/03/2025.
//

import Foundation
import CoreData

class CoreDataManager {
    // Singleton instance
    static let shared = CoreDataManager()
    // Managed Object Context
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    // Persistent Container
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    // MARK: - Save Expense
    func saveExpense(expenseAmount: Double, expenseCategory: String, expenseDate: Date, expenseDetails: String, isIncome: Bool) {
        // Create a new object
        let expenseEntity = Expense(context: context)
        // Set the properties of the entity
        expenseEntity.expenseAmount = expenseAmount
        expenseEntity.expenseCategory = expenseCategory
        expenseEntity.expenseDate = expenseDate
        expenseEntity.expenseDetails = expenseDetails
        expenseEntity.isIncome = isIncome
        // Save to persist the data
        saveContext()
    }
    
    // MARK: - Save Income
    func saveIncome(incomeAmount: Double, incomeCategory: String, incomeDate: Date, incomeDetails: String) {
        // Create a new object
        let incomeEntity = Income(context: context)
        // Set the properties of the entity
        incomeEntity.incomeAmount = incomeAmount
        incomeEntity.incomeCategory = incomeCategory
        incomeEntity.incomeDate = incomeDate
        incomeEntity.incomeDetails = incomeDetails
        // Save to persist the data
        saveContext()
    }
    
    // MARK: - Fetch All Expenses
    func fetchAllExpenses() -> [Expense]? {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch all expenses: \(error)")
            return nil
        }
    }

    // MARK: - Fetch All Incomes
    func fetchAllIncomes() -> [Income]? {
        let fetchRequest: NSFetchRequest<Income> = Income.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch all incomes: \(error)")
            return nil
        }
    }
    func fetchTodayExpense() -> [Expense]? {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date()) // Current din ka start time
        fetchRequest.predicate = NSPredicate(format: "expenseDate >= %@", todayStart as NSDate) // Filter
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch today's drinks: \(error)")
            return nil
        }
    }
    func fetchTodayIncome() -> [Income]? {
        let fetchRequest: NSFetchRequest<Income> = Income.fetchRequest()
        
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date()) // Current din ka start time
        fetchRequest.predicate = NSPredicate(format: "incomeDate >= %@", todayStart as NSDate) // Filter
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch today's drinks: \(error)")
            return nil
        }
    }
    
    // MARK: - Fetch Weekly Expenses
    func fetchWeeklyExpenses() -> [Expense]? {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        let calendar = Calendar.current
        let today = Date()
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: today)?.start else { return nil }
        
        fetchRequest.predicate = NSPredicate(format: "expenseDate >= %@", startOfWeek as NSDate)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch weekly expenses: \(error)")
            return nil
        }
    }
    
    // MARK: - Fetch Monthly Expenses
    func fetchMonthlyExpenses() -> [Expense]? {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        let calendar = Calendar.current
        let today = Date()
        guard let startOfMonth = calendar.dateInterval(of: .month, for: today)?.start else { return nil }
        
        fetchRequest.predicate = NSPredicate(format: "expenseDate >= %@", startOfMonth as NSDate)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch monthly expenses: \(error)")
            return nil
        }
    }
    
    // MARK: - Fetch Yearly Expenses
    func fetchYearlyExpenses() -> [Expense]? {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        let calendar = Calendar.current
        let today = Date()
        guard let startOfYear = calendar.dateInterval(of: .year, for: today)?.start else { return nil }
        
        fetchRequest.predicate = NSPredicate(format: "expenseDate >= %@", startOfYear as NSDate)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch yearly expenses: \(error)")
            return nil
        }
    }
    
    // MARK: - Fetch Weekly Income
    func fetchWeeklyIncome() -> [Income]? {
        let fetchRequest: NSFetchRequest<Income> = Income.fetchRequest()
        let calendar = Calendar.current
        let today = Date()
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: today)?.start else { return nil }
        
        fetchRequest.predicate = NSPredicate(format: "incomeDate >= %@", startOfWeek as NSDate)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch weekly income: \(error)")
            return nil
        }
    }
    
    // MARK: - Fetch Monthly Income
    func fetchMonthlyIncome() -> [Income]? {
        let fetchRequest: NSFetchRequest<Income> = Income.fetchRequest()
        let calendar = Calendar.current
        let today = Date()
        guard let startOfMonth = calendar.dateInterval(of: .month, for: today)?.start else { return nil }
        
        fetchRequest.predicate = NSPredicate(format: "incomeDate >= %@", startOfMonth as NSDate)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch monthly income: \(error)")
            return nil
        }
    }
    
    // MARK: - Fetch Yearly Income
    func fetchYearlyIncome() -> [Income]? {
        let fetchRequest: NSFetchRequest<Income> = Income.fetchRequest()
        let calendar = Calendar.current
        let today = Date()
        guard let startOfYear = calendar.dateInterval(of: .year, for: today)?.start else { return nil }
        
        fetchRequest.predicate = NSPredicate(format: "incomeDate >= %@", startOfYear as NSDate)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch yearly income: \(error)")
            return nil
        }
    }
    
    // MARK: - Save Context
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
