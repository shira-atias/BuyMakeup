//
//  CoreDataManager.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 07/08/2021.
//

import Foundation
import CoreData
class CoreDataManager {
    
    
    static let shared = CoreDataManager()
    var context:NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    // MARK: - Core Data stack

    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Buy_Makeup")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
             
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    // MARK: - Core Data function
    
    func fetchProducts() ->[ProductD]{
        let reqest:NSFetchRequest<ProductD> = ProductD.fetchRequest()
        guard let reqests = try? context.fetch(reqest) else {
            return []
        }
        return reqests
    }
    
    func fetchProductsForView() ->[Product]{
        let reqest:NSFetchRequest<ProductD> = ProductD.fetchRequest()
        guard let reqests = try? context.fetch(reqest) else {
            return []
        }
        let ret = reqests.compactMap { p in
            return Product(productD: p)
        }
        return ret
      
    }
    
    func add(product: ProductD){
        let products = fetchProducts()
          products.forEach { x in
              if x.id != product.id{
                  saveContext()
              }
          }
    }
    func delete(product: Product){
        let products = fetchProducts()
       guard let toDelete  = (products.first { x in
            x.id == product.id
       }) else {return}
        context.delete(toDelete)
        saveContext()
    }
    
    func isExists(product:Product) -> Bool {
        let products = fetchProducts()
        var exists:Bool = false
        products.forEach { x in
            if x.id == product.id{
                exists = true
            }
        }
        return exists
    }
    func isExists(product:ProductD) -> Bool {
        let products = fetchProducts()
        var exists:Bool = false
        products.forEach { x in
            if x.id == product.id{
                exists = true
            }
        }
        return exists
    }

}
