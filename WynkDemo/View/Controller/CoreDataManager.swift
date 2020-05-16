//
//  CoreDataManager.swift
//  WynkDemo
//
//  Created by Smriti on 16/05/20.
//  Copyright © 2020 Smriti. All rights reserved.
//

import Foundation

class CoreDataManager{
    
    static let sharedManager = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
      
      let container = NSPersistentContainer(name: "PersonData")
      
      
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      })
      return container
    }()
    
    //3
    func saveContext () {
      let context = CoreDataManager.sharedManager.persistentContainer.viewContext
      if context.hasChanges {
        do {
          try context.save()
        } catch {
          // Replace this implementation with code to handle the error appropriately.
          // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
          let nserror = error as NSError
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
 
    }
    func insertPerson(text: String)->Result? {
      
      let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
  
      let result = Result(context: managedContext)
      
      
      /*
       You commit your changes to person and save to disk by calling save on the managed object context. Note save can throw an error, which is why you call it using the try keyword within a do-catch block. Finally, insert the new managed object into the people array so it shows up when the table view reloads.
       */
      do {
        try managedContext.save()
        return person as? Result
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
        return nil
      }
    }
}
