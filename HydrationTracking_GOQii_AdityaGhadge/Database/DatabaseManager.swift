//
//  DatabaseManager.swift
//  HydrationTracking_GOQii_AdityaGhadge
//
//  Created by Aditya on 28/06/24.
//

import UIKit
import CoreData

class DatabaseManager {
    
    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func addLimits(limit: LimitModel) {
        let limitEntity = LimitEntity(context: context)
        limitEntity.dailyTarget = limit.dailyTarget
        limitEntity.dailyProgress = limit.dailyProgress
        saveContext()
    }
    
    func updateLimits(limit: LimitModel, limitEntity: LimitEntity) {
        limitEntity.dailyTarget = limit.dailyTarget
        limitEntity.dailyProgress = limit.dailyProgress
        saveContext()
    }
    
    func fetchLimits() -> [LimitEntity] {
        var limits: [LimitEntity] = []
        do {
            limits = try context.fetch(LimitEntity.fetchRequest())
        }
        catch {
            print ("Register information fetching error: \(error)")
        }
        return limits
    }
    
    func deleteLimits(limitEntity: LimitEntity) {
        context.delete(limitEntity)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        }
        catch {
            print ("Register information saving error: \(error)")
        }
    }
}
