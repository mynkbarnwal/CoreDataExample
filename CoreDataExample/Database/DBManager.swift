//
//  DBManager.swift
//  CoreDataExample
//
//  Created by Mayank Barnwal on 17/07/24.
//

import UIKit
import CoreData


class DBManager: NSObject {
    
    private var context:NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func saveData(_ userData:UserModal){
        let user = User(context:context)
        updateData(userData, user)
    }
    
    func updateData(_ userData:UserModal, _ user:User){
    
        user.name = "\(userData.fName) \(userData.lName)"
        user.emailid = userData.email
        user.password = userData.password
        
        do {
            try context.save()
        }catch{
            print("Error in saving data : \(error)")
        }
    }
    
    func getUsers() -> [User]{
        var userArray:[User] = []
        
        do{
            userArray = try context.fetch(User.fetchRequest())
        }
        catch{
            print("Error in getting users : \(error)")
        }
        
        return userArray
    }
}
