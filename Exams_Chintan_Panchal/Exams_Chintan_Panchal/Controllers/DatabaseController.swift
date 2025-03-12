//
//  DatabaseController.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//

import CoreData

class DatabaseController: ObservableObject {
    let container: NSPersistentContainer
    @Published var favoriteNetworks: [Favorites] = []
    
    init() {
        container = NSPersistentContainer(name: "BikeModel")
        container.loadPersistentStores { description , error in
            if let error = error {
                print("Core Data Error: \(error)")
            } else {
                print("Core Data Loaded: \(description)")
            }
        }
    }
    
    func saveFavorite(bike: Bike) {
        let context = container.viewContext
        guard !isFavorite(networkId: bike.id) else {
            return
        }
        
        let favorite = NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: context) as! Favorites
        favorite.id = bike.id
        favorite.name = bike.name
        favorite.city = bike.location.city
        favorite.companies = bike.company?.joined(separator: ", ")

        saveAndFetchFavorites()
    }
    
    func fetchFavorites() {
        let request = NSFetchRequest<Favorites>(entityName: "Favorites")
        do {
            favoriteNetworks = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching: \(error)")
        }
    }
    
    func deleteFavorite(_ favorite: Favorites) {
        container.viewContext.delete(favorite)
        saveAndFetchFavorites()
    }
    
    func isFavorite(networkId: String) -> Bool {
        favoriteNetworks.contains { $0.id == networkId }
    }
    
    private func saveAndFetchFavorites() {
        do {
            try container.viewContext.save()
            fetchFavorites()
        } catch {
            print("Error saving: \(error)")
        }
    }
}
