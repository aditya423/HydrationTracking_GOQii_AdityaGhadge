////
////  DatabaseManager.swift
////  HydrationTracking_GOQii_AdityaGhadge
////
////  Created by Aditya on 28/06/24.
////
//
//import UIKit
//import CoreData
//
//class DatabaseManager {
//    
//    private var context: NSManagedObjectContext {
//        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    }
//    
//    func addUser(user: UserModel) {
//        let registerEntity = RegisterEntity(context: context)
//        registerEntity.firstName = user.firstName
//        registerEntity.lastName = user.lastName
//        registerEntity.email = user.email
//        registerEntity.password = user.password
//        registerEntity.imageName = user.imageName
//        saveContext()
//    }
//    
//    func updateUser(user: UserModel, registerEntity: RegisterEntity) {
//        registerEntity.firstName = user.firstName
//        registerEntity.lastName = user.lastName
//        registerEntity.email = user.email
//        registerEntity.password = user.password
//        registerEntity.imageName = user.imageName
//        saveContext()
//    }
//    
//    func fetchUser() -> [RegisterEntity] {
//        var users: [RegisterEntity] = []
//        do {
//            users = try context.fetch(RegisterEntity.fetchRequest())
//        }
//        catch {
//            print ("Register information fetching error: \(error)")
//        }
//        return users
//    }
//    
//    func deleteUser(registerEntity: RegisterEntity) {
//        let imageURL = URL.documentsDirectory.appending(component: registerEntity.imageName ?? "").appendingPathExtension("png")
//        do {
//            try FileManager.default.removeItem(at: imageURL)
//        }
//        catch {
//            print ("Remove image from coreData error: ", error)
//        }
//        context.delete(registerEntity)
//        saveContext()
//    }
//    
//    private func saveContext() {
//        do {
//            try context.save()
//        }
//        catch {
//            print ("Register information saving error: \(error)")
//        }
//    }
//}
