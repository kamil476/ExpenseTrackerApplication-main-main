//
//  CoreDataManager.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 19/03/2025.
//

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
    func saveExpense(expenseAmount: Double, expenseCategory: String, expenseDate: Date, expenseDetails: String, isIncome: Bool, expensePlaceHolder: Data?) {
        // Creating a new object
        let expenseEntity = Expense(context: context)
        // Setting the properties of the entity
        expenseEntity.expenseAmount = expenseAmount
        expenseEntity.expenseCategory = expenseCategory
        expenseEntity.expenseDate = expenseDate
        expenseEntity.expenseDetails = expenseDetails
        expenseEntity.isIncome = isIncome
        expenseEntity.expensePlaceHolder = expensePlaceHolder
        // Saving to persist the data
        saveContext()
    }
    // MARK: - Save Income
    func saveIncome(incomeAmount: Double, incomeCategory: String, incomeDate: Date, incomeDetails: String, incomePlaceHolder: Data?) {
        // Creating a new object
        let incomeEntity = Income(context: context)
        // Setting the properties of the entity
        incomeEntity.incomeAmount = incomeAmount
        incomeEntity.incomeCategory = incomeCategory
        incomeEntity.incomeDate = incomeDate
        incomeEntity.incomeDetails = incomeDetails
        incomeEntity.incomePlaceHolder = incomePlaceHolder
        // Saving to persist the data
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
    // MARK: - Delete Specific Expense
    func deleteExpense(_ expense: Expense) {
        context.delete(expense)
        saveContext()
    }
    
    // MARK: - Delete Specific Income
    func deleteIncome(_ income: Income) {
        context.delete(income)
        saveContext()
    }
}

