//
//  LandmarksDataSource.swift
//  voyaz
//
//  Created by Kherin on 05/05/2022.
//

import Foundation

class LandmarksDataSource {
    var landmarks: [Landmark] = []
    
    static func fetch() -> [Landmark] {
        // TODO: Remove mocked data afterwards
        MockedData().landmarks
    }
    
    init() {
        landmarks = LandmarksDataSource.fetch()
    }
    
    func getCount(onlyFavorites: Bool = false) -> Int {
        if onlyFavorites {
            return filterFavorites().count
        } else {
            return landmarks.count
        }
    }
    
    func landmark(at indexPath: IndexPath, onlyFavorites: Bool = false) -> Landmark {
        if onlyFavorites {
            return filterFavorites()[indexPath.row]
        } else {
            return landmarks[indexPath.row]
        }
    }
    
    func filterFavorites() -> [Landmark] {
        landmarks.filter { $0.isFavorite }
    }
}
