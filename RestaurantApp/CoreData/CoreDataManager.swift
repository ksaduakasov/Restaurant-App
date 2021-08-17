//
//  CoreDataManager.swift
//  RestaurantApp
//
//  Created by Kalbek Saduakassov on 14.05.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "RestaurantApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
    func save() {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func addFood(_ food: MenuModel.Entities.Menu.Section.MenuItem) {
        let context = persistentContainer.viewContext
        context.perform {
            let newFood = MenuEntity(context: context)
            newFood.name = food.itemName
            newFood.desc = food.description
            newFood.price = food.price!
        }
        save()
    }

//    func addFood(_ movie: DetailEntity) {
//        let context = persistentContainer.viewContext
//        context.perform {
//            let newMovie = MovieEntity(context: context)
//            newMovie.id = Int64(movie.id ?? 0)
//            newMovie.title = movie.title
//        }
//        save()
//    }
    
    func findFood(with name: String) -> MenuEntity? {
        let context = persistentContainer.viewContext
        let requestResult: NSFetchRequest<MenuEntity> = MenuEntity.fetchRequest()
        requestResult.predicate = NSPredicate(format: "name == %s", name)
        do {
            let games = try context.fetch(requestResult)
            if games.count > 0 {
                assert(games.count == 1, "Dubplicate found in DB!")
//                print(games.last?.id)
                return games[0]
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func deleteFood(with name: String) {
        let context = persistentContainer.viewContext
        if let food = findFood(with: name) {
            print("success")
            context.delete(food)
        } else {
            print("fail!")
        }
        save()
    }
    
    func allMovies() -> [MenuModel.Entities.Menu.Section.MenuItem] {
        let context = persistentContainer.viewContext
        let requestResult: NSFetchRequest<MenuEntity> = MenuEntity.fetchRequest()
        let food = try? context.fetch(requestResult)
        return food?.map {( MenuModel.Entities.Menu.Section.MenuItem(food: $0) )} ?? []
    }
    
    
}

