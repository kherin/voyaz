//
//  LandmarksDataSource.swift
//  voyaz
//
//  Created by Kherin on 05/05/2022.
//

import Foundation
import UIKit
import CoreData

class LandmarksDataSource {
    static var landmarks: [Landmark] = []
    
    static func fetch(appDelegate: AppDelegate, favoritesOnly: Bool = false) -> [Landmark] {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<LandmarkModel>(entityName: "LandmarkModel")
        
        if favoritesOnly {
            fetchRequest.predicate = NSPredicate(format: "isFavorite = %d", true)
        }
        
        do {
            let landmarkModelRecords: [LandmarkModel] = try managedContext.fetch(fetchRequest)
            landmarks = landmarkModelRecords.map { toLandmark(landmarkModelRecord: $0) }
            
            return landmarks
        } catch let error as NSError {
            print("Could not fetch landmarks. Error: \(error), \(error.userInfo)")
            return []
        }
    }
    
    static func toLandmark(landmarkModelRecord: LandmarkModel) -> Landmark {
        return Landmark(
            id: landmarkModelRecord.id ?? "",
            name: landmarkModelRecord.name ?? "",
            district: landmarkModelRecord.district ?? "",
            location: landmarkModelRecord.location ?? "",
            primaryImagePath: landmarkModelRecord.primaryImagePath ?? "",
            mapImagePath: landmarkModelRecord.mapImagePath ?? "",
            placeDescription: landmarkModelRecord.placeDescription ?? "",
            isFavorite: landmarkModelRecord.isFavorite,
            category: landmarkModelRecord.category ?? ""
        )
    }
    
    static func setAsFavorite(appDelegate: AppDelegate, landmarkId: String, isFavorite: Bool = false) {
        let fetchRequest = NSFetchRequest<LandmarkModel>(entityName: "LandmarkModel")
        fetchRequest.predicate = NSPredicate(format: "id = %@", landmarkId)
        
        do {
            let managedContext = appDelegate.persistentContainer.newBackgroundContext()
            let fetchedLandmarks: [LandmarkModel] = try managedContext.fetch(fetchRequest)
            let managedObject = fetchedLandmarks[0]
            managedObject.setValue(isFavorite, forKey: "isFavorite")
            print("managedObject: \(managedObject)")
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not set landmark Id: \(landmarkId) as favorite: Error: \(error)")
        }
    }
    
    static func preload(appDelegate: AppDelegate) {
        let backgroundContext = appDelegate.persistentContainer.newBackgroundContext()
        for landmarkMock in MockedData().landmarks {
            let landmarkObject = LandmarkModel(context: backgroundContext)
            landmarkObject.id = landmarkMock.id
            landmarkObject.name = landmarkMock.name
            landmarkObject.category = landmarkMock.category
            landmarkObject.district = landmarkMock.district
            landmarkObject.location = landmarkMock.location
            landmarkObject.isFavorite = landmarkMock.isFavorite
            landmarkObject.mapImagePath = landmarkMock.mapImagePath
            landmarkObject.placeDescription = landmarkMock.placeDescription
            landmarkObject.primaryImagePath = landmarkMock.primaryImagePath
        }
        
        do {
            print("Saving landmarks data...")
            try backgroundContext.save()
            
            // fetching landmarks data from Core Data
            let _ = fetch(appDelegate: appDelegate)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func getCount(appDelegate: AppDelegate, onlyFavorites: Bool = false) -> Int {
        if onlyFavorites {
            return getAllFavoritesCount(appDelegate: appDelegate)
        } else {
            return getAllCount(appDelegate: appDelegate)
        }
    }
    
    // fetch count for all landmarks from Core Data
    static func getAllCount(appDelegate: AppDelegate, favoritesOnly: Bool = false) -> Int {
        let fetchRequest = NSFetchRequest<LandmarkModel>(entityName: "LandmarkModel")
        if favoritesOnly {
            fetchRequest.predicate = NSPredicate(format: "isFavorite = %d", true)
        }
        
        do {
            let context = appDelegate.persistentContainer.viewContext
            let landmarksCount: Int = try context.count(for: fetchRequest)
            return landmarksCount
        } catch let error as NSError {
            print("Could not count for all landmarks. Error: \(error)")
            return 0
        }
    }
    
    // fetch count for all favorite landmarks from Core Data
    static func getAllFavoritesCount(appDelegate: AppDelegate) -> Int {
        return getAllCount(appDelegate: appDelegate, favoritesOnly: true)
    }
    
    // fetch count by landmark category
    static func getCountByCategory(appDelegate: AppDelegate, category: String = "") -> Int {
        return LandmarksDataSource
            .fetchAllLandmarks(appDelegate: appDelegate, favoritesOnly: false)
            .filter { $0.category == category }.count
    }
    
    // fetch all landmarks from Core Data
    static func fetchAllLandmarks(appDelegate: AppDelegate, favoritesOnly: Bool = false) -> [Landmark] {
        return fetch(appDelegate: appDelegate)
    }
    
    // fetch all favorite landmarks from Core Data
    static func fetchAllFavoriteLandmarks(appDelegate: AppDelegate) -> [Landmark] {
        return fetch(appDelegate: appDelegate, favoritesOnly: true)
    }
    
    static func landmark(appDelegate: AppDelegate, at indexPath: IndexPath, onlyFavorites: Bool = false) -> Landmark {
        if onlyFavorites {
            let favoriteLandmarks: Landmark = fetchAllFavoriteLandmarks(appDelegate: appDelegate)[indexPath.row]
            return favoriteLandmarks
        } else {
            let allLandmarks: Landmark = fetchAllLandmarks(appDelegate: appDelegate)[indexPath.row]
            return allLandmarks
        }
    }
    
    static func landmarkByCategory(appDelegate: AppDelegate, at indexPath: IndexPath, category: String) -> Landmark {
        let allLandmarks: [Landmark] = fetchAllLandmarks(appDelegate: appDelegate).filter { $0.category == category }
        return allLandmarks[indexPath.row]
    }
    
    static func getCategories() -> [String] {
        return MockedData().categories
    }
    
    static func filterFavorites() -> [Landmark] {
        landmarks.filter { $0.isFavorite }
    }
}
