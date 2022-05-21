//
//  LandmarksDataSource.swift
//  voyaz
//
//  Created by Kherin on 05/05/2022.
//

import Foundation
import CoreData

class LandmarksDataSource {
    static var landmarks: [Landmark] = []
    
    static func fetch(appDelegate: AppDelegate) -> [Landmark] {
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest =
            NSFetchRequest<LandmarkModel>(entityName: "LandmarkModel")
        
        do {
            let landmarkModelRecords = try managedContext.fetch(fetchRequest)
            
            landmarks = landmarkModelRecords.map { (landmarkModelRecord) -> Landmark in
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
            
            print("Fetched landmarks: \(landmarks.count)")
            return landmarks
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    static func preload(appDelegate: AppDelegate) {
        let backgroundContext =
            appDelegate.persistentContainer.newBackgroundContext()
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
            landmarks = fetch(appDelegate: appDelegate)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func getCount(onlyFavorites: Bool = false) -> Int {
        if onlyFavorites {
            return filterFavorites().count
        } else {
            return landmarks.count
        }
    }
    
    static func landmark(at indexPath: IndexPath, onlyFavorites: Bool = false) -> Landmark {
        if onlyFavorites {
            return filterFavorites()[indexPath.row]
        } else {
            return landmarks[indexPath.row]
        }
    }
    
    static func filterFavorites() -> [Landmark] {
        landmarks.filter { $0.isFavorite }
    }
}
