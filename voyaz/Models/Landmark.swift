//
//  Landmark.swift
//  voyaz
//
//  Created by Kherin on 05/05/2022.
//

import Foundation
import CoreData

struct Landmark {
    var id: String
    var name: String
    var district: String
    var location: String
    var primaryImagePath: String
    var mapImagePath: String
    var placeDescription: String
    var isFavorite: Bool
    var category: String
}
